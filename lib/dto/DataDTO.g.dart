// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'DataDTO.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DataDTO _$DataDTOFromJson(Map<String, dynamic> json) => DataDTO(
      (json['workouts'] as List<dynamic>)
          .map((e) => WorkoutDTO.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['exercises'] as List<dynamic>)
          .map((e) => ExerciseDTO.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['sets'] as List<dynamic>)
          .map((e) => SetDTO.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['questions'] as List<dynamic>)
          .map((e) => QuestionDTO.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['templates'] as List<dynamic>)
          .map((e) => ExerciseTemplateDTO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DataDTOToJson(DataDTO instance) => <String, dynamic>{
      'workouts': instance.workouts.map((e) => e.toJson()).toList(),
      'exercises': instance.exercises.map((e) => e.toJson()).toList(),
      'sets': instance.sets.map((e) => e.toJson()).toList(),
      'questions': instance.questions.map((e) => e.toJson()).toList(),
      'templates': instance.templates.map((e) => e.toJson()).toList(),
    };
