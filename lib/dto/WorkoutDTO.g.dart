// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'WorkoutDTO.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WorkoutDTO _$WorkoutDTOFromJson(Map<String, dynamic> json) => WorkoutDTO(
      json['id'] as int,
      json['name'] as String,
      (json['exerciseIds'] as List<dynamic>).map((e) => e as int).toList(),
    );

Map<String, dynamic> _$WorkoutDTOToJson(WorkoutDTO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'exerciseIds': instance.exerciseIds,
    };
