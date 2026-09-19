import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'add_workout_widget.dart' show AddWorkoutWidget;
import 'package:flutter/material.dart';

class AddWorkoutModel extends FlutterFlowModel<AddWorkoutWidget> {
  ///  Local state fields for this page.

  String? searchQuery;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - Insert Row] action in Button widget.
  WorkoutSessionsRow? newWorkoutSession;
  // Stores action output result for [Backend Call - Query Rows] action in Button widget.
  List<RoutineExercisesRow>? templateExercises;
  // Stores action output result for [Backend Call - Insert Row] action in Button widget.
  WorkoutExercisesRow? action3;
  // Stores action output result for [Backend Call - Query Rows] action in Button widget.
  List<RoutineSetsRow>? routineSets;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
