import 'package:dartz/dartz.dart';
import 'package:kpop_info/data/api/response/album.dart';

abstract class DiscographyRepository {
  Future<Either<List<Album>, String>> getArtistAlbums(String artistName);
}
