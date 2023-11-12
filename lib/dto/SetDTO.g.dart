// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'SetDTO.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SetDTO _$SetDTOFromJson(Map<String, dynamic> json) => SetDTO(
      json['id'] as String,
      (json['weight'] as num).toDouble(),
      json['reps'] as int,
      json['timeOfSet'] as int,
    );

Map<String, dynamic> _$SetDTOToJson(SetDTO instance) => <String, dynamic>{
      'id': instance.id,
      'weight': instance.weight,
      'reps': instance.reps,
      'timeOfSet': instance.timeOfSet,
    };
