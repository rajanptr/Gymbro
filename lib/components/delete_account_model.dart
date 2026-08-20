import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'delete_account_widget.dart' show DeleteAccountWidget;
import 'package:flutter/material.dart';

class DeleteAccountModel extends FlutterFlowModel<DeleteAccountWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for delete widget.
  FocusNode? deleteFocusNode;
  TextEditingController? deleteTextController;
  String? Function(BuildContext, String?)? deleteTextControllerValidator;
  // Stores action output result for [Backend Call - API (deleteAccount)] action in Button widget.
  ApiCallResponse? deleteAccount;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    deleteFocusNode?.dispose();
    deleteTextController?.dispose();
  }
}
