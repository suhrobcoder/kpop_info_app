import 'package:kpop_info/domain/model/group.dart';

abstract class MainRepository {
  Future<List<Group>> getGroups(
      {required String lastGroup, required int pageSize});

  Future<List<Group>> search({
    required String search,
    required String lastGroup,
    required int pageSize,
  });
}
