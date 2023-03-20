import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:kpop_info/data/api/response/album.dart';
import 'package:kpop_info/data/api/response/spotify_list_response.dart';
import 'package:kpop_info/data/api/response/search_response.dart';
import 'package:kpop_info/data/api/response/track.dart';
import 'package:retrofit/retrofit.dart';

part 'spotify_api.g.dart';

@singleton
@RestApi(baseUrl: "https://api.spotify.com/v1")
abstract class SpotifyApi {
  @factoryMethod
  factory SpotifyApi(@Named("spotify_api") Dio dio) = _SpotifyApi;

  @GET("/search")
  Future<SearchResponse> search({
    @Query("q") required String query,
    @Query("type") required String type,
    @Query("limit") required int limit,
  });

  @GET("/artists/{id}/albums")
  Future<SpotifyListResponse<Album>> getDiscograpy({
    @Path("id") required String id,
  });

  @GET("/albums/{album_id}/tracks")
  Future<SpotifyListResponse<Track>> getAlbumTracks({
    @Path("album_id") required String albumId,
  });
}
