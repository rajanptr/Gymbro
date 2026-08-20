import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  static void reset() {
    _instance = FFAppState._internal();
  }

  Future initializePersistedState() async {
    prefs = await SharedPreferences.getInstance();
    _safeInit(() {
      _restDuration = prefs.getInt('ff_restDuration') ?? _restDuration;
    });
    _safeInit(() {
      _restTimerSound = prefs.getBool('ff_restTimerSound') ?? _restTimerSound;
    });
  }

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  late SharedPreferences prefs;

  String _currentWorkoutId = '';
  String get currentWorkoutId => _currentWorkoutId;
  set currentWorkoutId(String value) {
    _currentWorkoutId = value;
  }

  String _selectedExerciseId = '';
  String get selectedExerciseId => _selectedExerciseId;
  set selectedExerciseId(String value) {
    _selectedExerciseId = value;
  }

  bool _isResting = false;
  bool get isResting => _isResting;
  set isResting(bool value) {
    _isResting = value;
  }

  int _restDuration = 60000;
  int get restDuration => _restDuration;
  set restDuration(int value) {
    _restDuration = value;
    prefs.setInt('ff_restDuration', value);
  }

  int _restRemaining = 60000;
  int get restRemaining => _restRemaining;
  set restRemaining(int value) {
    _restRemaining = value;
  }

  DateTime? _restStartTime;
  DateTime? get restStartTime => _restStartTime;
  set restStartTime(DateTime? value) {
    _restStartTime = value;
  }

  bool _isTimerPaused = true;
  bool get isTimerPaused => _isTimerPaused;
  set isTimerPaused(bool value) {
    _isTimerPaused = value;
  }

  DateTime? _workoutStartTime;
  DateTime? get workoutStartTime => _workoutStartTime;
  set workoutStartTime(DateTime? value) {
    _workoutStartTime = value;
  }

  List<String> _selectedExerciseIds = [];
  List<String> get selectedExerciseIds => _selectedExerciseIds;
  set selectedExerciseIds(List<String> value) {
    _selectedExerciseIds = value;
  }

  void addToSelectedExerciseIds(String value) {
    selectedExerciseIds.add(value);
  }

  void removeFromSelectedExerciseIds(String value) {
    selectedExerciseIds.remove(value);
  }

  void removeAtIndexFromSelectedExerciseIds(int index) {
    selectedExerciseIds.removeAt(index);
  }

  void updateSelectedExerciseIdsAtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    selectedExerciseIds[index] = updateFn(_selectedExerciseIds[index]);
  }

  void insertAtIndexInSelectedExerciseIds(int index, String value) {
    selectedExerciseIds.insert(index, value);
  }

  DateTime? _selectedDate;
  DateTime? get selectedDate => _selectedDate;
  set selectedDate(DateTime? value) {
    _selectedDate = value;
  }

  DateTime? _displayedMonth;
  DateTime? get displayedMonth => _displayedMonth;
  set displayedMonth(DateTime? value) {
    _displayedMonth = value;
  }

  bool _restTimerSound = true;
  bool get restTimerSound => _restTimerSound;
  set restTimerSound(bool value) {
    _restTimerSound = value;
    prefs.setBool('ff_restTimerSound', value);
  }
}

void _safeInit(Function() initializeField) {
  try {
    initializeField();
  } catch (_) {}
}

Future _safeInitAsync(Function() initializeField) async {
  try {
    await initializeField();
  } catch (_) {}
}
