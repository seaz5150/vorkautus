import 'package:flutter/material.dart';

class NewWorkoutScreen extends StatefulWidget {
  const NewWorkoutScreen({super.key});

  @override
  State<NewWorkoutScreen> createState() =>
      _NewWorkoutScreenState();
}

class _NewWorkoutScreenState extends State<NewWorkoutScreen> {
 final List<String> demoExcercises = <String>['Overhead press', 'Arnold press', 'Leg curl', 'Lateral raise'];
 final workoutStopwatch = Stopwatch();

  @override
  // ignore: must_call_super
  initState() {
    workoutStopwatch.start();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            Row(
              children: [
                const Text(
                  'New workout',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 25
                  )
                ),
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
                    "Total time: ${_getFormattedTime(workoutStopwatch.elapsed)}",
                    style: const TextStyle(
                      fontSize: 13
                    )
                  ),
                ),
              ],
            )
          ],
        ),
    ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              padding: const EdgeInsets.all(8),
              itemCount: demoExcercises.length,
              itemBuilder: (_, index) {
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          child: ListTile(
                            title: Text(
                              demoExcercises[index],
                              overflow: TextOverflow.ellipsis,
                              softWrap: false,
                              style: const TextStyle(
                                fontSize: 16
                              ),
                            )
                          ),
                        ),
                        Flexible(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                onPressed: () => _onDeleteExercisePressed(index),
                                icon: const Icon(Icons.close),
                                iconSize: 18,
                                ),
                            ],
                          ),
                        )
                      ]),
                  ),
                );
            }),
          ),
        ],
      )
    );
  }
}