import 'package:flutter/material.dart';

class WorkoutHistoryScreen extends StatefulWidget {
  const WorkoutHistoryScreen({super.key});

  @override
  State<WorkoutHistoryScreen> createState() =>
      _WorkoutHistoryScreenState();
}

class _WorkoutHistoryScreenState
    extends State<WorkoutHistoryScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Previous workouts',
          style: TextStyle(
            fontWeight: FontWeight.w500
          )
        ),
    ),
      body: Container(
          alignment: Alignment.center,
          child: const Text('Workout history page content'),
        )
    );
  }
}