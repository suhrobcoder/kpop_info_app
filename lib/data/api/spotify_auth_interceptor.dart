import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:kpop_info/data/api/spotify_auth_api.dart';
import 'package:kpop_info/data/api/spotify_constants.dart';
import 'package:kpop_info/data/firestore/firestore_data_source.dart';

@singleton
class SpotifyAuthInterceptor extends Interceptor {
  final FirestoreDataSource firestoreDataSource;
  final SpotifyAuthApi authApi;

  String? token;
  DateTime? expireDate;

  bool _refreshingToken = false;

  SpotifyAuthInterceptor(this.firestoreDataSource, this.authApi) {
    _listenForTokenChanges();
  }

  void _listenForTokenChanges() async {
    firestoreDataSource.listenForTokenChanges().listen((snapshot) {
      token = snapshot.data()?["token"];
      expireDate = snapshot.data()?["expire_date"].toDate();
    });
  }

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    if (token != null &&
        expireDate != null &&
        DateTime.now().isBefore(expireDate!)) {
      options.headers['Authorization'] = 'Bearer $token';
      return handler.next(options);
    }

    if (_refreshingToken) {
      await _waitUntilTokenRefreshed();
      options.headers['Authorization'] = 'Bearer $token';
      return handler.next(options);
    }

    _refreshingToken = true;
    final tokenResult =
        await authApi.getToken(clientId: clientId, clientSecret: clientSecret);
    _refreshingToken = false;
    token = tokenResult.accessToken;
    expireDate = DateTime.now().add(Duration(seconds: tokenResult.expiresIn));
    firestoreDataSource.setTokenAndExpireDate(
        token: token!, expireDate: expireDate!);

    options.headers['Authorization'] = 'Bearer $token';
    return handler.next(options);
  }

  Future<void> _waitUntilTokenRefreshed() async {
    while (_refreshingToken) {
      await Future.delayed(const Duration(milliseconds: 100));
    }
  }
}
