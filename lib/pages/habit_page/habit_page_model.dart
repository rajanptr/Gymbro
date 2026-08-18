import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'habit_page_widget.dart' show HabitPageWidget;
import 'package:flutter/material.dart';

class HabitPageModel extends FlutterFlowModel<HabitPageWidget> {
  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - Query Rows] action in habitPage widget.
  List<ProfilesRow>? currenUser;
  // Stores action output result for [Backend Call - Query Rows] action in habitPage widget.
  List<ProfilesRow>? recheck;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
