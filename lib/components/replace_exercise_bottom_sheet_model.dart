import '/flutter_flow/flutter_flow_util.dart';
import 'replace_exercise_bottom_sheet_widget.dart'
    show ReplaceExerciseBottomSheetWidget;
import 'package:flutter/material.dart';

class ReplaceExerciseBottomSheetModel
    extends FlutterFlowModel<ReplaceExerciseBottomSheetWidget> {
  ///  Local state fields for this component.

  String? searchQuery;

  ///  State fields for stateful widgets in this component.

  // State field(s) for Column widget.
  ScrollController? columnController;
  // State field(s) for searchExercise widget.
  FocusNode? searchExerciseFocusNode;
  TextEditingController? searchExerciseTextController;
  String? Function(BuildContext, String?)?
      searchExerciseTextControllerValidator;
  // State field(s) for Row widget.
  ScrollController? rowController;

  @override
  void initState(BuildContext context) {
    columnController = ScrollController();
    rowController = ScrollController();
  }

  @override
  void dispose() {
    columnController?.dispose();
    searchExerciseFocusNode?.dispose();
    searchExerciseTextController?.dispose();

    rowController?.dispose();
  }
}
