import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'set_water_goal_sheet_widget.dart' show SetWaterGoalSheetWidget;
import 'package:flutter/material.dart';

class SetWaterGoalSheetModel extends FlutterFlowModel<SetWaterGoalSheetWidget> {
  ///  Local state fields for this component.

  int? selectedWaterGoal = 2000;

  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Backend Call - Query Rows] action in SetWaterGoalSheet widget.
  List<WaterGoalsRow>? watetIntake;
  // Stores action output result for [Backend Call - Query Rows] action in Button widget.
  List<WaterGoalsRow>? waterGoal;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
