import '/flutter_flow/flutter_flow_util.dart';
import 'edit_profilein_app_widget.dart' show EditProfileinAppWidget;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EditProfileinAppModel extends FlutterFlowModel<EditProfileinAppWidget> {
  ///  State fields for stateful widgets in this component.

  DateTime? datePicked;
  // State field(s) for Column widget.
  ScrollController? columnController;
  bool isDataUploading_profilePicture = false;
  FFUploadedFile uploadedLocalFile_profilePicture =
      FFUploadedFile(bytes: Uint8List.fromList([]), originalFilename: '');
  String uploadedFileUrl_profilePicture = '';

  // State field(s) for Name widget.
  FocusNode? nameFocusNode;
  TextEditingController? nameTextController;
  String? Function(BuildContext, String?)? nameTextControllerValidator;
  // State field(s) for height widget.
  FocusNode? heightFocusNode;
  TextEditingController? heightTextController;
  String? Function(BuildContext, String?)? heightTextControllerValidator;
  // State field(s) for weight widget.
  FocusNode? weightFocusNode;
  TextEditingController? weightTextController;
  String? Function(BuildContext, String?)? weightTextControllerValidator;

  @override
  void initState(BuildContext context) {
    columnController = ScrollController();
  }

  @override
  void dispose() {
    columnController?.dispose();
    nameFocusNode?.dispose();
    nameTextController?.dispose();

    heightFocusNode?.dispose();
    heightTextController?.dispose();

    weightFocusNode?.dispose();
    weightTextController?.dispose();
  }
}
