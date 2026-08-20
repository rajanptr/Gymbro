import '/backend/supabase/supabase.dart';
import '/components/bottom_nav_widget.dart';
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
  // Model for bottomNav component.
  late BottomNavModel bottomNavModel;

  @override
  void initState(BuildContext context) {
    bottomNavModel = createModel(context, () => BottomNavModel());
  }

  @override
  void dispose() {
    bottomNavModel.dispose();
  }
}
