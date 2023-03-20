import 'package:json_annotation/json_annotation.dart';

part 'spotify_list_response.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class SpotifyListResponse<T> {
  final List<T> items;

  const SpotifyListResponse({
    required this.items,
  });

  factory SpotifyListResponse.fromJson(
          Map<String, dynamic> json, T Function(Object? json) fromJsonT) =>
      _$SpotifyListResponseFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(Object? Function(T value) toJsonT) =>
      _$SpotifyListResponseToJson(this, toJsonT);
}
