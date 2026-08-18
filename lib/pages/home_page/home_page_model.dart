import '/backend/supabase/supabase.dart';
import '/components/bottom_nav_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'dart:async';
import 'home_page_widget.dart' show HomePageWidget;
import 'package:flutter/material.dart';

class HomePageModel extends FlutterFlowModel<HomePageWidget> {
  ///  Local state fields for this page.

  int? currentStreak;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - Query Rows] action in HomePage widget.
  List<ProfilesRow>? currenUser;
  // Stores action output result for [Backend Call - Query Rows] action in HomePage widget.
  List<CompletedWorkoutsRow>? completedWorkouts;
  // Stores action output result for [Custom Action - calculateCurrentStreak] action in HomePage widget.
  int? streak;
  // State field(s) for Column widget.
  ScrollController? columnController;
  Completer<List<ProfilesRow>>? requestCompleter2;
  Completer<List<WaterTodaySummaryRow>>? requestCompleter1;
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
    columnController = ScrollController();
    bottomNavModel = createModel(context, () => BottomNavModel());
  }

  @override
  void dispose() {
    columnController?.dispose();
    bottomNavModel.dispose();
  }

  /// Additional helper methods.
  Future waitForRequestCompleted2({
    double minWait = 0,
    double maxWait = double.infinity,
  }) async {
    final stopwatch = Stopwatch()..start();
    while (true) {
      await Future.delayed(Duration(milliseconds: 50));
      final timeElapsed = stopwatch.elapsedMilliseconds;
      final requestComplete = requestCompleter2?.isCompleted ?? false;
      if (timeElapsed > maxWait || (requestComplete && timeElapsed > minWait)) {
        break;
      }
    }
  }

  Future waitForRequestCompleted1({
    double minWait = 0,
    double maxWait = double.infinity,
  }) async {
    final stopwatch = Stopwatch()..start();
    while (true) {
      await Future.delayed(Duration(milliseconds: 50));
      final timeElapsed = stopwatch.elapsedMilliseconds;
      final requestComplete = requestCompleter1?.isCompleted ?? false;
      if (timeElapsed > maxWait || (requestComplete && timeElapsed > minWait)) {
        break;
      }
    }
  }
}
