import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:uuid/uuid.dart';

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
  late Uuid uuid = const Uuid();

  DataRepository() {
    loadDataFromJson();
  }

  List<ExerciseDTO> getExercisesFromJson() {
    if (!_dataLoaded) {
      return [];
    }
    return _data.exercises;
  }

  ExerciseDTO? getExerciseById(String id) {
    List<ExerciseDTO> exercises = getExercisesFromJson();
    try {
      print(exercises.map((e) => e.id));
      return exercises.firstWhere((e) => e.id == id);
    } on StateError {
      return null;
    }
  }

  bool saveExercise(ExerciseDTO ex) {
    try {
      if (ex.id == '') {
        ex.id = uuid.v4();
      }
      if (!_data.exercises.contains(ex)) {
        _data.exercises.add(ex);
      }
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

  ExerciseTemplateDTO? getExerciseTemplateById(String id) {
    List<ExerciseTemplateDTO> exTemplates = getExerciseTemplatesFromJson();
    try {
      return exTemplates.firstWhere((e) => e.id == id);
    } on StateError {
      return null;
    }
  }

  bool saveExerciseTemplate(ExerciseTemplateDTO exT) {
    try {
      if (exT.id == '') {
        exT.id = uuid.v4();
      }
      if (!_data.templates.contains(exT)) {
        _data.templates.add(exT);
      }
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

  QuestionDTO? getQuestionById(String id) {
    List<QuestionDTO> questions = getQuestionsFromJson();
    try {
      return questions.firstWhere((e) => e.id == id);
    } on StateError {
      return null;
    }
  }

  QuestionDTO? getRandomQuestion() {
    List<QuestionDTO> questions = getQuestionsFromJson();
    return getRandomQuestionFromList(questions);
  }

  
  QuestionDTO? getRandomQuestionFromList(List<QuestionDTO> questions) {
    if (questions.isEmpty) {
      return null;
    }
    var randomKey = Random().nextInt(questions.length);
    return questions[randomKey];
  }

  bool saveQuestion(QuestionDTO question) {
    try {
      if (question.id == '') {
        question.id = uuid.v4();
      }
      if (!_data.questions.contains(question)) {
        _data.questions.add(question);
      }
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

  SetDTO? getSetById(String id) {
    List<SetDTO> sets = getSetsFromJson();
    try {
      return sets.firstWhere((e) => e.id == id);
    } on StateError {
      return null;
    }
  }

  bool saveSet(SetDTO set) {
    try {
      if (set.id == '') {
        set.id = uuid.v4();
      }
      if (!_data.sets.contains(set)) {
        _data.sets.add(set);
      }
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

  WorkoutDTO? getWorkoutById(String id) {
    List<WorkoutDTO> workouts = getWorkoutsFromJson();
    try {
      return workouts.firstWhere((e) => e.id == id);
    } on StateError {
      return null;
    }
  }

  bool saveWorkout(WorkoutDTO wo) {
    try {
      if (wo.id == '') {
        wo.id == uuid.v4();
      }
      if (!_data.workouts.contains(wo)) {
        _data.workouts.add(wo);
      }
    } catch (e) {
      return false;
    }
    return true;
  }

  bool removeWorkout(WorkoutDTO wo) {
    return _data.workouts.remove(wo);
  }

  String saveObject(dynamic obj) {
    print("Saving");
    print(obj);
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
      return obj.id;
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
      final String ex1Id = uuid.v4();
      final String ex2Id = uuid.v4();
      final String ex3Id = uuid.v4();
      final String temp1Id = uuid.v4();
      final String temp2Id = uuid.v4();
      final String temp3Id = uuid.v4();
      final String set1Id = uuid.v4();
      final String set2Id = uuid.v4();
      final String set3Id = uuid.v4();
      final String set4Id = uuid.v4();
      final String set5Id = uuid.v4();
      final String set6Id = uuid.v4();
      // Demo data
      _data = DataDTO([
        WorkoutDTO(uuid.v4(), "My Workout #1", [ex1Id, ex2Id], true, DateTime.tryParse('2023-11-08')),
        WorkoutDTO(uuid.v4(), "My Workout #2", [ex2Id, ex3Id], false, DateTime.tryParse('2023-11-15')),
      ], [
        ExerciseDTO(ex1Id, "Overhead press", temp1Id, 20, [set1Id, set2Id]),
        ExerciseDTO(ex2Id, "Arnold press", temp2Id, 20, [set3Id, set4Id]),
        ExerciseDTO(ex3Id, "Leg curl", temp3Id, 20, [set5Id, set6Id]),
      ], [
        SetDTO(set1Id, 10, 5, 5),
        SetDTO(set2Id, 10, 5, 5),
        SetDTO(set3Id, 10, 5, 5),
        SetDTO(set4Id, 10, 5, 5),
        SetDTO(set5Id, 10, 5, 5),
        SetDTO(set6Id, 10, 5, 5),
      ], [
        QuestionDTO(uuid.v4(), 'What is 2 + 2?', 0, '4', ['3', '5', '6']),
        QuestionDTO(uuid.v4(), 'How long would it take to finish 1 hour workout?', 0, '60 minutes', ['30 minutes', '10 ', '45 mintues']),
        QuestionDTO(uuid.v4(), 'What is the recommended duration for a standard workout session?', 0, '60 minutes', ['30 minutes', '10 minutes', '45 minutes']),
        QuestionDTO(uuid.v4(), 'How much time should be dedicated to a workout for optimal results?', 0, '60 minutes', ['45 minutes', '30 minutes', '15 minutes']),
        QuestionDTO(uuid.v4(), 'In terms of duration, what is the commonly suggested timeframe for a comprehensive workout?', 0, '60 minutes', ['20 minutes', '45 minutes', '30 minutes']),
        QuestionDTO(uuid.v4(), 'For a complete workout, what is the ideal time commitment?', 0, '60 minutes', ['40 minutes', '15 minutes', '50 minutes']),
        QuestionDTO(uuid.v4(), 'What is the standard length for an effective workout session?', 0, '60 minutes', ['25 minutes', '40 minutes', '55 minutes']),
        QuestionDTO(uuid.v4(), 'What is the recommended number of repetitions per set for muscle building?', 0, '8-12 reps', ['5 reps', '15 reps', '20 reps']),
        QuestionDTO(uuid.v4(), 'How many sets are typically recommended for a strength-focused workout?', 0, '3-5 sets', ['1 set', '8 sets', '10 sets']),
        QuestionDTO(uuid.v4(), 'For endurance training, what is the suggested range for repetitions per set?', 0, '15-20 reps', ['10 reps', '25 reps', '30 reps']),
        QuestionDTO(uuid.v4(), 'What is the general guideline for rest intervals between sets during weightlifting?', 0, '60-90 seconds', ['30 seconds', '2 minutes', '45 seconds']),
        QuestionDTO(uuid.v4(), 'After a workout, how much protein is commonly recommended for muscle recovery?', 0, '20-30 grams', ['10 grams', '40 grams', '15 grams']),
        QuestionDTO(uuid.v4(), 'When aiming for fat loss, what is the typical duration for a high-intensity interval training (HIIT) session?', 0, '20-30 minutes', ['10 minutes', '45 minutes', '60 minutes']),
        QuestionDTO(uuid.v4(), 'What is the recommended frequency of strength training sessions per week for optimal results?', 0, '2-3 times', ['1 time', '5 times', '7 times']),
      ], [
        ExerciseTemplateDTO(temp1Id, "Overhead press"),
        ExerciseTemplateDTO(temp2Id, "Arnold press"),
        ExerciseTemplateDTO(temp3Id, "Leg curl"),
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
