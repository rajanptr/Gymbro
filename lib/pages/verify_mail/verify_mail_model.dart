import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'verify_mail_widget.dart' show VerifyMailWidget;
import 'package:flutter/material.dart';

class VerifyMailModel extends FlutterFlowModel<VerifyMailWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for PinCode widget.
  TextEditingController? pinCodeController;
  FocusNode? pinCodeFocusNode;
  String? Function(BuildContext, String?)? pinCodeControllerValidator;
  // Stores action output result for [Custom Action - verifyEmailWithToken] action in Create widget.
  bool? isVerify;

  @override
  void initState(BuildContext context) {
    pinCodeController = TextEditingController();
  }

  @override
  void dispose() {
    pinCodeFocusNode?.dispose();
    pinCodeController?.dispose();
  }
}
