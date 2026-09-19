import '/flutter_flow/flutter_flow_util.dart';
import 'edit_title_widget.dart' show EditTitleWidget;
import 'package:flutter/material.dart';

class EditTitleModel extends FlutterFlowModel<EditTitleWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for workoutNameController widget.
  FocusNode? workoutNameControllerFocusNode;
  TextEditingController? workoutNameControllerTextController;
  String? Function(BuildContext, String?)?
      workoutNameControllerTextControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    workoutNameControllerFocusNode?.dispose();
    workoutNameControllerTextController?.dispose();
  }
}
