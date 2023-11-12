import 'package:json_annotation/json_annotation.dart';

part 'ExerciseDTO.g.dart';

@JsonSerializable()
class ExerciseDTO {
  String id;
  String name;
  String exerciseTemplateId;
  int pauseTime;
  List<String> setIds;
  bool completed = false;
  int totalTime = 0;

  ExerciseDTO(this.id, this.name, this.exerciseTemplateId, this.pauseTime, this.setIds);

  factory ExerciseDTO.fromJson(Map<String, dynamic> json) =>
      _$ExerciseDTOFromJson(json);

  Map<String, dynamic> toJson() => _$ExerciseDTOToJson(this);
}