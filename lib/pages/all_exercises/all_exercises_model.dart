import '/flutter_flow/flutter_flow_util.dart';
import 'all_exercises_widget.dart' show AllExercisesWidget;
import 'package:flutter/material.dart';

class AllExercisesModel extends FlutterFlowModel<AllExercisesWidget> {
  ///  Local state fields for this page.

  String? searchQuery;

  ///  State fields for stateful widgets in this page.

  // State field(s) for searchExercise widget.
  FocusNode? searchExerciseFocusNode;
  TextEditingController? searchExerciseTextController;
  String? Function(BuildContext, String?)?
      searchExerciseTextControllerValidator;
  // State field(s) for Row widget.
  ScrollController? rowController;
  // State field(s) for Column widget.
  ScrollController? columnController;

  @override
  void initState(BuildContext context) {
    rowController = ScrollController();
    columnController = ScrollController();
  }

  @override
  void dispose() {
    searchExerciseFocusNode?.dispose();
    searchExerciseTextController?.dispose();

    rowController?.dispose();
    columnController?.dispose();
  }
}
