import 'dart:convert';
import 'dart:math';

import 'package:vorkautus/dto/ExerciseDTO.dart';
import 'package:vorkautus/dto/ExerciseTemplateDTO.dart';
import 'package:vorkautus/dto/QuestionDTO.dart';
import 'package:vorkautus/dto/SetDTO.dart';
import 'package:vorkautus/dto/WorkoutDTO.dart';

class DataRepository {
  String jsonFilePath = "";
  String jsonFileContent = "";




List<ExerciseDTO> getExercisesFromJson() {
  final List<dynamic> jsonArray = json.decode(jsonFileContent);
  final List<ExerciseDTO> exercises = jsonArray.map((data) {
    return ExerciseDTO.fromJson(data);
  }).toList();

  return exercises;
}

ExerciseDTO? getExerciseById(int id) {
  List<ExerciseDTO?> exercises = getExercisesFromJson();
  final exercise = exercises.firstWhere((e) => e?.id == id, orElse: () => null);
  return exercise;
}





List<ExerciseTemplateDTO> getExerciseTemplatesFromJson() {
  final List<dynamic> jsonArray = json.decode(jsonFileContent);
  final List<ExerciseTemplateDTO> exTemplates = jsonArray.map((data) {
    return ExerciseTemplateDTO.fromJson(data);
  }).toList();

  return exTemplates;
}

ExerciseTemplateDTO? getExerciseTemplateById(int id) {
  List<ExerciseTemplateDTO?> exTemplates = getExerciseTemplatesFromJson();
  final exTemplate = exTemplates.firstWhere((e) => e?.id == id, orElse: () => null);
  return exTemplate;
}



List<QuestionDTO> getQuestionsFromJson() {
  final List<dynamic> jsonArray = json.decode(jsonFileContent);
  final List<QuestionDTO> questions = jsonArray.map((data) {
    return QuestionDTO.fromJson(data);
  }).toList();

  return questions;
}
QuestionDTO? getQuestionById(int id) {
  List<QuestionDTO?> questions = getQuestionsFromJson();
  final question = questions.firstWhere((e) => e?.id == id, orElse: () => null);
  return question;
}

QuestionDTO? getRandomQuestion() {
  List<QuestionDTO?> questions = getQuestionsFromJson();
  var randomId = Random().nextInt(questions.length);
  final question = questions.firstWhere((e) => e?.id == randomId, orElse: () => null);
  return question;
}




List<SetDTO> getSetsFromJson() {
  final List<dynamic> jsonArray = json.decode(jsonFileContent);
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

List<WorkoutDTO> getWorkoutsFromJson() {
  final List<dynamic> jsonArray = json.decode(jsonFileContent);
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





}
