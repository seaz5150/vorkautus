import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vorkautus/dto/ExerciseDTO.dart';
import 'package:vorkautus/dto/ExerciseTemplateDTO.dart';
import 'package:vorkautus/dto/SetDTO.dart';
import 'package:vorkautus/dto/WorkoutDTO.dart';
import 'package:vorkautus/widgets/quiz_widget.dart';
import 'package:vorkautus/widgets/workout_exercise_card.dart';

import '../globals.dart' as globals;
import '../state_tracking.dart';
import '../utilities/misc_utilities.dart';

class WorkoutScreen extends StatefulWidget {
  const WorkoutScreen({super.key});

  @override
  State<WorkoutScreen> createState() => _WorkoutScreenState();
}

class _WorkoutScreenState extends State<WorkoutScreen>
    implements StateListener {
  List<ExerciseDTO> exercises = [];
  List<ExerciseTemplateDTO> availableExerciseTemplates = [];
  ExerciseTemplateDTO? selectedExerciseTemplate;
  Timer? workoutTimer;
  Duration workoutDuration = Duration.zero;
  WorkoutDTO workout = WorkoutDTO(globals.repository.uuid.v4(), "My Workout #1",
      <String>[], false, DateTime.now());
  bool exerciseRestActive = false;
  bool exerciseSetActive = false;
  ExerciseDTO? activeExercise;
  List<SetDTO> activeExerciseSets = [];
  SetDTO? activeSet;
  Timer? setTimer;
  Duration setDuration = Duration.zero;
  Timer? setRestTimer;
  Duration setRestDuration = Duration.zero;
  TextEditingController? repCountTextFieldController;
  TextEditingController? weightTextFieldController;

  @override
  onStateChanged(ObserverState state) {
    switch (state) {
      case ObserverState.EXERCISE_CANCELED:
        _cancelExercise();
        break;
      case ObserverState.EXERCISE_FINISHED:
        if (exerciseSetActive) {
          _openPromptForWeight(_finishExercise);
        } else {
          _finishExercise();
        }
        break;
      case ObserverState.WORKOUT_FINISHED:
        _finishWorkout();
        break;
      case ObserverState.WORKOUT_CANCELED:
        // Have to delete the saved exercises...
        break;
      default:
        break;
    }
  }

  @override
  void initState() {
    super.initState();
    globals.stateProvider.subscribe(this);
    workoutTimer =
        Timer.periodic(const Duration(seconds: 1), (_) => _addTimeToWorkout());
    availableExerciseTemplates =
        globals.repository.getExerciseTemplatesFromJson();
    // Pass the workout to globals in case it needs to be saved.
    globals.activeWorkout = workout;
    globals.activeWorkoutExercises = exercises;
    selectedExerciseTemplate = availableExerciseTemplates.first;
  }

  @override
  void dispose() {
    super.dispose();
    workoutTimer?.cancel();
    setTimer?.cancel();
  }

  void _finishWorkout() {
    if (mounted) {
      workout.exerciseIds = exercises.map((e) => e.id).toList();
      workout.finished = true;
      globals.repository.saveObject(workout);
    }
  }

  void _finishExercise() {
    if (mounted) {
      setState(() {
        exerciseRestActive = false;
        exerciseSetActive = false;
        setTimer?.cancel();
        setTimer = null;
        setDuration = Duration.zero;
        setRestDuration = Duration.zero;
        setRestTimer?.cancel();
        setRestTimer = null;

        activeExerciseSets.forEach((s) => globals.repository.saveObject(s));
        activeExercise?.setIds = activeExerciseSets.map((s) => s.id).toList();
        activeExercise?.completed = true;
        globals.repository.saveObject(activeExercise);

        activeExercise = null;
        activeExerciseSets = [];

        globals.exerciseActive = false;
      });
    }
  }

  void _cancelExercise() {
    if (mounted) {
      setState(() {
        exerciseRestActive = false;
        exerciseSetActive = false;
        setTimer?.cancel();
        setTimer = null;
        setDuration = Duration.zero;
        setRestDuration = Duration.zero;
        setRestTimer?.cancel();
        setRestTimer = null;
        activeExercise = null;
        activeExerciseSets = [];

        globals.exerciseActive = false;
      });
    }
  }

  void _addTimeToWorkout() {
    setState(() {
      workoutDuration = Duration(seconds: workoutDuration.inSeconds + 1);
    });
  }

  void _addTimeToSet() {
    setState(() {
      setDuration = Duration(seconds: setDuration.inSeconds + 1);
    });
  }

  void _addTimeToSetRest() {
    setState(() {
      setRestDuration = Duration(seconds: setRestDuration.inSeconds + 1);
    });
  }

  void _onEditWorkoutNamePressed() {}

  void _onRestAndAddSetAndWeightEntered() {
    setState(() {
      activeSet?.timeOfSet = setDuration.inSeconds;
      setTimer?.cancel();
      setDuration = Duration.zero;
      setRestTimer = Timer.periodic(
          const Duration(seconds: 1), (_) => _addTimeToSetRest());
      exerciseSetActive = false;
      exerciseRestActive = true;
    });
  }

  void _beginNextSet() {
    setState(() {
      exerciseRestActive = false;
      exerciseSetActive = true;
      activeSet = SetDTO(globals.repository.uuid.v4(), 0, 0, 0);
      activeExerciseSets.add(activeSet!);
      globals.rerenderMain!(() {});
      setRestTimer?.cancel();
      setRestDuration = Duration.zero;
      setTimer =
          Timer.periodic(const Duration(seconds: 1), (_) => _addTimeToSet());
    });
  }

  Future<void> _openPromptForWeight(Function onConfirmed) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Lifted volume'),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 100,
                height: 50,
                child: TextField(
                  controller: repCountTextFieldController,
                  onSubmitted: (String value) async {
                    activeSet!.reps = int.parse(value);
                  },
                  textAlignVertical: TextAlignVertical.center,
                  decoration: const InputDecoration(
                      labelText: "Rep count",
                      labelStyle: TextStyle(fontSize: 13)),
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 16.0, right: 16.0),
                child: Text("x",
                    style: TextStyle(
                        fontSize: 30, color: Color.fromARGB(255, 0, 0, 0))),
              ),
              SizedBox(
                width: 100,
                height: 50,
                child: TextField(
                  controller: repCountTextFieldController,
                  onSubmitted: (String value) async {
                    activeSet!.weight = double.parse(value);
                  },
                  textAlignVertical: TextAlignVertical.center,
                  decoration: const InputDecoration(
                      labelText: "Weight (kg)",
                      labelStyle: TextStyle(fontSize: 13)),
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                ),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('CONFIRM'),
              onPressed: () {
                onConfirmed();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _startExercise(int index) {
    setState(() {
      globals.exerciseActive = true;
      activeExercise = exercises[index];
      _beginNextSet();
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
            initialSelection: selectedExerciseTemplate,
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
                exercises.add(ExerciseDTO.fresh(selectedExerciseTemplate!.name,
                    selectedExerciseTemplate!.id, 60));
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
      return _getSetRestScreen();
    } else if (globals.exerciseActive && exerciseSetActive) {
      return _getActiveSetScreen();
    } else {
      return _getSummaryScreen();
    }
  }

  Widget _getSetRestScreen() {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Column(
          children: [
            const Text("Rest",
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 35)),
            Text(
                "${activeExercise!.name}, set #${activeExerciseSets.indexOf(activeSet!) + 1}",
                style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 25,
                    color: Color.fromARGB(198, 52, 52, 52))),
            const Padding(
              padding: EdgeInsets.only(top: 40.0),
              child: Text("Remaining time",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                      color: Color.fromARGB(198, 52, 52, 52))),
            ),
            Text(
                getFormattedTime(Duration(
                    seconds:
                        activeExercise!.pauseTime - setRestDuration.inSeconds)),
                style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 50,
                    color: Color.fromARGB(255, 102, 147, 58))),
            Padding(
              padding: const EdgeInsets.only(top: 40.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 102, 147, 58),
                ),
                onPressed: () => _beginNextSet(),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                      'BEGIN SET #${activeExerciseSets.indexOf(activeSet!) + 2}',
                      style: const TextStyle(color: Colors.white)),
                ),
              ),
            ),
            Expanded(
              child: _getQuizScreen(),
            ),
          ],
        ),
      ),
    ));
  }

  Widget _getActiveSetScreen() {
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
              padding: EdgeInsets.only(top: 16.0, bottom: 16.0),
              child: Image(
                image: AssetImage('assets/vorkautus.png'),
                width: 80,
              ),
            ),
            const Text("Time duration",
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                    color: Color.fromARGB(198, 52, 52, 52))),
            Text(getFormattedTime(setDuration),
                style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 50,
                    color: Color.fromARGB(255, 102, 147, 58))),
            Padding(
              padding: const EdgeInsets.only(top: 40.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 102, 147, 58),
                ),
                onPressed: () =>
                    _openPromptForWeight(_onRestAndAddSetAndWeightEntered),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('REST AND ADD SET',
                      style: TextStyle(color: Colors.white)),
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }

  Widget _getSummaryScreen() {
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
                        "Total time: ${getFormattedTime(workoutDuration)}",
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
                            exerciseStartedCallback: _startExercise);
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

  Widget _getQuizScreen() {
    return QuizSubview();
  }
}
