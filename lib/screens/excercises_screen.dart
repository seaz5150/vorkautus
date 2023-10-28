import 'package:flutter/material.dart';

class ExcercisesScreen extends StatefulWidget {
  const ExcercisesScreen({super.key});

  @override
  State<ExcercisesScreen> createState() =>
      _ExcercisesScreenState();
}

class _ExcercisesScreenState
    extends State<ExcercisesScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Excercises'),
    ),
      body: Container(
          color: Colors.red,
          alignment: Alignment.center,
          child: const Text('Excercises page content'),
        )
    );
  }
}