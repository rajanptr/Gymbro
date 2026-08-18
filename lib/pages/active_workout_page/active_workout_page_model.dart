import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_timer.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'active_workout_page_widget.dart' show ActiveWorkoutPageWidget;
import 'dart:async';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:flutter/material.dart';

class ActiveWorkoutPageModel extends FlutterFlowModel<ActiveWorkoutPageWidget> {
  ///  Local state fields for this page.

  List<String> selectedExerciseIds = [];
  void addToSelectedExerciseIds(String item) => selectedExerciseIds.add(item);
  void removeFromSelectedExerciseIds(String item) =>
      selectedExerciseIds.remove(item);
  void removeAtIndexFromSelectedExerciseIds(int index) =>
      selectedExerciseIds.removeAt(index);
  void insertAtIndexInSelectedExerciseIds(int index, String item) =>
      selectedExerciseIds.insert(index, item);
  void updateSelectedExerciseIdsAtIndex(int index, Function(String) updateFn) =>
      selectedExerciseIds[index] = updateFn(selectedExerciseIds[index]);

  ///  State fields for stateful widgets in this page.

  // State field(s) for TimerMain widget.
  final timerMainInitialTimeMs = 0;
  int timerMainMilliseconds = 0;
  String timerMainValue = StopWatchTimer.getDisplayTime(0, milliSecond: false);
  FlutterFlowTimerController timerMainController =
      FlutterFlowTimerController(StopWatchTimer(mode: StopWatchMode.countUp));

  // State field(s) for Column widget.
  ScrollController? columnController;
  // State field(s) for exercisenote widget.
  FocusNode? exercisenoteFocusNode;
  TextEditingController? exercisenoteTextController;
  String? Function(BuildContext, String?)? exercisenoteTextControllerValidator;
  Completer<List<WorkoutSessionsRow>>? requestCompleter;

  @override
  void initState(BuildContext context) {
    columnController = ScrollController();
  }

  @override
  void dispose() {
    timerMainController.dispose();
    columnController?.dispose();
    exercisenoteFocusNode?.dispose();
    exercisenoteTextController?.dispose();
  }

  /// Additional helper methods.
  Future waitForRequestCompleted({
    double minWait = 0,
    double maxWait = double.infinity,
  }) async {
    final stopwatch = Stopwatch()..start();
    while (true) {
      await Future.delayed(Duration(milliseconds: 50));
      final timeElapsed = stopwatch.elapsedMilliseconds;
      final requestComplete = requestCompleter?.isCompleted ?? false;
      if (timeElapsed > maxWait || (requestComplete && timeElapsed > minWait)) {
        break;
      }
    }
  }
}
