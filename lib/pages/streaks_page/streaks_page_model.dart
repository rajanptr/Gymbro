import '/backend/api_requests/api_calls.dart';
import '/backend/schema/structs/index.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'streaks_page_widget.dart' show StreaksPageWidget;
import 'package:flutter/material.dart';

class StreaksPageModel extends FlutterFlowModel<StreaksPageWidget> {
  ///  Local state fields for this page.

  int currentStreak = 0;

  int? bestStreak = 0;

  int freezePoints = 0;

  DateTime? calendarSelectedDate;

  String? calendarDayStatus;

  DateTime? calendarMonth;

  List<CalendarDayStruct> calendarDays = [];
  void addToCalendarDays(CalendarDayStruct item) => calendarDays.add(item);
  void removeFromCalendarDays(CalendarDayStruct item) =>
      calendarDays.remove(item);
  void removeAtIndexFromCalendarDays(int index) => calendarDays.removeAt(index);
  void insertAtIndexInCalendarDays(int index, CalendarDayStruct item) =>
      calendarDays.insert(index, item);
  void updateCalendarDaysAtIndex(
          int index, Function(CalendarDayStruct) updateFn) =>
      calendarDays[index] = updateFn(calendarDays[index]);

  String? selectedCalendarStatus;

  List<int> restDays = [];
  void addToRestDays(int item) => restDays.add(item);
  void removeFromRestDays(int item) => restDays.remove(item);
  void removeAtIndexFromRestDays(int index) => restDays.removeAt(index);
  void insertAtIndexInRestDays(int index, int item) =>
      restDays.insert(index, item);
  void updateRestDaysAtIndex(int index, Function(int) updateFn) =>
      restDays[index] = updateFn(restDays[index]);

  List<String> freezeDays = [];
  void addToFreezeDays(String item) => freezeDays.add(item);
  void removeFromFreezeDays(String item) => freezeDays.remove(item);
  void removeAtIndexFromFreezeDays(int index) => freezeDays.removeAt(index);
  void insertAtIndexInFreezeDays(int index, String item) =>
      freezeDays.insert(index, item);
  void updateFreezeDaysAtIndex(int index, Function(String) updateFn) =>
      freezeDays[index] = updateFn(freezeDays[index]);

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - Query Rows] action in StreaksPage widget.
  List<CompletedWorkoutsRow>? streakQuery;
  // Stores action output result for [Backend Call - Query Rows] action in StreaksPage widget.
  List<ProfilesRow>? profileCreateQuery;
  // Stores action output result for [Backend Call - API (calculateFreezePoints)] action in StreaksPage widget.
  ApiCallResponse? calculateFreezePoints;
  // Stores action output result for [Custom Action - calculateCurrentStreak] action in StreaksPage widget.
  int? calculateStreak;
  // State field(s) for Column widget.
  ScrollController? columnController;
  // Stores action output result for [Backend Call - API (calculateFreezePoints)] action in Button widget.
  ApiCallResponse? recalculatePoints;
  // Stores action output result for [Custom Action - calculateCurrentStreak] action in Button widget.
  int? recalculateStreak;

  @override
  void initState(BuildContext context) {
    columnController = ScrollController();
  }

  @override
  void dispose() {
    columnController?.dispose();
  }
}
