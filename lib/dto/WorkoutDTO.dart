import 'package:json_annotation/json_annotation.dart';
import 'package:vorkautus/dto/ExerciseDTO.dart';
import '../globals.dart' as globals;

part 'WorkoutDTO.g.dart';

@JsonSerializable()
class WorkoutDTO {
  String id = '';
  String name = '';
  List<String> exerciseIds = [];
  bool finished = false;
  DateTime? date;

  List<ExerciseDTO> _exercises = [];

  WorkoutDTO.empty();
  WorkoutDTO(this.id, this.name, this.exerciseIds, this.finished, this.date);

  factory WorkoutDTO.fromJson(Map<String, dynamic> json) =>
      _$WorkoutDTOFromJson(json);

  Map<String, dynamic> toJson() => _$WorkoutDTOToJson(this);

  void addExercise(ExerciseDTO exercise) {
    if (exerciseIds.contains(exercise.id)) {
      return;
    }

    if (_exercises.length == exerciseIds.length) {
      _exercises.add(exercise);
    }
    exerciseIds.add(exercise.id);
  }

  void removeExercise(ExerciseDTO exercise) {
    if (!exerciseIds.contains(exercise.id)) {
      return;
    }

    if (_exercises.length == exerciseIds.length) {
      _exercises.remove(exercise);
    }
    exerciseIds.remove(exercise.id);
  }

  List<ExerciseDTO> getExercises() {
    if (_exercises.length != exerciseIds.length) {
      _exercises = [];

      for (String id in exerciseIds) {
        ExerciseDTO? exercise = globals.repository.getExerciseById(id);
        if (exercise != null) {
          _exercises.add(exercise);
        }
      }
    }

    return _exercises;
  }
}