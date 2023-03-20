import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:dartz/dartz.dart';
import 'package:kpop_info/data/api/response/album.dart';
import 'package:kpop_info/data/api/spotify_api.dart';
import 'package:kpop_info/data/firestore/firestore_data_source.dart';
import 'package:kpop_info/domain/model/group.dart';
import 'package:kpop_info/domain/repository/discography_repository.dart';
import 'package:kpop_info/util/handle_dio_error.dart';

@Injectable(as: DiscographyRepository)
class DiscographyRepositoryImpl extends DiscographyRepository {
  final FirestoreDataSource dataSource;
  final SpotifyApi api;

  DiscographyRepositoryImpl(this.dataSource, this.api);

  @override
  Future<Either<List<Album>, String>> getArtistAlbums(String artistName) async {
    final groupDoc = await dataSource.getGroupByName(name: artistName);
    final group = Group.fromMap(groupDoc.data());
    var spotifyId = group.spotifyId;
    try {
      if (spotifyId == null) {
        spotifyId = await getSpotifyIdByName(artistName);
        dataSource.setGroupId(docId: groupDoc.id, spotifyId: spotifyId);
      }
      final result = await api.getDiscograpy(id: spotifyId);
      return left(result.items);
    } catch (error) {
      if (error is DioError) {
        return right(handleDioError(error));
      }
      return right("Something went wrong");
    }
  }

  Future<String> getSpotifyIdByName(String artistName) async {
    final result =
        await api.search(query: artistName, type: "artist", limit: 1);
    return result.artists[0].id;
  }
}
