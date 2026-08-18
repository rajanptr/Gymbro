// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/backend/supabase/supabase.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/actions/index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

Future<List<CalendarDayStruct>> generateCalendarDays(
  DateTime displayedMonth,
) async {
  final firstDay = DateTime(
    displayedMonth.year,
    displayedMonth.month,
    1,
  );

  final lastDay = DateTime(
    displayedMonth.year,
    displayedMonth.month + 1,
    0,
  );

  final today = DateTime.now();

  final List<CalendarDayStruct> calendar = [];

  // Monday = 1, Sunday = 7
  final int leadingEmpty = firstDay.weekday - 1;

  // Leading empty cells
  for (int i = 0; i < leadingEmpty; i++) {
    calendar.add(
      CalendarDayStruct(
        dayNumber: 0,
        date: null,
        isCurrentMonth: false,
        isToday: false,
        hasWorkout: false,
        isRestDay: false,
        isEmpty: true,
      ),
    );
  }

  // Current month days
  for (int day = 1; day <= lastDay.day; day++) {
    final currentDate = DateTime(
      displayedMonth.year,
      displayedMonth.month,
      day,
    );

    calendar.add(
      CalendarDayStruct(
        dayNumber: day,
        date: currentDate,
        isCurrentMonth: true,
        isToday: currentDate.year == today.year &&
            currentDate.month == today.month &&
            currentDate.day == today.day,
        hasWorkout: false,
        isRestDay: false,
        isEmpty: false,
      ),
    );
  }

  // Fill remaining cells to complete the final week
  while (calendar.length % 7 != 0) {
    calendar.add(
      CalendarDayStruct(
        dayNumber: 0,
        date: null,
        isCurrentMonth: false,
        isToday: false,
        hasWorkout: false,
        isRestDay: false,
        isEmpty: true,
      ),
    );
  }

  // Ensure either 5 rows (35 cells) or 6 rows (42 cells)
  if (calendar.length < 35) {
    while (calendar.length < 35) {
      calendar.add(
        CalendarDayStruct(
          dayNumber: 0,
          date: null,
          isCurrentMonth: false,
          isToday: false,
          hasWorkout: false,
          isRestDay: false,
          isEmpty: true,
        ),
      );
    }
  } else if (calendar.length > 35 && calendar.length < 42) {
    while (calendar.length < 42) {
      calendar.add(
        CalendarDayStruct(
          dayNumber: 0,
          date: null,
          isCurrentMonth: false,
          isToday: false,
          hasWorkout: false,
          isRestDay: false,
          isEmpty: true,
        ),
      );
    }
  }

  return calendar;
}
// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the `</>` button on the right!
