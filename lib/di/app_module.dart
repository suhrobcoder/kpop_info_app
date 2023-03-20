import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:dio/dio.dart';
import 'package:kpop_info/data/api/spotify_auth_interceptor.dart';

@module
abstract class AppModule {
  @singleton
  FirebaseFirestore provideFirestore() => FirebaseFirestore.instance;

  @dev
  @singleton
  @Named("spotify_api")
  Dio dioDevSpotifyApi(SpotifyAuthInterceptor authInterceptor) => Dio(
        BaseOptions(
          validateStatus: ((status) => true),
        ),
      )..interceptors.addAll([
          LogInterceptor(),
          authInterceptor,
        ]);

  @prod
  @singleton
  @Named("spotify_api")
  Dio dioProdSpotifyApi(SpotifyAuthInterceptor authInterceptor) => Dio(
        BaseOptions(
          validateStatus: ((status) => true),
        ),
      )..interceptors.addAll([
          authInterceptor,
        ]);

  @dev
  @singleton
  @Named("spotify_auth_api")
  Dio dioDevSpotifyAuthApi() => Dio(
        BaseOptions(
          validateStatus: ((status) => true),
        ),
      )..interceptors.addAll([
          LogInterceptor(requestBody: true, responseBody: true),
        ]);

  @prod
  @singleton
  @Named("spotify_auth_api")
  Dio dioProdSpotifyAuthApi() => Dio(
        BaseOptions(
          validateStatus: ((status) => true),
        ),
      );
}
