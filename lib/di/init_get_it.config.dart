// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:cloud_firestore/cloud_firestore.dart' as _i3;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:kpop_info/data/firestore/firestore_data_source.dart' as _i4;
import 'package:kpop_info/data/repository/main_repository_impl.dart' as _i7;
import 'package:kpop_info/di/app_module.dart' as _i10;
import 'package:kpop_info/domain/repository/main_repository.dart' as _i6;
import 'package:kpop_info/ui/group_list/bloc/group_list_bloc.dart' as _i8;
import 'package:kpop_info/ui/home/bloc/home_bloc.dart' as _i5;
import 'package:kpop_info/ui/idol_list/bloc/idol_list_bloc.dart'
    as _i9; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
extension GetItInjectableX on _i1.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final appModule = _$AppModule();
    gh.singleton<_i3.FirebaseFirestore>(appModule.provideFirestore());
    gh.singleton<_i4.FirestoreDataSource>(
        _i4.FirestoreDataSource(gh<_i3.FirebaseFirestore>()));
    gh.factory<_i5.HomeBloc>(() => _i5.HomeBloc());
    gh.factory<_i6.MainRepository>(
        () => _i7.MainRepositoryImpl(gh<_i4.FirestoreDataSource>()));
    gh.factory<_i8.GroupListBloc>(
        () => _i8.GroupListBloc(gh<_i6.MainRepository>()));
    gh.factory<_i9.IdolListBloc>(
        () => _i9.IdolListBloc(gh<_i6.MainRepository>()));
    return this;
  }
}

class _$AppModule extends _i10.AppModule {}
