import 'package:injectable/injectable.dart';
import 'package:kpop_info/data/firestore/firestore_data_source.dart';
import 'package:kpop_info/domain/model/group.dart';
import 'package:kpop_info/domain/model/idol.dart';
import 'package:kpop_info/domain/repository/main_repository.dart';
import 'package:kpop_info/util/filter_type.dart';

@Injectable(as: MainRepository)
class MainRepositoryImpl extends MainRepository {
  final FirestoreDataSource dataSource;

  MainRepositoryImpl(this.dataSource);

  @override
  Future<List<Group>> getGroups(
      {required String lastGroup,
      required FilterType filterType,
      required int pageSize}) {
    return dataSource.getGroups(
        lastGroup: lastGroup, filterType: filterType, pageSize: pageSize);
  }

  @override
  Future<List<Group>> searchGroups(
      {required String search,
      required String lastGroup,
      required FilterType filterType,
      required int pageSize}) {
    return dataSource.searchGroups(
        search: search,
        lastGroup: lastGroup,
        filterType: filterType,
        pageSize: pageSize);
  }

  @override
  Future<List<Idol>> getIdols({
    required String lastIdol,
    required FilterType filterType,
    required int pageSize,
  }) {
    return dataSource.getIdols(
        lastIdol: lastIdol, filterType: filterType, pageSize: pageSize);
  }

  @override
  Future<List<Idol>> searchIdols(
      {required String search,
      required String lastIdol,
      required FilterType filterType,
      required int pageSize}) {
    return dataSource.searchIdols(
        search: search,
        lastIdol: lastIdol,
        filterType: filterType,
        pageSize: pageSize);
  }

  @override
  Future<Idol> getIdolByName({
    required String name,
    required String group,
  }) async {
    return dataSource.getIdolByName(name: name, group: group);
  }
}
