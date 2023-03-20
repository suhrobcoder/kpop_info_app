import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:kpop_info/data/api/response/token_response.dart';
import 'package:retrofit/retrofit.dart';

part 'spotify_auth_api.g.dart';

@singleton
@RestApi(baseUrl: "https://accounts.spotify.com/api")
abstract class SpotifyAuthApi {
  @factoryMethod
  factory SpotifyAuthApi(@Named("spotify_auth_api") Dio dio) = _SpotifyAuthApi;

  @POST("/token")
  @FormUrlEncoded()
  Future<TokenResponse> getToken({
    @Field("grant_type") String grantType = "client_credentials",
    @Field("client_id") required String clientId,
    @Field("client_secret") required String clientSecret,
  });
}
