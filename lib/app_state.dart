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
    _safeInit(() {
      _selectedAppIcon =
          prefs.getString('ff_selectedAppIcon') ?? _selectedAppIcon;
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

  List<String> _appIconAssets = [
    'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/gymbro-3xo72g/assets/qniicnur9chf/Logo_7.png',
    'https://picsum.photos/seed/22/600',
    'https://picsum.photos/seed/453/600'
  ];
  List<String> get appIconAssets => _appIconAssets;
  set appIconAssets(List<String> value) {
    _appIconAssets = value;
  }

  void addToAppIconAssets(String value) {
    appIconAssets.add(value);
  }

  void removeFromAppIconAssets(String value) {
    appIconAssets.remove(value);
  }

  void removeAtIndexFromAppIconAssets(int index) {
    appIconAssets.removeAt(index);
  }

  void updateAppIconAssetsAtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    appIconAssets[index] = updateFn(_appIconAssets[index]);
  }

  void insertAtIndexInAppIconAssets(int index, String value) {
    appIconAssets.insert(index, value);
  }

  List<String> _appIconNames = [
    'GYMBRO Default',
    'GYMBRO Light',
    'GYMBRO Dark'
  ];
  List<String> get appIconNames => _appIconNames;
  set appIconNames(List<String> value) {
    _appIconNames = value;
  }

  void addToAppIconNames(String value) {
    appIconNames.add(value);
  }

  void removeFromAppIconNames(String value) {
    appIconNames.remove(value);
  }

  void removeAtIndexFromAppIconNames(int index) {
    appIconNames.removeAt(index);
  }

  void updateAppIconNamesAtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    appIconNames[index] = updateFn(_appIconNames[index]);
  }

  void insertAtIndexInAppIconNames(int index, String value) {
    appIconNames.insert(index, value);
  }

  String _selectedAppIcon = '';
  String get selectedAppIcon => _selectedAppIcon;
  set selectedAppIcon(String value) {
    _selectedAppIcon = value;
    prefs.setString('ff_selectedAppIcon', value);
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
