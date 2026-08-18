import '/components/bottom_nav_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'history_page_widget.dart' show HistoryPageWidget;
import 'package:flutter/material.dart';

class HistoryPageModel extends FlutterFlowModel<HistoryPageWidget> {
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
