import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'create_template_page_widget.dart' show CreateTemplatePageWidget;
import 'package:flutter/material.dart';

class CreateTemplatePageModel
    extends FlutterFlowModel<CreateTemplatePageWidget> {
  ///  Local state fields for this page.

  List<String> selectedExerciseIds = [];
  void addToSelectedExerciseIds(String item) => selectedExerciseIds.add(item);
  void removeFromSelectedExerciseIds(String item) =>
      selectedExerciseIds.remove(item);
  void removeAtIndexFromSelectedExerciseIds(int index) =>
      selectedExerciseIds.removeAt(index);
  void insertAtIndexInSelectedExerciseIds(int index, String item) =>
      selectedExerciseIds.insert(index, item);
  void updateSelectedExerciseIdsAtIndex(int index, Function(String) updateFn) =>
      selectedExerciseIds[index] = updateFn(selectedExerciseIds[index]);

  List<ExerciseLibraryRow> selectedExercises = [];
  void addToSelectedExercises(ExerciseLibraryRow item) =>
      selectedExercises.add(item);
  void removeFromSelectedExercises(ExerciseLibraryRow item) =>
      selectedExercises.remove(item);
  void removeAtIndexFromSelectedExercises(int index) =>
      selectedExercises.removeAt(index);
  void insertAtIndexInSelectedExercises(int index, ExerciseLibraryRow item) =>
      selectedExercises.insert(index, item);
  void updateSelectedExercisesAtIndex(
          int index, Function(ExerciseLibraryRow) updateFn) =>
      selectedExercises[index] = updateFn(selectedExercises[index]);

  ExerciseLibraryRow? reorderedExercise;

  String? reorderedExerciseId;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - Insert Row] action in Container widget.
  RoutineTemplatesRow? newTemplate;
  // Stores action output result for [Backend Call - Insert Row] action in Container widget.
  RoutineExercisesRow? ordernumber;
  // State field(s) for Tname widget.
  FocusNode? tnameFocusNode;
  TextEditingController? tnameTextController;
  String? Function(BuildContext, String?)? tnameTextControllerValidator;
  // State field(s) for exercisenote widget.
  FocusNode? exercisenoteFocusNode;
  TextEditingController? exercisenoteTextController;
  String? Function(BuildContext, String?)? exercisenoteTextControllerValidator;
  // Stores action output result for [Custom Action - reorderExercises] action in ListView widget.
  List<ExerciseLibraryRow>? reorderedExercises;
  // Stores action output result for [Bottom Sheet - ExercisePickerSheet] action in Button widget.
  List<String>? selectedExerciseIdsOutput;
  // Stores action output result for [Backend Call - Query Rows] action in Button widget.
  List<ExerciseLibraryRow>? queryRows;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    tnameFocusNode?.dispose();
    tnameTextController?.dispose();

    exercisenoteFocusNode?.dispose();
    exercisenoteTextController?.dispose();
  }
}
