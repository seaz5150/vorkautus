import 'package:json_annotation/json_annotation.dart';
part 'QuestionDTO.g.dart';

@JsonSerializable()
class QuestionDTO {
  String id;
  String question;
  int answeredCount;
  String rightAnswer;
  List<String> wrongAnswers;

  QuestionDTO(this.id, this.question, this.answeredCount, this.rightAnswer, this.wrongAnswers);

  factory QuestionDTO.fromJson(Map<String, dynamic> json) =>
      _$QuestionDTOFromJson(json);

  Map<String, dynamic> toJson() => _$QuestionDTOToJson(this);
}