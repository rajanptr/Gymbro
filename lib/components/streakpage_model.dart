import '/backend/schema/structs/index.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'streakpage_widget.dart' show StreakpageWidget;
import 'package:flutter/material.dart';

class StreakpageModel extends FlutterFlowModel<StreakpageWidget> {
  ///  Local state fields for this component.

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

  DateTime? displayedMonth;

  int? currentStreak = 0;

  int? longestStreak = 0;

  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Custom Action - generateCalendarDays] action in streakpage widget.
  List<CalendarDayStruct>? calendarday;
  // Stores action output result for [Backend Call - Query Rows] action in streakpage widget.
  List<CompletedWorkoutsRow>? completedWorkouts;
  // Stores action output result for [Custom Action - markWorkoutDays] action in streakpage widget.
  List<CalendarDayStruct>? markWorkoutDays;
  // Stores action output result for [Custom Action - calculateCurrentStreak] action in streakpage widget.
  int? streak;
  // State field(s) for Column widget.
  ScrollController? columnController;
  // Stores action output result for [Custom Action - changeDisplayedMonth] action in Icon widget.
  DateTime? newMonthprev;
  // Stores action output result for [Custom Action - generateCalendarDays] action in Icon widget.
  List<CalendarDayStruct>? calendarOutputprev;
  // Stores action output result for [Custom Action - markWorkoutDays] action in Icon widget.
  List<CalendarDayStruct>? markedCalendarprev;
  // Stores action output result for [Custom Action - changeDisplayedMonth] action in Icon widget.
  DateTime? newMonth;
  // Stores action output result for [Custom Action - generateCalendarDays] action in Icon widget.
  List<CalendarDayStruct>? calendarOutput;
  // Stores action output result for [Custom Action - markWorkoutDays] action in Icon widget.
  List<CalendarDayStruct>? markedCalendar;

  @override
  void initState(BuildContext context) {
    columnController = ScrollController();
  }

  @override
  void dispose() {
    columnController?.dispose();
  }
}
