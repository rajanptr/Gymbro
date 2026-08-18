import '/flutter_flow/flutter_flow_util.dart';
import 'strength_exercise_card_widget.dart' show StrengthExerciseCardWidget;
import 'package:flutter/material.dart';

class StrengthExerciseCardModel
    extends FlutterFlowModel<StrengthExerciseCardWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for exercisenote widget.
  FocusNode? exercisenoteFocusNode;
  TextEditingController? exercisenoteTextController;
  String? Function(BuildContext, String?)? exercisenoteTextControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    exercisenoteFocusNode?.dispose();
    exercisenoteTextController?.dispose();
  }
}
