import 'package:json_annotation/json_annotation.dart';
part 'SetDTO.g.dart';

@JsonSerializable()
class SetDTO {
  int id;
  double weight;
  int reps;
  int timeOfSet;

  SetDTO(this.id, this.weight, this.reps, this.timeOfSet);

  factory SetDTO.fromJson(Map<String, dynamic> json) =>
      _$SetDTOFromJson(json);

  Map<String, dynamic> toJson() => _$SetDTOToJson(this);
}