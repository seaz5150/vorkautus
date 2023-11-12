import 'package:json_annotation/json_annotation.dart';

part 'ExerciseDTO.g.dart';

@JsonSerializable()
class ExerciseDTO {
  String id;
  String name;
  int exerciseTemplateId;
  int pauseTime;
  List<int> setIds;
  bool completed = false;
  int? totalTime;

  ExerciseDTO(this.id, this.name, this.exerciseTemplateId, this.pauseTime, this.setIds);

  factory ExerciseDTO.fromJson(Map<String, dynamic> json) =>
      _$ExerciseDTOFromJson(json);

  Map<String, dynamic> toJson() => _$ExerciseDTOToJson(this);
}