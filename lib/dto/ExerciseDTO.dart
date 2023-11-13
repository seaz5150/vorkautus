import 'package:json_annotation/json_annotation.dart';
import 'package:vorkautus/dto/ExerciseTemplateDTO.dart';
import 'package:vorkautus/dto/SetDTO.dart';

import '../globals.dart' as globals;

part 'ExerciseDTO.g.dart';

@JsonSerializable()
class ExerciseDTO {
  String id = '';
  String name = '';
  String exerciseTemplateId = '';
  int pauseTime = 0;
  List<String> setIds = [];
  bool completed = false;
  int totalTime = 0;

  List<SetDTO> _sets = [];
  ExerciseTemplateDTO? _exerciseTemplate;

  ExerciseDTO.empty();

  ExerciseDTO.fresh(this.name, this.exerciseTemplateId, this.pauseTime);

  ExerciseDTO(this.id, this.name, this.exerciseTemplateId, this.totalTime,
      this.pauseTime, this.setIds, this.completed);

  factory ExerciseDTO.fromJson(Map<String, dynamic> json) =>
      _$ExerciseDTOFromJson(json);

  Map<String, dynamic> toJson() => _$ExerciseDTOToJson(this);

  ExerciseTemplateDTO? getExerciseTemplate() {
    _exerciseTemplate ??=
        globals.repository.getExerciseTemplateById(exerciseTemplateId);
    return _exerciseTemplate;
  }

  void setExerciseTemplate(ExerciseTemplateDTO exerciseTemplate) {
    _exerciseTemplate = exerciseTemplate;
    exerciseTemplateId = exerciseTemplate.id;
  }

  void addSet(SetDTO set) {
    if (setIds.contains(set.id)) {
      return;
    }

    if (_sets.length == setIds.length) {
      _sets.add(set);
    }
    setIds.add(set.id);
  }

  void removeSet(SetDTO set) {
    if (!setIds.contains(set.id)) {
      return;
    }

    if (_sets.length == setIds.length) {
      _sets.remove(set);
    }
    setIds.remove(set.id);
  }

  List<SetDTO> getSets() {
    if (_sets.length != setIds.length) {
      _sets = [];

      for (String id in setIds) {
        SetDTO? set = globals.repository.getSetById(id);
        if (set != null) {
          _sets.add(set);
        }
      }
    }

    return _sets;
  }
}
