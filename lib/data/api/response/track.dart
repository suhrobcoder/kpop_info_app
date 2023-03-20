import 'package:json_annotation/json_annotation.dart';

part 'track.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Track {
  final String id;
  final String name;
  final String uri;
  final int durationMs;

  Track({
    required this.id,
    required this.name,
    required this.uri,
    required this.durationMs,
  });

  factory Track.fromJson(Map<String, dynamic> json) => _$TrackFromJson(json);

  Map<String, dynamic> toJson() => _$TrackToJson(this);
}
