import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'add_exercise_bottom_sheet_widget.dart'
    show AddExerciseBottomSheetWidget;
import 'dart:async';
import 'package:flutter/material.dart';

class AddExerciseBottomSheetModel
    extends FlutterFlowModel<AddExerciseBottomSheetWidget> {
  ///  Local state fields for this component.

  List<String> selectedExercises = [''];
  void addToSelectedExercises(String item) => selectedExercises.add(item);
  void removeFromSelectedExercises(String item) =>
      selectedExercises.remove(item);
  void removeAtIndexFromSelectedExercises(int index) =>
      selectedExercises.removeAt(index);
  void insertAtIndexInSelectedExercises(int index, String item) =>
      selectedExercises.insert(index, item);
  void updateSelectedExercisesAtIndex(int index, Function(String) updateFn) =>
      selectedExercises[index] = updateFn(selectedExercises[index]);

  String? searchField;

  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Backend Call - Query Rows] action in AddExerciseBottomSheet widget.
  List<WorkoutExercisesRow>? existingExercises;
  // State field(s) for Search widget.
  FocusNode? searchFocusNode;
  TextEditingController? searchTextController;
  String? Function(BuildContext, String?)? searchTextControllerValidator;
  // Stores action output result for [Backend Call - Query Rows] action in Button widget.
  List<WorkoutExercisesRow>? queryRows;
  // Stores action output result for [Backend Call - Insert Row] action in Button widget.
  WorkoutExercisesRow? newWorkoutExercise;
  Completer<List<WorkoutExercisesRow>>? requestCompleter;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    searchFocusNode?.dispose();
    searchTextController?.dispose();
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
