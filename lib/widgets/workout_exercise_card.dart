import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vorkautus/dto/ExerciseDTO.dart';
import 'package:vorkautus/dto/SetDTO.dart';
import '../globals.dart' as globals;
import 'package:collection/collection.dart';

class WorkoutExerciseCard extends StatefulWidget {
  final List<ExerciseDTO> exercises;
  final int exerciseIndex;
  const WorkoutExerciseCard(
      {super.key, required this.exercises, required this.exerciseIndex});

  @override
  State<WorkoutExerciseCard> createState() => _WorkoutExerciseCardState();
}

class _WorkoutExerciseCardState extends State<WorkoutExerciseCard> {
  List<Map<String, String>> setTableRows = [];
  List<SetDTO?> sets = [];
  TextEditingController? _restTextFieldController;
  late ExerciseDTO exercise;

  @override
  void initState() {
    super.initState();
    exercise = widget.exercises[widget.exerciseIndex];
    sets =
        exercise.setIds.map((e) => globals.repository.getSetById(e)).toList();
    setTableRows = sets
        .mapIndexed((index, s) => {
              "Set": index.toString(),
              "Reps": s!.reps.toString(),
              "Weight": s.weight.toString()
            })
        .toList();
    _restTextFieldController =
        TextEditingController(text: exercise.pauseTime.toString());
  }

  void _onDeleteExercisePressed() {
    widget.exercises.removeAt(widget.exerciseIndex);
  }

  void _onStartExercisePressed() {}

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
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    if (exercise.completed) ...[
                      DataTable(
                        columnSpacing: 30,
                        dataRowHeight: 25,
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
                        ],
                        rows: setTableRows
                            .map(
                              ((element) => DataRow(
                                    cells: <DataCell>[
                                      DataCell(Text(element["Set"]!,
                                          style:
                                              const TextStyle(fontSize: 13))),
                                      DataCell(Text(element["Reps"]!,
                                          style:
                                              const TextStyle(fontSize: 13))),
                                      DataCell(Text(element["Weight"]!,
                                          style:
                                              const TextStyle(fontSize: 13))),
                                    ],
                                  )),
                            )
                            .toList(),
                      ),
                    ] else ...[
                      SizedBox(
                        width: 100,
                        height: 50,
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
                          ], // Only numbers can be entered
                        ),
                      ),
                    ],
                    if (exercise.completed) ...[
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
                    ] else ...[
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 79, 55, 139),
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
                  ]),
            )
          ],
        ),
      ),
    );
  }
}
