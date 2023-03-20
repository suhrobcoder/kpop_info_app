import 'package:json_annotation/json_annotation.dart';

part 'album.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Album {
  final String id;
  final String name;
  @_ImageConverter()
  final String? image;
  final String releaseDate;
  final int totalTracks;
  final String type;
  final String uri;

  Album({
    required this.id,
    required this.name,
    required this.image,
    required this.releaseDate,
    required this.totalTracks,
    required this.type,
    required this.uri,
  });

  factory Album.fromJson(Map<String, dynamic> json) => _$AlbumFromJson(json);

  Map<String, dynamic> toJson() => _$AlbumToJson(this);
}

class _ImageConverter extends JsonConverter<String?, List<dynamic>> {
  const _ImageConverter();

  @override
  String? fromJson(List json) {
    if (json.isEmpty) return null;
    return json[0]["url"];
  }

  @override
  List toJson(String? object) {
    return [
      {
        "url": object,
      }
    ];
  }
}
