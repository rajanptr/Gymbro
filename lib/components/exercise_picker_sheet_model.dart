import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'exercise_picker_sheet_widget.dart' show ExercisePickerSheetWidget;
import 'package:flutter/material.dart';

class ExercisePickerSheetModel
    extends FlutterFlowModel<ExercisePickerSheetWidget> {
  ///  Local state fields for this component.

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

  String? searchQuery;

  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Backend Call - Query Rows] action in ExercisePickerSheet widget.
  List<RoutineExercisesRow>? result;
  // State field(s) for searchExercise widget.
  FocusNode? searchExerciseFocusNode;
  TextEditingController? searchExerciseTextController;
  String? Function(BuildContext, String?)?
      searchExerciseTextControllerValidator;
  // State field(s) for Row widget.
  ScrollController? rowController;

  @override
  void initState(BuildContext context) {
    rowController = ScrollController();
  }

  @override
  void dispose() {
    searchExerciseFocusNode?.dispose();
    searchExerciseTextController?.dispose();

    rowController?.dispose();
  }
}
