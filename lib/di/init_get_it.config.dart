// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:cloud_firestore/cloud_firestore.dart' as _i4;
import 'package:dio/dio.dart' as _i3;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:kpop_info/data/api/response/album.dart' as _i19;
import 'package:kpop_info/data/api/spotify_api.dart' as _i13;
import 'package:kpop_info/data/api/spotify_auth_api.dart' as _i9;
import 'package:kpop_info/data/api/spotify_auth_interceptor.dart' as _i10;
import 'package:kpop_info/data/firestore/firestore_data_source.dart' as _i5;
import 'package:kpop_info/data/repository/discography_repository_impl.dart'
    as _i15;
import 'package:kpop_info/data/repository/main_repository_impl.dart' as _i8;
import 'package:kpop_info/di/app_module.dart' as _i20;
import 'package:kpop_info/domain/model/group.dart' as _i17;
import 'package:kpop_info/domain/repository/discography_repository.dart'
    as _i14;
import 'package:kpop_info/domain/repository/main_repository.dart' as _i7;
import 'package:kpop_info/ui/album_songs/bloc/album_songs_bloc.dart' as _i18;
import 'package:kpop_info/ui/group_discography/bloc/group_discography_bloc.dart'
    as _i16;
import 'package:kpop_info/ui/group_list/bloc/group_list_bloc.dart' as _i11;
import 'package:kpop_info/ui/home/bloc/home_bloc.dart' as _i6;
import 'package:kpop_info/ui/idol_list/bloc/idol_list_bloc.dart'
    as _i12; // ignore_for_file: unnecessary_lambdas

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
    gh.singleton<_i3.Dio>(
      appModule.dioSpotifyAuthApi(),
      instanceName: 'spotify_auth_api',
    );
    gh.singleton<_i4.FirebaseFirestore>(appModule.provideFirestore());
    gh.singleton<_i5.FirestoreDataSource>(
        _i5.FirestoreDataSource(gh<_i4.FirebaseFirestore>()));
    gh.factory<_i6.HomeBloc>(() => _i6.HomeBloc());
    gh.factory<_i7.MainRepository>(
        () => _i8.MainRepositoryImpl(gh<_i5.FirestoreDataSource>()));
    gh.singleton<_i9.SpotifyAuthApi>(
        _i9.SpotifyAuthApi(gh<_i3.Dio>(instanceName: 'spotify_auth_api')));
    gh.singleton<_i10.SpotifyAuthInterceptor>(_i10.SpotifyAuthInterceptor(
      gh<_i5.FirestoreDataSource>(),
      gh<_i9.SpotifyAuthApi>(),
    ));
    gh.singleton<_i3.Dio>(
      appModule.dioSpotifyApi(gh<_i10.SpotifyAuthInterceptor>()),
      instanceName: 'spotify_api',
    );
    gh.factory<_i11.GroupListBloc>(
        () => _i11.GroupListBloc(gh<_i7.MainRepository>()));
    gh.factory<_i12.IdolListBloc>(
        () => _i12.IdolListBloc(gh<_i7.MainRepository>()));
    gh.singleton<_i13.SpotifyApi>(
        _i13.SpotifyApi(gh<_i3.Dio>(instanceName: 'spotify_api')));
    gh.factory<_i14.DiscographyRepository>(() => _i15.DiscographyRepositoryImpl(
          gh<_i5.FirestoreDataSource>(),
          gh<_i13.SpotifyApi>(),
        ));
    gh.factoryParam<_i16.GroupDiscographyBloc, _i17.Group, dynamic>((
      group,
      _,
    ) =>
        _i16.GroupDiscographyBloc(
          gh<_i14.DiscographyRepository>(),
          group,
        ));
    gh.factoryParam<_i18.AlbumSongsBloc, _i19.Album, dynamic>((
      album,
      _,
    ) =>
        _i18.AlbumSongsBloc(
          gh<_i14.DiscographyRepository>(),
          album,
        ));
    return this;
  }
}

class _$AppModule extends _i20.AppModule {}
