// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'DataDTO.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DataDTO _$DataDTOFromJson(Map<String, dynamic> json) => DataDTO(
      (json['workouts'] as List<dynamic>).map((e) => WorkoutDTO.fromJson(e)).toList(),
      (json['exercises'] as List<dynamic>).map((e) => ExerciseDTO.fromJson(e)).toList(),
      (json['sets'] as List<dynamic>).map((e) => SetDTO.fromJson(e)).toList(),
      (json['questions'] as List<dynamic>).map((e) => QuestionDTO.fromJson(e)).toList(),
      (json['templates'] as List<dynamic>).map((e) => ExerciseTemplateDTO.fromJson(e)).toList(),
    );

Map<String, dynamic> _$DataDTOToJson(DataDTO instance) =>
    <String, dynamic>{
      'workouts': instance.workouts,
      'exercises': instance.exercises,
      'sets': instance.sets,
      'questions': instance.questions,
      'templates': instance.templates,
    };
