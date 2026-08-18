import '/components/bottom_nav_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'add_workout_widget.dart' show AddWorkoutWidget;
import 'package:flutter/material.dart';

class AddWorkoutModel extends FlutterFlowModel<AddWorkoutWidget> {
  ///  Local state fields for this page.

  String? searchQuery;

  ///  State fields for stateful widgets in this page.

  // Model for bottomNav component.
  late BottomNavModel bottomNavModel;

  @override
  void initState(BuildContext context) {
    bottomNavModel = createModel(context, () => BottomNavModel());
  }

  @override
  void dispose() {
    bottomNavModel.dispose();
  }
}
