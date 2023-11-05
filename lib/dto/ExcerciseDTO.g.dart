// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ExcerciseDTO.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExerciseDTO _$ExerciseDTOFromJson(Map<String, dynamic> json) => ExerciseDTO(
      json['id'] as int,
      json['name'] as String,
      json['exerciseTemplateId'] as int,
      json['pauseTime'] as int,
      (json['setIds'] as List<dynamic>).map((e) => e as int).toList(),
    );

Map<String, dynamic> _$ExerciseDTOToJson(ExerciseDTO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'exerciseTemplateId': instance.exerciseTemplateId,
      'pauseTime': instance.pauseTime,
      'setIds': instance.setIds,
    };
