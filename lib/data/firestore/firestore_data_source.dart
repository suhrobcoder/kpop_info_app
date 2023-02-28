import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:kpop_info/domain/model/group.dart';

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

  Future<List<Group>> search({
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
}
