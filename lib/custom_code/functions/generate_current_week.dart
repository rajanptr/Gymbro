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

List<CalendarDayStruct> generateCurrentWeek(
  List<CompletedWorkoutsRow>? workouts,
  int? freezePoints,
  List<int>? restDays,
  List<String>? freezeDays,
) {
  final DateTime now = DateTime.now();

  final DateTime today = DateTime(
    now.year,
    now.month,
    now.day,
  );

  final List<int> selectedRestDays = restDays ?? <int>[];

  final Set<String> selectedFreezeDays = (freezeDays ?? <String>[]).toSet();

  final Set<String> workoutDays = {};

  for (final workout in workouts ?? <CompletedWorkoutsRow>[]) {
    final startedAt = workout.startedAt;

    if (startedAt == null) continue;

    final DateTime workoutDate = startedAt.toLocal();

    final String key = '${workoutDate.year}-'
        '${workoutDate.month.toString().padLeft(2, '0')}-'
        '${workoutDate.day.toString().padLeft(2, '0')}';

    workoutDays.add(key);
  }

  final DateTime monday = today.subtract(
    Duration(days: today.weekday - 1),
  );

  final List<CalendarDayStruct> week = [];

  for (int i = 0; i < 7; i++) {
    final DateTime day = monday.add(Duration(days: i));

    final String key = '${day.year}-'
        '${day.month.toString().padLeft(2, '0')}-'
        '${day.day.toString().padLeft(2, '0')}';

    final bool isToday = day.year == today.year &&
        day.month == today.month &&
        day.day == today.day;

    String status;

    if (day.isAfter(today)) {
      status = 'future';
    } else if (workoutDays.contains(key)) {
      status = 'workout';
    } else if (selectedFreezeDays.contains(key)) {
      status = 'freeze';
    } else if (selectedRestDays.contains(
      day.weekday,
    )) {
      status = 'rest';
    } else {
      status = 'empty';
    }

    week.add(
      CalendarDayStruct(
        dayNumber: day.day,
        isCurrentMonth: true,
        isToday: isToday,
        date: day,
        status: status,
      ),
    );
  }

  return week;
}
