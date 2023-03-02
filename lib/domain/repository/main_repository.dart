import 'package:kpop_info/domain/model/group.dart';
import 'package:kpop_info/domain/model/idol.dart';

abstract class MainRepository {
  Future<List<Group>> getGroups(
      {required String lastGroup, required int pageSize});

  Future<List<Group>> searchGroups({
    required String search,
    required String lastGroup,
    required int pageSize,
  });

  Future<List<Idol>> getIdols(
      {required String lastIdol, required int pageSize});

  Future<List<Idol>> searchIdols({
    required String search,
    required String lastIdol,
    required int pageSize,
  });
}
