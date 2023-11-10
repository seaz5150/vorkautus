import 'package:json_annotation/json_annotation.dart';
part 'WorkoutDTO.g.dart';

@JsonSerializable()
class WorkoutDTO {
  int id;
  String name = '';
  List<int> exerciseIds = [];
  bool finished = false;
  String date = '';

  WorkoutDTO(this.id, this.name, this.exerciseIds, this.finished, this.date);

  factory WorkoutDTO.fromJson(Map<String, dynamic> json) =>
      _$WorkoutDTOFromJson(json);

  Map<String, dynamic> toJson() => _$WorkoutDTOToJson(this);
}