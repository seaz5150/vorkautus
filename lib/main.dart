import 'package:flutter/material.dart';
import 'screens/excercises_screen.dart';
import 'screens/new_workout_screen.dart';
import 'screens/workout_history_screen.dart';

// Project structure guide: https://medium.com/flutter-community/scalable-folder-structure-for-flutter-applications-183746bdc320 (Folders By Type/Domain)
// For performing operations on the JSON data maybe this architecture: https://codewithandrea.com/articles/flutter-repository-pattern/

void main() {
  runApp(const VorkautusApp());
}

class VorkautusApp extends StatelessWidget {
  const VorkautusApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vorkautus',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const RootScreen(),
    );
  }
}

class RootScreen extends StatefulWidget {
  const RootScreen({super.key});

  @override
  State<RootScreen> createState() =>
      _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  int _selectedPageIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: <Widget>[
        const WorkoutHistoryScreen(),
        const NewWorkoutScreen(),
        const ExcercisesScreen(),
      ][_selectedPageIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'New workout',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Excercises',
          ),
        ],
        currentIndex: _selectedPageIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}