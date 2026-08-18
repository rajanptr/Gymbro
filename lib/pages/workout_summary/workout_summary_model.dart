import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'workout_summary_widget.dart' show WorkoutSummaryWidget;
import 'package:flutter/material.dart';

class WorkoutSummaryModel extends FlutterFlowModel<WorkoutSummaryWidget> {
  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - Query Rows] action in WorkoutSummary widget.
  List<CompletedWorkoutsRow>? query;
  // State field(s) for Column widget.
  ScrollController? columnController;

  @override
  void initState(BuildContext context) {
    columnController = ScrollController();
  }

  @override
  void dispose() {
    columnController?.dispose();
  }
}
