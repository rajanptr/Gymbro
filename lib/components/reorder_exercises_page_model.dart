import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'reorder_exercises_page_widget.dart' show ReorderExercisesPageWidget;
import 'package:flutter/material.dart';

class ReorderExercisesPageModel
    extends FlutterFlowModel<ReorderExercisesPageWidget> {
  ///  Local state fields for this component.

  List<WorkoutExercisesRow> reorderExercises = [];
  void addToReorderExercises(WorkoutExercisesRow item) =>
      reorderExercises.add(item);
  void removeFromReorderExercises(WorkoutExercisesRow item) =>
      reorderExercises.remove(item);
  void removeAtIndexFromReorderExercises(int index) =>
      reorderExercises.removeAt(index);
  void insertAtIndexInReorderExercises(int index, WorkoutExercisesRow item) =>
      reorderExercises.insert(index, item);
  void updateReorderExercisesAtIndex(
          int index, Function(WorkoutExercisesRow) updateFn) =>
      reorderExercises[index] = updateFn(reorderExercises[index]);

  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Backend Call - Query Rows] action in ReorderExercisesPage widget.
  List<WorkoutExercisesRow>? reorderable;
  // Stores action output result for [Custom Action - reorderWorkoutExercises] action in ListView widget.
  List<WorkoutExercisesRow>? reorderedExercises;
  // Stores action output result for [Backend Call - Update Row(s)] action in Button widget.
  List<WorkoutExercisesRow>? action;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
