import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:kpop_info/domain/model/group.dart';
import 'package:kpop_info/domain/model/idol.dart';
import 'package:kpop_info/util/filter_type.dart';

@singleton
class FirestoreDataSource {
  final FirebaseFirestore firestore;

  FirestoreDataSource(this.firestore);

  Future<List<Group>> getGroups({
    required String lastGroup,
    required FilterType filterType,
    required int pageSize,
  }) async {
    var query = firestore.collection("groups").orderBy("name");
    if (filterType != FilterType.all) {
      query = query.where("type",
          isEqualTo: filterType == FilterType.male ? "boy" : "girl");
    }
    final snapshot =
        await (lastGroup.isNotEmpty ? query.startAfter([lastGroup]) : query)
            .limit(pageSize)
            .get();
    return snapshot.docs.map((e) => Group.fromMap(e.data())).toList();
  }

  Future<List<Group>> searchGroups({
    required String search,
    required String lastGroup,
    required FilterType filterType,
    required int pageSize,
  }) async {
    var query = firestore
        .collection("groups")
        .orderBy("tag")
        .where("tag", isGreaterThanOrEqualTo: search.toLowerCase())
        .where("tag", isLessThan: "${search.toLowerCase()}z");
    if (filterType != FilterType.all) {
      query = query.where("type",
          isEqualTo: filterType == FilterType.male ? "boy" : "girl");
    }
    final snapshot =
        await (lastGroup.isNotEmpty ? query.startAfter([lastGroup]) : query)
            .limit(pageSize)
            .get();
    return snapshot.docs.map((e) => Group.fromMap(e.data())).toList();
  }

  Future<List<Idol>> getIdols({
    required String lastIdol,
    required FilterType filterType,
    required int pageSize,
  }) async {
    var query = firestore.collection("idols").orderBy("name");
    query = (lastIdol.isNotEmpty ? query.startAfter([lastIdol]) : query);
    if (filterType != FilterType.all) {
      query = query.where("gender", isEqualTo: filterType.name);
    }
    final snapshot = await query.limit(pageSize).get();
    return snapshot.docs.map((e) => Idol.fromMap(e.data())).toList();
  }

  Future<List<Idol>> searchIdols({
    required String search,
    required String lastIdol,
    required FilterType filterType,
    required int pageSize,
  }) async {
    var query = firestore
        .collection("idols")
        .orderBy("name_tag")
        .where("name_tag", isGreaterThanOrEqualTo: search.toLowerCase())
        .where("name_tag", isLessThan: "${search.toLowerCase()}z");
    if (filterType != FilterType.all) {
      query = query.where("gender", isEqualTo: filterType.name);
    }
    final snapshot =
        await (lastIdol.isNotEmpty ? query.startAfter([lastIdol]) : query)
            .limit(pageSize)
            .get();
    return snapshot.docs.map((e) => Idol.fromMap(e.data())).toList();
  }

  Future<Idol> getIdolByName({
    required String name,
    required String group,
  }) async {
    final snapshot = await firestore
        .collection("idols")
        .where("name", isEqualTo: name)
        .where("groups", arrayContains: group)
        .get();
    return Idol.fromMap(snapshot.docs[0].data());
  }

  Future<QueryDocumentSnapshot<Map<String, dynamic>>> getGroupByName({
    required String name,
  }) async {
    final snapshot = await firestore
        .collection("groups")
        .where("name", isEqualTo: name)
        .get();
    return snapshot.docs[0];
  }

  void setGroupId({
    required String docId,
    required String spotifyId,
  }) async {
    await firestore
        .collection("groups")
        .doc(docId)
        .update({"spotify_id": spotifyId});
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> listenForTokenChanges() =>
      firestore.collection("keys").doc("spotify").snapshots();

  void setTokenAndExpireDate({
    required String token,
    required DateTime expireDate,
  }) async {
    await firestore
        .collection("keys")
        .doc("spotify")
        .update({"token": token, "expire_date": expireDate});
  }
}
