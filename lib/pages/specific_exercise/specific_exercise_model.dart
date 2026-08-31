import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'specific_exercise_widget.dart' show SpecificExerciseWidget;
import 'package:flutter/material.dart';

class SpecificExerciseModel extends FlutterFlowModel<SpecificExerciseWidget> {
  ///  Local state fields for this page.

  String? searchQuery;

  ///  State fields for stateful widgets in this page.

  // State field(s) for TabBar widget.
  TabController? tabBarController;
  int get tabBarCurrentIndex =>
      tabBarController != null ? tabBarController!.index : 0;
  int get tabBarPreviousIndex =>
      tabBarController != null ? tabBarController!.previousIndex : 0;

  // State field(s) for Row widget.
  ScrollController? rowController;

  @override
  void initState(BuildContext context) {
    rowController = ScrollController();
  }

  @override
  void dispose() {
    tabBarController?.dispose();
    rowController?.dispose();
  }
}
