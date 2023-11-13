// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ExerciseDTO.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExerciseDTO _$ExerciseDTOFromJson(Map<String, dynamic> json) => ExerciseDTO(
      json['id'] as String,
      json['name'] as String,
      json['exerciseTemplateId'] as String,
      json['totalTime'] as int,
      json['pauseTime'] as int,
      (json['setIds'] as List<dynamic>).map((e) => e as String).toList(),
      json['completed'] as bool,
    );

Map<String, dynamic> _$ExerciseDTOToJson(ExerciseDTO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'exerciseTemplateId': instance.exerciseTemplateId,
      'pauseTime': instance.pauseTime,
      'setIds': instance.setIds,
      'completed': instance.completed,
      'totalTime': instance.totalTime,
    };
