import '/backend/api_requests/api_calls.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'workout_summary_widget.dart' show WorkoutSummaryWidget;
import 'package:flutter/material.dart';

class WorkoutSummaryModel extends FlutterFlowModel<WorkoutSummaryWidget> {
  ///  Local state fields for this page.

  int selectedShareCard = 0;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - Query Rows] action in WorkoutSummary widget.
  List<CompletedWorkoutsRow>? query;
  // Stores action output result for [Backend Call - Query Rows] action in WorkoutSummary widget.
  List<ProfilesRow>? profileCreateQuery;
  // Stores action output result for [Backend Call - API (calculateFreezePoints)] action in WorkoutSummary widget.
  ApiCallResponse? calculateFreezePoints;
  // Stores action output result for [Custom Action - calculateCurrentStreak] action in WorkoutSummary widget.
  int? calculateStreak;
  // State field(s) for Column widget.
  ScrollController? columnController;
  // State field(s) for PageView widget.
  PageController? pageViewController;

  int get pageViewCurrentIndex => pageViewController != null &&
          pageViewController!.hasClients &&
          pageViewController!.page != null
      ? pageViewController!.page!.round()
      : 0;
  // State field(s) for Row widget.
  ScrollController? rowController;
  // Stores action output result for [Custom Action - captureVolumeShareCard] action in Container widget.
  String? capturedImagePath;
  // Stores action output result for [Custom Action - saveWorkoutImageToGallery] action in Container widget.
  bool? saveWorkoutImageToGallery;
  // Stores action output result for [Custom Action - captureVolumeShareCard] action in Container widget.
  String? captureImage;

  @override
  void initState(BuildContext context) {
    columnController = ScrollController();
    rowController = ScrollController();
  }

  @override
  void dispose() {
    columnController?.dispose();
    rowController?.dispose();
  }
}
