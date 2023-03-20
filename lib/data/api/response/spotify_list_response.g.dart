// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spotify_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SpotifyListResponse<T> _$SpotifyListResponseFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    SpotifyListResponse<T>(
      items: (json['items'] as List<dynamic>).map(fromJsonT).toList(),
    );

Map<String, dynamic> _$SpotifyListResponseToJson<T>(
  SpotifyListResponse<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'items': instance.items.map(toJsonT).toList(),
    };
