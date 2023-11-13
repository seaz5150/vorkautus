// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'WorkoutDTO.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WorkoutDTO _$WorkoutDTOFromJson(Map<String, dynamic> json) => WorkoutDTO(
      json['id'] as String,
      json['name'] as String,
      (json['exerciseIds'] as List<dynamic>).map((e) => e as String).toList(),
      json['finished'] as bool,
      json['date'] == null ? null : DateTime.parse(json['date'] as String),
    );

Map<String, dynamic> _$WorkoutDTOToJson(WorkoutDTO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'exerciseIds': instance.exerciseIds,
      'finished': instance.finished,
      'date': instance.date?.toIso8601String(),
    };
