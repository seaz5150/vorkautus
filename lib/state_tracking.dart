// https://medium.com/@nshansundar/simple-observer-pattern-to-notify-changes-across-screens-in-flutter-dart-f035dbd990a9

enum ObserverState { INIT, EXERCISE_CANCELED, EXERCISE_FINISHED, WORKOUT_CANCELED, WORKOUT_FINISHED }

abstract class StateListener {
  void onStateChanged(ObserverState state);
}

class StateProvider {
  List<StateListener> observers = [];
  static final StateProvider _instance = StateProvider.internal();
  factory StateProvider() => _instance;
  StateProvider.internal() {
    observers = [];
    initState();
  }
  void initState() async {
    notify(ObserverState.INIT);
  }

  void subscribe(StateListener listener) {
    observers.add(listener);
  }

  void notify(dynamic state) {
    observers.forEach((StateListener obj) => obj.onStateChanged(state));
  }

  void dispose(StateListener thisObserver) {
    for (var obj in observers) {
      if (obj == thisObserver) {
        observers.remove(obj);
      }
    }
  }
}
