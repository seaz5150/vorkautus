import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:vorkautus/dto/ExerciseDTO.dart';
import 'package:vorkautus/dto/ExerciseTemplateDTO.dart';
import 'package:vorkautus/dto/SetDTO.dart';
import 'package:vorkautus/dto/WorkoutDTO.dart';
import 'package:vorkautus/widgets/workout_exercise_card.dart';
import '../globals.dart' as globals;

class WorkoutScreen extends StatefulWidget {
  const WorkoutScreen({super.key});

  @override
  State<WorkoutScreen> createState() => _WorkoutScreenState();
}

class _WorkoutScreenState extends State<WorkoutScreen> {
  List<ExerciseDTO> exercises = [];
  List<ExerciseTemplateDTO> availableExerciseTemplates = [];
  ExerciseTemplateDTO? selectedExerciseTemplate;
  Timer? workoutTimer;
  Duration workoutDuration = const Duration();
  WorkoutDTO workout =
      WorkoutDTO(1, "My Workout #1", <int>[], false, DateTime.now().toString());
  bool exerciseRestActive = false;
  bool exerciseSetActive = false;
  ExerciseDTO? activeExercise;
  List<SetDTO> activeExerciseSets = [];
  SetDTO? activeSet;

  @override
  void initState() {
    super.initState();
    workoutTimer = Timer.periodic(const Duration(seconds: 1), (_) => addTime());
    availableExerciseTemplates =
        globals.repository.getExerciseTemplatesFromJson();
    // Pass the workout to globals in case it needs to be saved.
    globals.activeWorkout = workout;
    globals.activeWorkoutExercises = exercises;
  }

  @override
  void dispose() {
    super.dispose();
    workoutTimer?.cancel();
  }

  void addTime() {
    setState(() {
      workoutDuration = Duration(seconds: workoutDuration.inSeconds + 1);
    });
  }

  String _getFormattedTime(Duration d) {
    return d.toString().split('.').first.padLeft(8, "0");
  }

  void _onEditWorkoutNamePressed() {}

  void startExercise(int index) {
    setState(() {
      globals.exerciseActive = true;
      exerciseSetActive = true;
      activeExercise = exercises[index];
      activeSet = SetDTO(1, 0, 0, 0);
      activeExerciseSets.add(activeSet!);
      globals.rerenderMain!(() {});
    });
  }

  Future<void> _onNewExercisePressed() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Exercise addition'),
          content: DropdownMenu<ExerciseTemplateDTO>(
            initialSelection: availableExerciseTemplates.first,
            onSelected: (ExerciseTemplateDTO? value) {
              setState(() {
                selectedExerciseTemplate = value!;
              });
            },
            dropdownMenuEntries: availableExerciseTemplates
                .map<DropdownMenuEntry<ExerciseTemplateDTO>>(
                    (ExerciseTemplateDTO value) {
              return DropdownMenuEntry<ExerciseTemplateDTO>(
                  value: value, label: value.name);
            }).toList(),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Confirm'),
              onPressed: () {
                exercises.add(ExerciseDTO(1, selectedExerciseTemplate!.name,
                    selectedExerciseTemplate!.id, 60, []));
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (globals.exerciseActive && exerciseRestActive) {
      return getSetRestScreen();
    } else if (globals.exerciseActive && exerciseSetActive) {
      return getActiveSetScreen();
    } else {
      return getSummaryScreen();
    }
  }

  Widget getSetRestScreen() {
    return Scaffold(
        body: Column(
      children: [],
    ));
  }

  Widget getActiveSetScreen() {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Column(
          children: [
            Text(activeExercise!.name,
                style:
                    const TextStyle(fontWeight: FontWeight.w500, fontSize: 35)),
            Text("Set #${activeExerciseSets.indexOf(activeSet!) + 1}",
                style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 25,
                    color: Color.fromARGB(198, 52, 52, 52))),
            const Padding(
              padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
              child: Image(
                image: AssetImage('assets/vorkautus.png'),
                width: 80,
              ),
            )
          ],
        ),
      ),
    ));
  }

  Widget getSummaryScreen() {
    return Scaffold(
        appBar: AppBar(
          title: Column(
            children: [
              Row(
                children: [
                  Text(workout.name,
                      style: const TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 24)),
                  IconButton(
                    onPressed: _onEditWorkoutNamePressed,
                    icon: const Icon(Icons.edit),
                    iconSize: 18,
                  ),
                ],
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                        "Total time: ${_getFormattedTime(workoutDuration)}",
                        style: const TextStyle(fontSize: 13)),
                  ),
                ],
              )
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Container(
          padding: const EdgeInsets.only(left: 32, right: 32),
          width: double.infinity,
          height: 30,
          child: FloatingActionButton(
            backgroundColor: const Color.fromARGB(255, 102, 147, 58),
            onPressed: _onNewExercisePressed,
            child: const Icon(Icons.add, color: Colors.white),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: () {
                if (exercises.isNotEmpty) {
                  return ListView.builder(
                      scrollDirection: Axis.vertical,
                      padding: const EdgeInsets.only(
                          top: 8, left: 8, right: 8, bottom: 70),
                      itemCount: exercises.length,
                      itemBuilder: (_, index) {
                        return WorkoutExerciseCard(
                            exercises: exercises,
                            exerciseIndex: index,
                            exerciseStartedCallback: startExercise);
                      });
                } else {
                  return const Center(
                    child: Text("Click the plus button to add an exercise.",
                        style: TextStyle(fontSize: 18)),
                  );
                }
              }(),
            ),
          ],
        ));
  }
}
