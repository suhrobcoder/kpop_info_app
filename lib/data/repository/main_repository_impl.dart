import 'package:injectable/injectable.dart';
import 'package:kpop_info/data/firestore/firestore_data_source.dart';
import 'package:kpop_info/domain/model/group.dart';
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
}
