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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: <Widget>[
        const WorkoutHistoryScreen(),
        const NewWorkoutScreen(),
        const ExcercisesScreen(),
      ][_selectedPageIndex],
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            _selectedPageIndex = index;
          });
        },
        destinations: const <Widget>[
          NavigationDestination(
            icon: Icon(
              Icons.bookmark
            ),
            label: 'History',
          ),
          NavigationDestination(
            icon: Icon(
              Icons.add
            ),
            label: 'New workout',
          ),
          NavigationDestination(
            icon: Icon(
              Icons.list
            ),
            label: 'Excercises'
          ),
        ],
        selectedIndex: _selectedPageIndex,
        indicatorColor: Color.fromARGB(146, 79, 55, 139)
      ),
    );
  }
}