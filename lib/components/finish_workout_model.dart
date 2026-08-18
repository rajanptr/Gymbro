import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'finish_workout_widget.dart' show FinishWorkoutWidget;
import 'package:flutter/material.dart';

class FinishWorkoutModel extends FlutterFlowModel<FinishWorkoutWidget> {
  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Backend Call - Query Rows] action in Button widget.
  List<WorkoutSessionsRow>? workoutSession;
  // Stores action output result for [Backend Call - Query Rows] action in Button widget.
  List<WorkoutExercisesRow>? workoutExercises;
  // Stores action output result for [Backend Call - Query Rows] action in Button widget.
  List<ExerciseSetsRow>? exerciseSets;
  // Stores action output result for [Backend Call - Insert Row] action in Button widget.
  CompletedWorkoutsRow? dataInserted;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
