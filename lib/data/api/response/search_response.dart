import 'package:json_annotation/json_annotation.dart';
import 'package:kpop_info/data/api/response/artist.dart';

part 'search_response.g.dart';

@JsonSerializable()
class SearchResponse {
  @_SearchArtistsConverter()
  final List<Artist> artists;

  SearchResponse({
    required this.artists,
  });

  factory SearchResponse.fromJson(Map<String, dynamic> json) =>
      _$SearchResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SearchResponseToJson(this);
}

class _SearchArtistsConverter
    extends JsonConverter<List<Artist>, Map<String, dynamic>> {
  const _SearchArtistsConverter();

  @override
  List<Artist> fromJson(Map<String, dynamic> json) =>
      [for (var e in json["items"] as List) Artist.fromJson(e)];

  @override
  Map<String, dynamic> toJson(List<Artist> object) => {
        "items": object.map((e) => e.toJson()),
      };
}
