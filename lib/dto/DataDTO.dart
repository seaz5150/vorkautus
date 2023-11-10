import 'package:json_annotation/json_annotation.dart';
import 'package:vorkautus/dto/ExerciseTemplateDTO.dart';
import 'package:vorkautus/dto/QuestionDTO.dart';
import 'package:vorkautus/dto/SetDTO.dart';

import 'WorkoutDTO.dart';
import 'ExerciseDTO.dart';

part 'DataDTO.g.dart';

@JsonSerializable()
class DataDTO {
  List<WorkoutDTO> workouts = [];
  List<ExerciseDTO> exercises = [];
  List<SetDTO> sets = [];
  List<QuestionDTO> questions = [];
  List<ExerciseTemplateDTO> templates = [];

  DataDTO.empty();
  DataDTO(this.workouts, this.exercises, this.sets, this.questions, this.templates);

  factory DataDTO.fromJson(Map<String, dynamic> json) =>
      _$DataDTOFromJson(json);

  Map<String, dynamic> toJson() => _$DataDTOToJson(this);
}