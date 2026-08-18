import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'workout_start_widget.dart' show WorkoutStartWidget;
import 'package:flutter/material.dart';

class WorkoutStartModel extends FlutterFlowModel<WorkoutStartWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for workoutNameController widget.
  FocusNode? workoutNameControllerFocusNode;
  TextEditingController? workoutNameControllerTextController;
  String? Function(BuildContext, String?)?
      workoutNameControllerTextControllerValidator;
  // Stores action output result for [Backend Call - Query Rows] action in Button widget.
  List<WorkoutSessionsRow>? latestWorkout;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    workoutNameControllerFocusNode?.dispose();
    workoutNameControllerTextController?.dispose();
  }
}
