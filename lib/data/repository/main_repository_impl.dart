import 'package:injectable/injectable.dart';
import 'package:kpop_info/data/firestore/firestore_data_source.dart';
import 'package:kpop_info/domain/model/group.dart';
import 'package:kpop_info/domain/model/idol.dart';
import 'package:kpop_info/domain/repository/main_repository.dart';

@Injectable(as: MainRepository)
class MainRepositoryImpl extends MainRepository {
  final FirestoreDataSource dataSource;

  MainRepositoryImpl(this.dataSource);

  @override
  Future<List<Group>> getGroups(
      {required String lastGroup, required int pageSize}) {
    return dataSource.getGroups(lastGroup: lastGroup, pageSize: pageSize);
  }

  @override
  Future<List<Group>> searchGroups(
      {required String search,
      required String lastGroup,
      required int pageSize}) {
    return dataSource.searchGroups(
        search: search, lastGroup: lastGroup, pageSize: pageSize);
  }

  @override
  Future<List<Idol>> getIdols(
      {required String lastIdol, required int pageSize}) {
    return dataSource.getIdols(lastIdol: lastIdol, pageSize: pageSize);
  }

  @override
  Future<List<Idol>> searchIdols(
      {required String search,
      required String lastIdol,
      required int pageSize}) {
    return dataSource.searchIdols(
        search: search, lastIdol: lastIdol, pageSize: pageSize);
  }
}
