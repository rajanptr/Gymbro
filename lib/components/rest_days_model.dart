import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'rest_days_widget.dart' show RestDaysWidget;
import 'package:flutter/material.dart';

class RestDaysModel extends FlutterFlowModel<RestDaysWidget> {
  ///  Local state fields for this component.

  List<int> selectedDays = [];
  void addToSelectedDays(int item) => selectedDays.add(item);
  void removeFromSelectedDays(int item) => selectedDays.remove(item);
  void removeAtIndexFromSelectedDays(int index) => selectedDays.removeAt(index);
  void insertAtIndexInSelectedDays(int index, int item) =>
      selectedDays.insert(index, item);
  void updateSelectedDaysAtIndex(int index, Function(int) updateFn) =>
      selectedDays[index] = updateFn(selectedDays[index]);

  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Backend Call - Query Rows] action in restDays widget.
  List<ProfilesRow>? profileQuery;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
