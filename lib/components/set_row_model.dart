import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'dart:async';
import 'set_row_widget.dart' show SetRowWidget;
import 'package:flutter/material.dart';

class SetRowModel extends FlutterFlowModel<SetRowWidget> {
  ///  State fields for stateful widgets in this component.

  Completer<List<ExerciseSetsRow>>? requestCompleter;
  // State field(s) for tf_weight widget.
  FocusNode? tfWeightFocusNode;
  TextEditingController? tfWeightTextController;
  String? Function(BuildContext, String?)? tfWeightTextControllerValidator;
  // State field(s) for tf_reps widget.
  FocusNode? tfRepsFocusNode;
  TextEditingController? tfRepsTextController;
  String? Function(BuildContext, String?)? tfRepsTextControllerValidator;
  // Stores action output result for [Backend Call - Update Row(s)] action in Stack widget.
  List<ExerciseSetsRow>? setTimer;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    tfWeightFocusNode?.dispose();
    tfWeightTextController?.dispose();

    tfRepsFocusNode?.dispose();
    tfRepsTextController?.dispose();
  }

  /// Additional helper methods.
  Future waitForRequestCompleted({
    double minWait = 0,
    double maxWait = double.infinity,
  }) async {
    final stopwatch = Stopwatch()..start();
    while (true) {
      await Future.delayed(Duration(milliseconds: 50));
      final timeElapsed = stopwatch.elapsedMilliseconds;
      final requestComplete = requestCompleter?.isCompleted ?? false;
      if (timeElapsed > maxWait || (requestComplete && timeElapsed > minWait)) {
        break;
      }
    }
  }
}
