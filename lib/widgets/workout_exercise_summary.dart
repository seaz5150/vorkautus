import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:vorkautus/dto/ExerciseDTO.dart';
import 'package:vorkautus/utilities/misc_utilities.dart';

class WorkoutExerciseSummary extends StatefulWidget {
  final ExerciseDTO exercise;

  const WorkoutExerciseSummary({super.key, required this.exercise});

  @override
  State<WorkoutExerciseSummary> createState() => _WorkoutExerciseSummaryState();
}

class _WorkoutExerciseSummaryState extends State<WorkoutExerciseSummary> {
  late ExerciseDTO exercise;

  @override
  void initState() {
    super.initState();
    exercise = widget.exercise;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 16.0),
                child: Text(
                  exercise.name,
                  style:
                      const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Text(
                    'Total: ${getFormattedTime(Duration(seconds: exercise.totalTime))}'),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Text(
                    'Pause: ${getFormattedTime(Duration(seconds: exercise.pauseTime))}'),
              ),
              DataTable(
                columnSpacing: 30,
                dataRowMinHeight: 25,
                headingRowHeight: 25,
                columns: const <DataColumn>[
                  DataColumn(
                    label: Expanded(
                      child: Text(
                        'Set',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontStyle: FontStyle.italic, fontSize: 13),
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Expanded(
                      child: Text(
                        'Reps',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontStyle: FontStyle.italic, fontSize: 13),
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Expanded(
                      child: Text(
                        'Weight',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontStyle: FontStyle.italic, fontSize: 13),
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Expanded(
                      child: Text(
                        'Time',
                        textAlign: TextAlign.center,
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
              )
            ],
          )),
    );
  }
}
