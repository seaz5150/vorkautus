library vorkautus.globals;

import 'package:vorkautus/dto/WorkoutDTO.dart';
import 'package:vorkautus/repository/DataRepository.dart';
import 'package:vorkautus/state_tracking.dart';

bool workoutActive = false;
bool exerciseActive = false;
DataRepository repository = DataRepository();
Function? rerenderMain;
StateProvider stateProvider = StateProvider();
WorkoutDTO? copyWorkout;