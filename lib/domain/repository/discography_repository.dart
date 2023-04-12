import 'package:dartz/dartz.dart';
import 'package:kpop_info/data/api/response/album.dart';
import 'package:kpop_info/data/api/response/track.dart';

abstract class DiscographyRepository {
  Future<Either<List<Album>, String>> getArtistAlbums(String artistName);
  Future<Either<List<Track>, String>> getAlbumTracks(String albumId);
}
