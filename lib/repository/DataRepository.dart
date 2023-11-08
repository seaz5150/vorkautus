import 'dart:convert';
import 'dart:math';
import 'dart:io';

import 'package:vorkautus/dto/ExerciseDTO.dart';
import 'package:vorkautus/dto/ExerciseTemplateDTO.dart';
import 'package:vorkautus/dto/QuestionDTO.dart';
import 'package:vorkautus/dto/SetDTO.dart';
import 'package:vorkautus/dto/WorkoutDTO.dart';

class DataRepository {
  final jsonFile = File("TODO");
  late List<dynamic> jsonArray;

  DataRepository() {
    if (jsonFile.existsSync()) {
      final content = jsonFile.readAsStringSync();
      List<dynamic> jsonArray =
          List<Map<String, dynamic>>.from(json.decode(content));
    }
  }

  List<ExerciseDTO> getExercisesFromJson() {
    final List<ExerciseDTO> exercises = jsonArray.map((data) {
      return ExerciseDTO.fromJson(data);
    }).toList();

    return exercises;
  }

  ExerciseDTO? getExerciseById(int id) {
    List<ExerciseDTO?> exercises = getExercisesFromJson();
    final exercise =
        exercises.firstWhere((e) => e?.id == id, orElse: () => null);
    return exercise;
  }

  bool saveExercise(ExerciseDTO ex) {
    try {
      jsonArray.add(ex.toJson());
    } catch (e) {
      return false;
    }
    return true;
  }

  List<ExerciseTemplateDTO> getExerciseTemplatesFromJson() {
    final List<ExerciseTemplateDTO> exTemplates = jsonArray.map((data) {
      return ExerciseTemplateDTO.fromJson(data);
    }).toList();

    return exTemplates;
  }

  ExerciseTemplateDTO? getExerciseTemplateById(int id) {
    List<ExerciseTemplateDTO?> exTemplates = getExerciseTemplatesFromJson();
    final exTemplate =
        exTemplates.firstWhere((e) => e?.id == id, orElse: () => null);
    return exTemplate;
  }

  bool saveExerciseTemplate(ExerciseTemplateDTO exT) {
    try {
      jsonArray.add(exT.toJson());
    } catch (e) {
      return false;
    }
    return true;
  }

  List<QuestionDTO> getQuestionsFromJson() {
    final List<QuestionDTO> questions = jsonArray.map((data) {
      return QuestionDTO.fromJson(data);
    }).toList();

    return questions;
  }

  QuestionDTO? getQuestionById(int id) {
    List<QuestionDTO?> questions = getQuestionsFromJson();
    final question =
        questions.firstWhere((e) => e?.id == id, orElse: () => null);
    return question;
  }

  QuestionDTO? getRandomQuestion() {
    List<QuestionDTO?> questions = getQuestionsFromJson();
    var randomId = Random().nextInt(questions.length);
    final question =
        questions.firstWhere((e) => e?.id == randomId, orElse: () => null);
    return question;
  }

  bool saveQuestion(QuestionDTO question) {
    try {
      jsonArray.add(question.toJson());
    } catch (e) {
      return false;
    }
    return true;
  }

  List<SetDTO> getSetsFromJson() {
    final List<SetDTO> sets = jsonArray.map((data) {
      return SetDTO.fromJson(data);
    }).toList();

    return sets;
  }

  SetDTO? getSetById(int id) {
    List<SetDTO?> sets = getSetsFromJson();
    final set = sets.firstWhere((e) => e?.id == id, orElse: () => null);
    return set;
  }

  bool saveSet(SetDTO set) {
    try {
      jsonArray.add(set.toJson());
    } catch (e) {
      return false;
    }
    return true;
  }

  List<WorkoutDTO> getWorkoutsFromJson() {
    final List<WorkoutDTO> workouts = jsonArray.map((data) {
      return WorkoutDTO.fromJson(data);
    }).toList();

    return workouts;
  }

  WorkoutDTO? getWorkoutById(int id) {
    List<WorkoutDTO?> workouts = getWorkoutsFromJson();
    final workout = workouts.firstWhere((e) => e?.id == id, orElse: () => null);
    return workout;
  }

  bool saveWorkout(WorkoutDTO wo) {
    try {
      jsonArray.add(wo.toJson());
    } catch (e) {
      return false;
    }
    return true;
  }

  String saveObject(dynamic obj) {
    bool isSaveOK = false;

    if (obj is ExerciseDTO)
      isSaveOK = saveExercise(obj);
    else if (obj is ExerciseTemplateDTO)
      isSaveOK = saveExerciseTemplate(obj);
    else if (obj is QuestionDTO)
      isSaveOK = saveQuestion(obj);
    else if (obj is SetDTO)
      isSaveOK = saveSet(obj);
    else
      isSaveOK = saveWorkout(obj);

    if (isSaveOK) {
      UpdateJson();
      return "";
    }
    return "There happened an error while saving the object";
  }

  void UpdateJson() {
    final updatedJsonData = json.encode(jsonArray);
    jsonFile.writeAsStringSync(updatedJsonData);
  }
}
