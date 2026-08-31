import '/flutter_flow/flutter_flow_util.dart';
import 'change_email_widget.dart' show ChangeEmailWidget;
import 'package:flutter/material.dart';

class ChangeEmailModel extends FlutterFlowModel<ChangeEmailWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for Newemail widget.
  FocusNode? newemailFocusNode;
  TextEditingController? newemailTextController;
  String? Function(BuildContext, String?)? newemailTextControllerValidator;
  // State field(s) for Confirmnewemail widget.
  FocusNode? confirmnewemailFocusNode;
  TextEditingController? confirmnewemailTextController;
  String? Function(BuildContext, String?)?
      confirmnewemailTextControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    newemailFocusNode?.dispose();
    newemailTextController?.dispose();

    confirmnewemailFocusNode?.dispose();
    confirmnewemailTextController?.dispose();
  }
}
