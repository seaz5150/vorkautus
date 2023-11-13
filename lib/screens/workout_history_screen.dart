import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vorkautus/dto/ExerciseDTO.dart';
import 'package:vorkautus/dto/WorkoutDTO.dart';
import 'package:vorkautus/widgets/workout_exercise_summary.dart';

import '../globals.dart' as globals;

class WorkoutHistoryScreen extends StatefulWidget {
  const WorkoutHistoryScreen({super.key});

  @override
  State<WorkoutHistoryScreen> createState() => _WorkoutHistoryScreenState();
}

class _WorkoutHistoryScreenState extends State<WorkoutHistoryScreen> {
  List<WorkoutDTO> workouts = [];

  Future<void> _onWorkoutDeletePressed(WorkoutDTO workout) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Are you sure you want to delete the workout?'),
          actions: <Widget>[
            TextButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Yes'),
              onPressed: () {
                globals.repository.removeObject(workout);
                _loadWorkouts();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _onWorkoutDetailsPressed(WorkoutDTO workout) {
    final List<ExerciseDTO> exercises = workout.getExercises();

    final DateFormat dateFormatter = DateFormat('dd/MM/yyyy');
    final String formattedDate;
    if (workout.date != null) {
      formattedDate = dateFormatter.format(workout.date as DateTime);
    } else {
      formattedDate = '';
    }

    showModalBottomSheet(
        context: context,
        elevation: 10,
        showDragHandle: true,
        // Make it full height
        isScrollControlled: true,
        constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height -
                MediaQuery.of(context).padding.bottom -
                MediaQuery.of(context).padding.top),
        // Content
        builder: (context) => Container(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      workout.name,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ),
                  if (formattedDate != '')
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(
                        formattedDate,
                        style: const TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 14),
                      ),
                    ),
                  Expanded(
                      child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: exercises.length,
                          itemBuilder: (context, index) {
                            return WorkoutExerciseSummary(
                              exercise: exercises[index],
                            );
                          }))
                ],
              ),
            )));
  }

  void _onWorkoutStartPressed(WorkoutDTO workout) {
    // TODO: Start workout
  }

  void _onWorkoutRepeatPressed(WorkoutDTO workout) {
    // TODO: Copy and start workout
  }

  // Asynchronously load the workouts
  void _loadWorkouts() async {
    await globals.repository.loadDataFromJson();
    setState(() {
      workouts = globals.repository.getWorkoutsFromJson();
    });
  }

  @override
  void initState() {
    _loadWorkouts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Previous workouts',
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 25)),
        ),
        body: Container(
          alignment: Alignment.topCenter,
          child: ListView.builder(
              scrollDirection: Axis.vertical,
              padding: const EdgeInsets.all(8),
              itemCount: workouts.length,
              itemBuilder: (context, index) {
                WorkoutDTO workout = workouts[index];
                List<ExerciseDTO> exercises = workout.getExercises();
                final DateFormat dateFormatter = DateFormat('dd/MM/yyyy');
                final String formattedDate;
                if (workout.date != null) {
                  formattedDate =
                      dateFormatter.format(workout.date as DateTime);
                } else {
                  formattedDate = '';
                }
                return Card(
                  child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                  child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      workout.name,
                                      softWrap: false,
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Text(
                                    formattedDate,
                                    softWrap: false,
                                    style: const TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              )),
                              IconButton(
                                onPressed: () =>
                                    _onWorkoutDeletePressed(workout),
                                icon: const Icon(Icons.close),
                                iconSize: 18,
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              exercises.map((e) => e.name).join(', '),
                              softWrap: true,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              FloatingActionButton.extended(
                                onPressed: () =>
                                    _onWorkoutDetailsPressed(workout),
                                icon: const Icon(Icons.info_rounded),
                                label: const Text('Details'),
                              ),
                              (() {
                                if (workout.finished) {
                                  return FloatingActionButton.extended(
                                    onPressed: () =>
                                        _onWorkoutRepeatPressed(workout),
                                    icon: const Icon(Icons.repeat),
                                    label: const Text('Repeat'),
                                  );
                                }
                                return FloatingActionButton.extended(
                                  onPressed: () =>
                                      _onWorkoutStartPressed(workout),
                                  icon: const Icon(Icons.play_arrow),
                                  label: const Text('Start'),
                                );
                              }())
                            ],
                          )
                        ],
                      )),
                );
              }),
        ));
  }
}
