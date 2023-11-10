import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:path_provider/path_provider.dart';
import 'package:vorkautus/dto/DataDTO.dart';
import 'package:vorkautus/dto/ExerciseDTO.dart';
import 'package:vorkautus/dto/ExerciseTemplateDTO.dart';
import 'package:vorkautus/dto/QuestionDTO.dart';
import 'package:vorkautus/dto/SetDTO.dart';
import 'package:vorkautus/dto/WorkoutDTO.dart';

class DataRepository {
  Future<String> get _jsonPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _jsonFile async {
    final path = await _jsonPath;
    return File('$path/data.json');
  }

  late DataDTO _data;
  bool _dataLoaded = false;
  late List<dynamic> jsonArray = [];

  DataRepository() {
    loadDataFromJson();
  }

  List<ExerciseDTO> getExercisesFromJson() {
    if (!_dataLoaded) {
      return [];
    }
    return _data.exercises;
  }

  ExerciseDTO? getExerciseById(int id) {
    List<ExerciseDTO> exercises = getExercisesFromJson();
    try {
      return exercises.firstWhere((e) => e.id == id);
    } on StateError {
      return null;
    }
  }

  bool saveExercise(ExerciseDTO ex) {
    try {
      _data.exercises.add(ex);
    } catch (e) {
      return false;
    }
    return true;
  }

  bool removeExercise(ExerciseDTO ex) {
    return _data.exercises.remove(ex);
  }

  List<ExerciseTemplateDTO> getExerciseTemplatesFromJson() {
    if (!_dataLoaded) {
      return [];
    }
    return _data.templates;
  }

  ExerciseTemplateDTO? getExerciseTemplateById(int id) {
    List<ExerciseTemplateDTO> exTemplates = getExerciseTemplatesFromJson();
    try {
      return exTemplates.firstWhere((e) => e.id == id);
    } on StateError {
      return null;
    }
  }

  bool saveExerciseTemplate(ExerciseTemplateDTO exT) {
    try {
      _data.templates.add(exT);
    } catch (e) {
      return false;
    }
    return true;
  }

  bool removeExerciseTemplate(ExerciseTemplateDTO ex) {
    return _data.templates.remove(ex);
  }

  List<QuestionDTO> getQuestionsFromJson() {
    if (!_dataLoaded) {
      return [];
    }
    return _data.questions;
  }

  QuestionDTO? getQuestionById(int id) {
    List<QuestionDTO> questions = getQuestionsFromJson();
    try {
      return questions.firstWhere((e) => e.id == id);
    } on StateError {
      return null;
    }
  }

  QuestionDTO? getRandomQuestion() {
    List<QuestionDTO> questions = getQuestionsFromJson();
    if (questions.isEmpty) {
      return null;
    }
    var randomKey = Random().nextInt(questions.length);
    return questions[randomKey];
  }

  bool saveQuestion(QuestionDTO question) {
    try {
      _data.questions.add(question);
    } catch (e) {
      return false;
    }
    return true;
  }

  bool removeQuestion(QuestionDTO q) {
    return _data.questions.remove(q);
  }

  List<SetDTO> getSetsFromJson() {
    if (!_dataLoaded) {
      return [];
    }
    return _data.sets;
  }

  SetDTO? getSetById(int id) {
    List<SetDTO> sets = getSetsFromJson();
    try {
      return sets.firstWhere((e) => e.id == id);
    } on StateError {
      return null;
    }
  }

  bool saveSet(SetDTO set) {
    try {
      _data.sets.add(set);
    } catch (e) {
      return false;
    }
    return true;
  }

  bool removeSet(SetDTO set) {
    return _data.sets.remove(set);
  }

  List<WorkoutDTO> getWorkoutsFromJson() {
    if (!_dataLoaded) {
      return [];
    }
    return _data.workouts;
  }

  WorkoutDTO? getWorkoutById(int id) {
    List<WorkoutDTO> workouts = getWorkoutsFromJson();
    try {
      return workouts.firstWhere((e) => e.id == id);
    } on StateError {
      return null;
    }
  }

  bool saveWorkout(WorkoutDTO wo) {
    try {
      _data.workouts.add(wo);
    } catch (e) {
      return false;
    }
    return true;
  }

  bool removeWorkout(WorkoutDTO wo) {
    return _data.workouts.remove(wo);
  }

  String saveObject(dynamic obj) {
    bool isSaveOK = false;

    if (obj is ExerciseDTO) {
      isSaveOK = saveExercise(obj);
    } else if (obj is ExerciseTemplateDTO) {
      isSaveOK = saveExerciseTemplate(obj);
    } else if (obj is QuestionDTO) {
      isSaveOK = saveQuestion(obj);
    } else if (obj is SetDTO) {
      isSaveOK = saveSet(obj);
    } else {
      isSaveOK = saveWorkout(obj);
    }

    if (isSaveOK) {
      _writeDataToJson();
      return "";
    }
    return "An error occured while saving the object";
  }

  String removeObject(dynamic obj) {
    bool isRemoveOK = false;

    if (obj is ExerciseDTO) {
      isRemoveOK = removeExercise(obj);
    } else if (obj is ExerciseTemplateDTO) {
      isRemoveOK = removeExerciseTemplate(obj);
    } else if (obj is QuestionDTO) {
      isRemoveOK = removeQuestion(obj);
    } else if (obj is SetDTO) {
      isRemoveOK = removeSet(obj);
    } else {
      isRemoveOK = removeWorkout(obj);
    }

    if (isRemoveOK) {
      _writeDataToJson();
      return "";
    }
    return "An error occured while removing the object";
  }

  Future<DataDTO> loadDataFromJson() async {
    if (_dataLoaded) {
      return _data;
    }
    final File jsonFile = await _jsonFile;
    if (!jsonFile.existsSync()) {
      jsonFile.createSync();
    }
    final content = jsonFile.readAsStringSync();
    var data;
    if (content.isNotEmpty) {
      data = json.decode(content);
    }
    if (data is! Map<String,dynamic>) {
      // Demo data
      _data = DataDTO([
        WorkoutDTO(1, "My Workout #1", [1, 2], true, '2023-11-08'),
        WorkoutDTO(2, "My Workout #2", [2, 3], false, '2023-11-15'),
      ], [
        ExerciseDTO(1, "Overhead press", 1, 20, [1, 2]),
        ExerciseDTO(2, "Arnold press", 2, 20, [3, 4]),
        ExerciseDTO(3, "Leg curl", 3, 20, [5, 6]),
      ], [
        SetDTO(1, 10, 5, 5),
        SetDTO(2, 10, 5, 5),
        SetDTO(3, 10, 5, 5),
        SetDTO(4, 10, 5, 5),
        SetDTO(5, 10, 5, 5),
        SetDTO(6, 10, 5, 5),
      ], [
        QuestionDTO(1, 'What is 2 + 2?', 0, '4', ['3', '5', '6']),
      ], [
        ExerciseTemplateDTO(1, "Overhead press"),
        ExerciseTemplateDTO(2, "Arnold press"),
        ExerciseTemplateDTO(3, "Leg curl"),
      ]);
      _dataLoaded = true;
      return _data;
    }
    _data = DataDTO.fromJson(data);
    _dataLoaded = true;
    return _data;
  }

  void _writeDataToJson() async {
    final updatedJsonData = json.encode(_data);
    final File jsonFile = await _jsonFile;
    jsonFile.writeAsStringSync(updatedJsonData);
  }
}
