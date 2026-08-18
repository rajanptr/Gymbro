import '/components/bottom_nav_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'profile_page_widget.dart' show ProfilePageWidget;
import 'package:flutter/material.dart';

class ProfilePageModel extends FlutterFlowModel<ProfilePageWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for Column widget.
  ScrollController? columnController;
  // Model for bottomNav component.
  late BottomNavModel bottomNavModel;

  @override
  void initState(BuildContext context) {
    columnController = ScrollController();
    bottomNavModel = createModel(context, () => BottomNavModel());
  }

  @override
  void dispose() {
    columnController?.dispose();
    bottomNavModel.dispose();
  }
}
