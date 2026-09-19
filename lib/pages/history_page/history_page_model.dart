import '/flutter_flow/flutter_flow_util.dart';
import 'history_page_widget.dart' show HistoryPageWidget;
import 'package:flutter/material.dart';

class HistoryPageModel extends FlutterFlowModel<HistoryPageWidget> {
  ///  Local state fields for this page.

  DateTime? selectedDate;

  ///  State fields for stateful widgets in this page.

  // State field(s) for Column widget.
  ScrollController? columnController;
  // State field(s) for Calendar widget.
  DateTime? calendarSelectedDay;

  @override
  void initState(BuildContext context) {
    columnController = ScrollController();
  }

  @override
  void dispose() {
    columnController?.dispose();
  }
}
