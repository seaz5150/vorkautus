// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'QuestionDTO.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuestionDTO _$QuestionDTOFromJson(Map<String, dynamic> json) => QuestionDTO(
      json['id'] as int,
      json['question'] as String,
      json['answeredCount'] as int,
      json['rightAnswer'] as String,
      (json['wrongAnswers'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$QuestionDTOToJson(QuestionDTO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'question': instance.question,
      'answeredCount': instance.answeredCount,
      'rightAnswer': instance.rightAnswer,
      'wrongAnswers': instance.wrongAnswers,
    };
