import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:kpop_info/domain/model/group.dart';
import 'package:kpop_info/domain/model/idol.dart';

@singleton
class FirestoreDataSource {
  final FirebaseFirestore firestore;

  FirestoreDataSource(this.firestore);

  Future<List<Group>> getGroups({
    required String lastGroup,
    required int pageSize,
  }) async {
    final query = firestore.collection("groups").orderBy("name");
    final snapshot =
        await (lastGroup.isNotEmpty ? query.startAfter([lastGroup]) : query)
            .limit(pageSize)
            .get();
    return snapshot.docs.map((e) => Group.fromMap(e.data())).toList();
  }

  Future<List<Group>> searchGroups({
    required String search,
    required String lastGroup,
    required int pageSize,
  }) async {
    final query = firestore
        .collection("groups")
        .orderBy("tag")
        .where("tag", isGreaterThanOrEqualTo: search)
        .where("tag", isLessThan: "${search}z");
    final snapshot =
        await (lastGroup.isNotEmpty ? query.startAfter([lastGroup]) : query)
            .limit(pageSize)
            .get();
    return snapshot.docs.map((e) => Group.fromMap(e.data())).toList();
  }

  Future<List<Idol>> getIdols({
    required String lastIdol,
    required int pageSize,
  }) async {
    final query = firestore.collection("idols").orderBy("name");
    final snapshot =
        await (lastIdol.isNotEmpty ? query.startAfter([lastIdol]) : query)
            .limit(pageSize)
            .get();
    return snapshot.docs.map((e) => Idol.fromMap(e.data())).toList();
  }

  Future<List<Idol>> searchIdols({
    required String search,
    required String lastIdol,
    required int pageSize,
  }) async {
    final query = firestore
        .collection("idols")
        .orderBy("name_tag")
        .where("name_tag", isGreaterThanOrEqualTo: search)
        .where("name_tag", isLessThan: "${search}z");
    final snapshot =
        await (lastIdol.isNotEmpty ? query.startAfter([lastIdol]) : query)
            .limit(pageSize)
            .get();
    return snapshot.docs.map((e) => Idol.fromMap(e.data())).toList();
  }
}
