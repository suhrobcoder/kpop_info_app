// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'track.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Track _$TrackFromJson(Map<String, dynamic> json) => Track(
      id: json['id'] as String,
      name: json['name'] as String,
      uri: json['uri'] as String,
      durationMs: json['duration_ms'] as int,
    );

Map<String, dynamic> _$TrackToJson(Track instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'uri': instance.uri,
      'duration_ms': instance.durationMs,
    };
