import '/flutter_flow/flutter_flow_util.dart';
import 'cardio_exercise_card_widget.dart' show CardioExerciseCardWidget;
import 'package:flutter/material.dart';

class CardioExerciseCardModel
    extends FlutterFlowModel<CardioExerciseCardWidget> {
  ///  Local state fields for this component.

  int durationMinutes = 0;

  int durationSeconds = 0;

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
