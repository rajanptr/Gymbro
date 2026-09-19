import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'create_custom_exercise_widget.dart' show CreateCustomExerciseWidget;
import 'package:flutter/material.dart';

class CreateCustomExerciseModel
    extends FlutterFlowModel<CreateCustomExerciseWidget> {
  ///  Local state fields for this component.

  String? selectedMuscle;

  String? selectedEquipment;

  ///  State fields for stateful widgets in this component.

  // State field(s) for Name widget.
  FocusNode? nameFocusNode;
  TextEditingController? nameTextController;
  String? Function(BuildContext, String?)? nameTextControllerValidator;
  // State field(s) for PMuscle widget.
  String? pMuscleValue;
  FormFieldController<String>? pMuscleValueController;
  // State field(s) for Equipment widget.
  String? equipmentValue;
  FormFieldController<String>? equipmentValueController;
  // Stores action output result for [Backend Call - Upsert Row] action in Button widget.
  ExerciseLibraryRow? createExercisenoiD;
  // Stores action output result for [Backend Call - Upsert Row] action in Button widget.
  ExerciseLibraryRow? createExercise;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    nameFocusNode?.dispose();
    nameTextController?.dispose();
  }
}
