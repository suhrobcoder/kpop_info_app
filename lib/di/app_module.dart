import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:dio/dio.dart';
import 'package:kpop_info/data/api/spotify_auth_interceptor.dart';

@module
abstract class AppModule {
  @singleton
  FirebaseFirestore provideFirestore() => FirebaseFirestore.instance;

  @singleton
  @Named("spotify_api")
  Dio dioSpotifyApi(SpotifyAuthInterceptor authInterceptor) => Dio(
        BaseOptions(
          validateStatus: ((status) => true),
        ),
      )..interceptors.addAll([
          LogInterceptor(responseBody: true),
          authInterceptor,
        ]);

  @singleton
  @Named("spotify_auth_api")
  Dio dioSpotifyAuthApi() => Dio(
        BaseOptions(
          validateStatus: ((status) => true),
        ),
      )..interceptors.addAll([
          LogInterceptor(requestBody: true, responseBody: true),
        ]);
}
