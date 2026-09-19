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

String? getCalendarDayStatus(
  List<CompletedWorkoutsRow>? workouts,
  int? freezePoints,
  List<int>? restDays,
  DateTime? date,
) {
  if (date == null) {
    return 'empty';
  }

  // ------------------------------------------------------------
  // SELECTED DATE
  // ------------------------------------------------------------

  final DateTime selectedDate = DateTime(
    date.year,
    date.month,
    date.day,
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
  // FUTURE
  // ------------------------------------------------------------

  if (selectedDate.isAfter(today)) {
    return 'future';
  }

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
  // SELECTED DATE KEY
  // ------------------------------------------------------------

  final String selectedKey = '${selectedDate.year}-'
      '${selectedDate.month.toString().padLeft(2, '0')}-'
      '${selectedDate.day.toString().padLeft(2, '0')}';

  // ------------------------------------------------------------
  // WORKOUT
  // ------------------------------------------------------------

  if (workoutDays.contains(selectedKey)) {
    return 'workout';
  }

  // ------------------------------------------------------------
  // REST DAY
  //
  // Monday = 1
  // Tuesday = 2
  // ...
  // Sunday = 7
  // ------------------------------------------------------------

  final List<int> selectedRestDays = restDays ?? <int>[];

  if (selectedRestDays.contains(
    selectedDate.weekday,
  )) {
    return 'rest';
  }

  // ------------------------------------------------------------
  // EMPTY
  // ------------------------------------------------------------

  return 'empty';
}
