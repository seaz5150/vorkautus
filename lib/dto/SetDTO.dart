import 'package:json_annotation/json_annotation.dart';
part 'SetDTO.g.dart';

@JsonSerializable()
class SetDTO {
  String id = '';
  double weight = 0.0;
  int reps = 0;
  int timeOfSet = 0;

  SetDTO.empty();
  SetDTO.withId(this.id);
  SetDTO(this.id, this.weight, this.reps, this.timeOfSet);

  factory SetDTO.fromJson(Map<String, dynamic> json) =>
      _$SetDTOFromJson(json);

  Map<String, dynamic> toJson() => _$SetDTOToJson(this);
}