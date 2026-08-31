import '/flutter_flow/flutter_flow_util.dart';
import 'change_password_widget.dart' show ChangePasswordWidget;
import 'package:flutter/material.dart';

class ChangePasswordModel extends FlutterFlowModel<ChangePasswordWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for Newpassword widget.
  FocusNode? newpasswordFocusNode;
  TextEditingController? newpasswordTextController;
  late bool newpasswordVisibility;
  String? Function(BuildContext, String?)? newpasswordTextControllerValidator;
  // State field(s) for Confirmnewpassword widget.
  FocusNode? confirmnewpasswordFocusNode;
  TextEditingController? confirmnewpasswordTextController;
  late bool confirmnewpasswordVisibility;
  String? Function(BuildContext, String?)?
      confirmnewpasswordTextControllerValidator;

  @override
  void initState(BuildContext context) {
    newpasswordVisibility = false;
    confirmnewpasswordVisibility = false;
  }

  @override
  void dispose() {
    newpasswordFocusNode?.dispose();
    newpasswordTextController?.dispose();

    confirmnewpasswordFocusNode?.dispose();
    confirmnewpasswordTextController?.dispose();
  }
}
