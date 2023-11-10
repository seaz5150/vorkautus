import 'dart:async';

import 'package:flutter/material.dart';
import 'package:vorkautus/dto/WorkoutDTO.dart';

class NewWorkoutScreen extends StatefulWidget {
  const NewWorkoutScreen({super.key});

  @override
  State<NewWorkoutScreen> createState() => _NewWorkoutScreenState();
}

class _NewWorkoutScreenState extends State<NewWorkoutScreen> {
  final List<String> demoExcercises = <String>[
    'Overhead press',
    'Arnold press',
    'Leg curl',
    'Lateral raise'
  ];
  Timer? workoutTimer;
  Duration workoutDuration = const Duration();
  WorkoutDTO workout = WorkoutDTO(1, "My Workout #1", <int>[]);

  @override
  void initState() {
    super.initState();
    workoutTimer = Timer.periodic(const Duration(seconds: 1), (_) => addTime());
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

  void _onDeleteExercisePressed(int index) {
    // setState(() {

    // });
  }

  void _onEditWorkoutNamePressed() {
    // setState(() {

    // });
  }

  void _onNewExercisePressed() {
    // setState(() {

    // });
  }

  void _onStartExercisePressed(int index) {
    // setState(() {

    // });
  }

  @override
  Widget build(BuildContext context) {
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
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  padding: const EdgeInsets.only(top: 8, left: 8, right: 8, bottom: 70),
                  itemCount: demoExcercises.length,
                  itemBuilder: (_, index) {
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 2, right: 2),
                        child: Column(
                          children: [
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Expanded(
                                    child: ListTile(
                                        title: Text(
                                      demoExcercises[index],
                                      overflow: TextOverflow.ellipsis,
                                      softWrap: false,
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500),
                                    )),
                                  ),
                                  Flexible(
                                    child: IconButton(
                                      onPressed: () =>
                                          _onDeleteExercisePressed(index),
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
                                              fontStyle: FontStyle.italic,
                                              fontSize: 13),
                                        ),
                                      ),
                                    ),
                                    DataColumn(
                                      label: Expanded(
                                        child: Text(
                                          'Reps',
                                          style: TextStyle(
                                              fontStyle: FontStyle.italic,
                                              fontSize: 13),
                                        ),
                                      ),
                                    ),
                                    DataColumn(
                                      label: Expanded(
                                        child: Text(
                                          'Weight',
                                          style: TextStyle(
                                              fontStyle: FontStyle.italic,
                                              fontSize: 13),
                                        ),
                                      ),
                                    ),
                                  ],
                                  rows: const <DataRow>[
                                    DataRow(
                                      cells: <DataCell>[
                                        DataCell(Text('#1',
                                            style: TextStyle(fontSize: 13))),
                                        DataCell(Text('12x',
                                            style: TextStyle(fontSize: 13))),
                                        DataCell(Text('30kg',
                                            style: TextStyle(fontSize: 13))),
                                      ],
                                    ),
                                    DataRow(
                                      cells: <DataCell>[
                                        DataCell(Text('#2',
                                            style: TextStyle(fontSize: 13))),
                                        DataCell(Text('10x',
                                            style: TextStyle(fontSize: 13))),
                                        DataCell(Text('25kg',
                                            style: TextStyle(fontSize: 13))),
                                      ],
                                    ),
                                    DataRow(
                                      cells: <DataCell>[
                                        DataCell(Text('#3',
                                            style: TextStyle(fontSize: 13))),
                                        DataCell(Text('8x',
                                            style: TextStyle(fontSize: 13))),
                                        DataCell(Text('20kg',
                                            style: TextStyle(fontSize: 13))),
                                      ],
                                    ),
                                  ],
                                ),
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
                                            style:
                                                TextStyle(color: Colors.white)),
                                      ),
                                    ],
                                  ),
                                ),
                              ]),
                            )
                          ],
                        ),
                      ),
                    );
                  }),
            ),
          ],
        ));
  }
}
