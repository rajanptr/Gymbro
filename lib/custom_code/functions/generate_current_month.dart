import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import '/flutter_flow/custom_functions.dart';
import '/flutter_flow/lat_lng.dart';
import '/flutter_flow/place.dart';
import '/flutter_flow/uploaded_file.dart';
import '/backend/schema/structs/index.dart';
import '/backend/supabase/supabase.dart';
import '/auth/supabase_auth/auth_util.dart';

List<CalendarDayStruct> generateCurrentMonth(
  List<CompletedWorkoutsRow>? workouts,
  int? freezePoints,
  List<int>? restDays,
  DateTime? monthDate,
  DateTime? accountCreatedAt,
  List<String>? freezeDays,
) {
  final DateTime sourceMonth = monthDate ?? DateTime.now();

  final DateTime selectedMonth = DateTime(
    sourceMonth.year,
    sourceMonth.month,
    1,
  );

  // ------------------------------------------------------------
  // TODAY
  // ------------------------------------------------------------

  final DateTime now = DateTime.now();

  final DateTime today = DateTime(
    now.year,
    now.month,
    now.day,
  );

  // ------------------------------------------------------------
  // REST DAYS
  // ------------------------------------------------------------

  final Set<int> selectedRestDays = (restDays ?? <int>[]).toSet();

  // ------------------------------------------------------------
  // FREEZE DAYS
  // ------------------------------------------------------------

  final Set<String> selectedFreezeDays = (freezeDays ?? <String>[]).toSet();

  // ------------------------------------------------------------
  // WORKOUT DAYS
  //
  // IMPORTANT:
  // Do NOT use .toLocal().
  //
  // The stored started_at date is used directly.
  // ------------------------------------------------------------

  final Set<String> workoutDays = <String>{};

  for (final workout in workouts ?? <CompletedWorkoutsRow>[]) {
    final DateTime? startedAt = workout.startedAt;

    if (startedAt == null) {
      continue;
    }

    final DateTime workoutDate = startedAt;

    final String key = '${workoutDate.year}-'
        '${workoutDate.month.toString().padLeft(2, '0')}-'
        '${workoutDate.day.toString().padLeft(2, '0')}';

    workoutDays.add(key);
  }

  // ------------------------------------------------------------
  // ACCOUNT CREATION DATE
  // ------------------------------------------------------------

  DateTime? accountDate;

  if (accountCreatedAt != null) {
    accountDate = DateTime(
      accountCreatedAt.year,
      accountCreatedAt.month,
      accountCreatedAt.day,
    );
  }

  // ------------------------------------------------------------
  // CALENDAR SETUP
  // ------------------------------------------------------------

  final int firstWeekday = selectedMonth.weekday;

  final DateTime calendarStart = selectedMonth.subtract(
    Duration(days: firstWeekday - 1),
  );

  final int daysInMonth = DateTime(
    selectedMonth.year,
    selectedMonth.month + 1,
    0,
  ).day;

  final int totalCells = firstWeekday - 1 + daysInMonth;

  final int cellCount = totalCells + ((7 - (totalCells % 7)) % 7);

  final List<CalendarDayStruct> days = <CalendarDayStruct>[];

  // ------------------------------------------------------------
  // CREATE CALENDAR DAYS
  // ------------------------------------------------------------

  for (int i = 0; i < cellCount; i++) {
    final DateTime date = calendarStart.add(
      Duration(days: i),
    );

    final bool isCurrentMonth =
        date.year == selectedMonth.year && date.month == selectedMonth.month;

    final bool isToday = date.year == today.year &&
        date.month == today.month &&
        date.day == today.day;

    final String key = '${date.year}-'
        '${date.month.toString().padLeft(2, '0')}-'
        '${date.day.toString().padLeft(2, '0')}';

    final bool isRestDay = selectedRestDays.contains(
      date.weekday,
    );

    final bool isWorkout = workoutDays.contains(key);

    final bool isFreeze = selectedFreezeDays.contains(key);

    final bool isFuture = date.isAfter(today);

    String status;

    // ----------------------------------------------------------
    // OUTSIDE MONTH
    // ----------------------------------------------------------

    if (!isCurrentMonth) {
      status = 'outside';
    }

    // ----------------------------------------------------------
    // BEFORE ACCOUNT CREATION
    // ----------------------------------------------------------

    else if (accountDate != null && date.isBefore(accountDate)) {
      status = 'outside';
    }

    // ----------------------------------------------------------
    // WORKOUT
    //
    // Highest priority.
    // ----------------------------------------------------------

    else if (isWorkout) {
      status = 'workout';
    }

    // ----------------------------------------------------------
    // FREEZE
    // ----------------------------------------------------------

    else if (isFreeze) {
      status = 'freeze';
    }

    // ----------------------------------------------------------
    // REST DAY
    // ----------------------------------------------------------

    else if (isRestDay) {
      status = 'rest';
    }

    // ----------------------------------------------------------
    // FUTURE
    // ----------------------------------------------------------

    else if (isFuture) {
      status = 'future';
    }

    // ----------------------------------------------------------
    // EMPTY
    // ----------------------------------------------------------

    else {
      status = 'empty';
    }

    days.add(
      CalendarDayStruct(
        dayNumber: date.day,
        isCurrentMonth: isCurrentMonth,
        isToday: isToday,
        date: date,
        status: status,
      ),
    );
  }

  return days;
}
