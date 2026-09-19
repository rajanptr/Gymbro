import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'edit_profile_widget.dart' show EditProfileWidget;
import 'package:flutter/material.dart';

class EditProfileModel extends FlutterFlowModel<EditProfileWidget> {
  ///  Local state fields for this page.

  String? gender;

  DateTime? selectedDOB;

  ///  State fields for stateful widgets in this page.

  bool isDataUploading_profile = false;
  FFUploadedFile uploadedLocalFile_profile =
      FFUploadedFile(bytes: Uint8List.fromList([]), originalFilename: '');
  String uploadedFileUrl_profile = '';

  // State field(s) for Name widget.
  FocusNode? nameFocusNode;
  TextEditingController? nameTextController;
  String? Function(BuildContext, String?)? nameTextControllerValidator;
  // Stores action output result for [Bottom Sheet - dobPicker] action in Row widget.
  DateTime? dateGot;
  // Stores action output result for [Backend Call - Upsert Row] action in Create widget.
  ProfilesRow? update;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    nameFocusNode?.dispose();
    nameTextController?.dispose();
  }
}
