import 'package:flutter/material.dart';

class NewWorkoutScreen extends StatefulWidget {
  const NewWorkoutScreen({super.key});

  @override
  State<NewWorkoutScreen> createState() =>
      _NewWorkoutScreenState();
}

class _NewWorkoutScreenState
    extends State<NewWorkoutScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'New workout',
          style: TextStyle(
            fontWeight: FontWeight.w500
          )
        ),
    ),
      body: Container(
          alignment: Alignment.center,
          child: const Text('New workout page content'),
        )
    );
  }
}