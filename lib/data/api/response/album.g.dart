// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'album.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Album _$AlbumFromJson(Map<String, dynamic> json) => Album(
      id: json['id'] as String,
      name: json['name'] as String,
      image: _$JsonConverterFromJson<List<dynamic>, String?>(
          json['images'], const _ImageConverter().fromJson),
      releaseDate: json['release_date'] as String,
      totalTracks: json['total_tracks'] as int,
      type: json['type'] as String,
      uri: json['uri'] as String,
    );

Map<String, dynamic> _$AlbumToJson(Album instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'images': const _ImageConverter().toJson(instance.image),
      'release_date': instance.releaseDate,
      'total_tracks': instance.totalTracks,
      'type': instance.type,
      'uri': instance.uri,
    };

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) =>
    json == null ? null : fromJson(json as Json);
