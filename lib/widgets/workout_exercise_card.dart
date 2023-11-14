import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vorkautus/dto/ExerciseDTO.dart';
import 'package:vorkautus/dto/SetDTO.dart';

import '../utilities/misc_utilities.dart';

class WorkoutExerciseCard extends StatefulWidget {
  final List<ExerciseDTO> exercises;
  final int exerciseIndex;
  final Function(int) exerciseStartedCallback;

  const WorkoutExerciseCard(
      {super.key,
      required this.exercises,
      required this.exerciseIndex,
      required this.exerciseStartedCallback});

  @override
  State<WorkoutExerciseCard> createState() => _WorkoutExerciseCardState();
}

class _WorkoutExerciseCardState extends State<WorkoutExerciseCard> {
  List<SetDTO> sets = [];
  TextEditingController? _restTextFieldController;
  late ExerciseDTO exercise;

  @override
  void initState() {
    super.initState();
    exercise = widget.exercises[widget.exerciseIndex];
    sets = exercise.getSets();
    _restTextFieldController = TextEditingController(text: exercise.pauseTime.toString());
  }

  void _onDeleteExercisePressed() {
    widget.exercises.removeAt(widget.exerciseIndex);
  }

  void _onStartExercisePressed() {
    widget.exerciseStartedCallback(widget.exerciseIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.only(left: 2, right: 2),
        child: Column(
          children: [
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    flex: 3,
                    child: ListTile(
                        title: Text(
                      exercise.name,
                      overflow: TextOverflow.ellipsis,
                      softWrap: false,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w500),
                    )),
                  ),
                  Flexible(
                    child: IconButton(
                      onPressed: () => _onDeleteExercisePressed(),
                      icon: const Icon(Icons.close),
                      iconSize: 18,
                    ),
                  )
                ]),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Padding(
                padding: const EdgeInsets.only(left: 40.0, right: 40.0),
                child: Column(children: [
                  if (exercise.completed) ...[
                    DataTable(
                      columnSpacing: 30,
                      dataRowMinHeight: 15,
                      headingRowHeight: 25,
                      columns: const <DataColumn>[
                        DataColumn(
                          label: Expanded(
                            child: Text(
                              'Set',
                              style: TextStyle(
                                  fontStyle: FontStyle.italic, fontSize: 13),
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Expanded(
                            child: Text(
                              'Reps',
                              style: TextStyle(
                                  fontStyle: FontStyle.italic, fontSize: 13),
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Expanded(
                            child: Text(
                              'Weight',
                              style: TextStyle(
                                  fontStyle: FontStyle.italic, fontSize: 13),
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Expanded(
                            child: Text(
                              'Time',
                              style: TextStyle(
                                  fontStyle: FontStyle.italic, fontSize: 13),
                            ),
                          ),
                        ),
                      ],
                      rows: exercise
                          .getSets()
                          .mapIndexed((index, set) => DataRow(cells: [
                                DataCell(Text("#${index + 1}",
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(fontSize: 13))),
                                DataCell(Text("${set.reps}x",
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(fontSize: 13))),
                                DataCell(Text("${set.weight}kg",
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(fontSize: 13))),
                                DataCell(Text(
                                    getFormattedTime(
                                        Duration(seconds: set.timeOfSet)),
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(fontSize: 13))),
                              ]))
                          .toList(),
                    ),
                  ] else ...[
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: TextField(
                          controller: _restTextFieldController,
                          onSubmitted: (String value) async {
                            exercise.pauseTime = int.parse(value);
                          },
                          textAlignVertical: TextAlignVertical.center,
                          decoration: const InputDecoration(
                              labelText: "Rest time (s)",
                              prefixIcon: Icon(Icons.timer, size: 22),
                              labelStyle: TextStyle(fontSize: 13)),
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                        ),
                    ),
                  ],
                  if (exercise.completed) ...[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                            "Total time: ${getFormattedTime(Duration(seconds: exercise.totalTime!))}",
                            style: const TextStyle(fontSize: 13)),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            disabledBackgroundColor:
                                const Color.fromARGB(170, 102, 147, 58),
                          ),
                          onPressed: null,
                          child: const Row(
                            children: [
                              Icon(
                                Icons.check,
                                color: Colors.white,
                                size: 20,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 8.0),
                                child: Text('DONE',
                                    style: TextStyle(color: Colors.white)),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ] else ...[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromARGB(255, 79, 55, 139),
                          ),
                          onPressed: _onStartExercisePressed,
                          child: const Row(
                            children: [
                              Icon(
                                Icons.play_arrow_outlined,
                                color: Colors.white,
                                size: 20,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 8.0),
                                child: Text('START',
                                    style: TextStyle(color: Colors.white)),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ]),
              ),
            )
          ],
        ),
      ),
    );
  }
}
