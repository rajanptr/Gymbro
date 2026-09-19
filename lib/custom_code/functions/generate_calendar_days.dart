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

List<CalendarDayStruct> generateCalendarDays(
  List<CompletedWorkoutsRow>? workouts,
  int? freezePoints,
  int? restDays,
  DateTime? monthDate,
  DateTime? accountCreatedAt,
) {
  if (monthDate == null || accountCreatedAt == null) {
    return <CalendarDayStruct>[];
  }

  final List<CompletedWorkoutsRow> workoutList =
      workouts ?? <CompletedWorkoutsRow>[];

  // ------------------------------------------------------------
  // DATE HELPERS
  // ------------------------------------------------------------

  DateTime localDay(DateTime date) {
    final DateTime local = date.toLocal();

    return DateTime(
      local.year,
      local.month,
      local.day,
    );
  }

  String dateKey(DateTime date) {
    return '${date.year}-'
        '${date.month.toString().padLeft(2, '0')}-'
        '${date.day.toString().padLeft(2, '0')}';
  }

  // ------------------------------------------------------------
  // SELECTED MONTH
  // ------------------------------------------------------------

  final DateTime localMonthDate = monthDate.toLocal();

  final DateTime month = DateTime(
    localMonthDate.year,
    localMonthDate.month,
    1,
  );

  // ------------------------------------------------------------
  // ACCOUNT CREATION DATE
  // ------------------------------------------------------------

  final DateTime accountDate = localDay(accountCreatedAt);

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
  // WORKOUT DAYS
  //
  // IMPORTANT:
  // DO NOT use .toLocal() here.
  //
  // GYMBRO uses the stored calendar date of started_at.
  //
  // Example:
  // 2026-09-18 21:05:23+00
  //
  // stays:
  // 2026-09-18
  //
  // instead of becoming:
  // 2026-09-19 in India.
  // ------------------------------------------------------------

  final Set<String> workoutDays = <String>{};

  for (final workout in workoutList) {
    final DateTime? startedAt = workout.startedAt;

    if (startedAt == null) {
      continue;
    }

    final DateTime workoutDate = startedAt;

    final String key = dateKey(workoutDate);

    workoutDays.add(key);
  }

  // ------------------------------------------------------------
  // BUILD CALENDAR
  // ------------------------------------------------------------

  final DateTime lastDayOfMonth = DateTime(
    month.year,
    month.month + 1,
    0,
  );

  final List<CalendarDayStruct> days = <CalendarDayStruct>[];

  // Monday = 1 ... Sunday = 7.
  final int firstWeekday = month.weekday;

  // ------------------------------------------------------------
  // LEADING DAYS
  // ------------------------------------------------------------

  for (int i = firstWeekday - 1; i > 0; i--) {
    final DateTime date = month.subtract(
      Duration(days: i),
    );

    days.add(
      CalendarDayStruct(
        dayNumber: date.day,
        isCurrentMonth: false,
        isToday: false,
        date: date,
        status: 'outside',
      ),
    );
  }

  // ------------------------------------------------------------
  // CURRENT MONTH DAYS
  // ------------------------------------------------------------

  for (int day = 1; day <= lastDayOfMonth.day; day++) {
    final DateTime date = DateTime(
      month.year,
      month.month,
      day,
    );

    final String key = dateKey(date);

    final bool isToday = date.year == today.year &&
        date.month == today.month &&
        date.day == today.day;

    String status;

    // ----------------------------------------------------------
    // BEFORE ACCOUNT CREATION
    // ----------------------------------------------------------

    if (date.isBefore(accountDate)) {
      status = 'outside';
    }

    // ----------------------------------------------------------
    // FUTURE
    // ----------------------------------------------------------

    else if (date.isAfter(today)) {
      status = 'future';
    }

    // ----------------------------------------------------------
    // WORKOUT
    // ----------------------------------------------------------

    else if (workoutDays.contains(key)) {
      status = 'workout';
    }

    // ----------------------------------------------------------
    // EMPTY
    // ----------------------------------------------------------

    else {
      status = 'empty';
    }

    days.add(
      CalendarDayStruct(
        dayNumber: day,
        isCurrentMonth: true,
        isToday: isToday,
        date: date,
        status: status,
      ),
    );
  }

  // ------------------------------------------------------------
  // TRAILING DAYS
  // ------------------------------------------------------------

  while (days.length % 7 != 0) {
    final DateTime lastDate = days.last.date!;

    final DateTime nextDate = lastDate.add(
      const Duration(days: 1),
    );

    days.add(
      CalendarDayStruct(
        dayNumber: nextDate.day,
        isCurrentMonth: false,
        isToday: false,
        date: nextDate,
        status: 'outside',
      ),
    );
  }

  return days;
}
