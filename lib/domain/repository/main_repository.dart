import 'package:kpop_info/domain/model/group.dart';

abstract class MainRepository {
  Future<List<Group>> getGroups(
      {required String lastGroup, required int pageSize});
}
