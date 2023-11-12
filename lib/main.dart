import 'package:flutter/material.dart';
import 'screens/exercises_screen.dart';
import 'screens/workout_screen.dart';
import 'screens/workout_history_screen.dart';
import 'globals.dart' as globals;
import '../state_tracking.dart';

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
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  int _selectedPageIndex = 0;

  @override
  void initState() {
    super.initState();
    globals.repository.loadDataFromJson();
    globals.rerenderMain = setState;
  }

  List<Widget> getMenuItems() {
    if (globals.workoutActive) {
      if (globals.exerciseActive) {
        return const <Widget>[
          NavigationDestination(
              icon: Icon(Icons.arrow_back, color: Colors.red),
              label: 'Cancel exercise'),
          NavigationDestination(
              icon: Icon(Icons.check, color: Colors.green),
              label: 'Finish exercise'),
        ];
      } else {
        return const <Widget>[
          NavigationDestination(
              icon: Icon(Icons.close, color: Colors.red),
              label: 'Cancel workout'),
          NavigationDestination(
              icon: Icon(Icons.checklist_rtl, color: Colors.green),
              label: 'Finish workout'),
        ];
      }
    } else {
      return const <Widget>[
        NavigationDestination(icon: Icon(Icons.bookmark), label: 'History'),
        NavigationDestination(icon: Icon(Icons.add), label: 'New workout'),
        NavigationDestination(icon: Icon(Icons.list), label: 'Exercises'),
      ];
    }
  }

  Color getSelectedColor() {
    if (!globals.workoutActive) {
      return const Color.fromARGB(146, 79, 55, 139);
    } else {
      return const Color.fromARGB(0, 0, 0, 0);
    }
  }

  void _onDestinationSelected(int index) {
    setState(() {
      if (!globals.workoutActive) {
        // New workout started.
        if (index == 1) {
          globals.workoutActive = true;
        }
        _selectedPageIndex = index;
      } else {
        if (!globals.exerciseActive) {
          if (index == 0) {
            // Cancel workout
            globals.stateProvider.notify(ObserverState.WORKOUT_CANCELED);
          } else {
            // Finish workout
            globals.stateProvider.notify(ObserverState.WORKOUT_FINISHED);
          }
          globals.workoutActive = false;
          _selectedPageIndex = 0;
        } else {
          if (index == 0) {
            // Cancel exercise
            globals.stateProvider.notify(ObserverState.EXERCISE_CANCELED);
          } else {
            // Finish exercise
            globals.stateProvider.notify(ObserverState.EXERCISE_FINISHED);
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: <Widget>[
        const WorkoutHistoryScreen(),
        const WorkoutScreen(),
        const ExercisesScreen(),
      ][_selectedPageIndex],
      bottomNavigationBar: NavigationBar(
          onDestinationSelected: _onDestinationSelected,
          destinations: getMenuItems(),
          selectedIndex: _selectedPageIndex,
          indicatorColor: getSelectedColor()),
    );
  }
}
