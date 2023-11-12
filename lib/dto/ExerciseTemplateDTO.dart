import 'package:json_annotation/json_annotation.dart';

part 'ExerciseTemplateDTO.g.dart';

@JsonSerializable()
class ExerciseTemplateDTO {
  String id;
  String name;

  ExerciseTemplateDTO(this.id, this.name);

  factory ExerciseTemplateDTO.fromJson(Map<String, dynamic> json) =>
      _$ExerciseTemplateDTOFromJson(json);

  Map<String, dynamic> toJson() => _$ExerciseTemplateDTOToJson(this);
}