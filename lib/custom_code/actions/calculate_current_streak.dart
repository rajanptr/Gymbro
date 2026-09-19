// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/actions/index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

Future<int> calculateCurrentStreak(
  List<CompletedWorkoutsRow>? workouts,
  int? freezePoints,
  List<int>? restDays,
  List<String>? freezeDays,
) async {
  /// MODIFY CODE ONLY BELOW THIS LINE

  final List<CompletedWorkoutsRow> workoutList =
      workouts ?? <CompletedWorkoutsRow>[];

  if (workoutList.isEmpty) {
    return 0;
  }

  // ------------------------------------------------------------
  // CREATE UNIQUE WORKOUT DATES
  //
  // IMPORTANT:
  // Do NOT use .toLocal().
  //
  // GYMBRO uses the stored date from started_at as the
  // workout calendar date.
  // ------------------------------------------------------------

  final Set<String> workoutDays = <String>{};

  for (final workout in workoutList) {
    final DateTime? startedAt = workout.startedAt;

    if (startedAt == null) {
      continue;
    }

    final String key = '${startedAt.year}-'
        '${startedAt.month.toString().padLeft(2, '0')}-'
        '${startedAt.day.toString().padLeft(2, '0')}';

    workoutDays.add(key);
  }

  if (workoutDays.isEmpty) {
    return 0;
  }

  // ------------------------------------------------------------
  // REST DAYS
  // ------------------------------------------------------------

  final Set<int> selectedRestDays = (restDays ?? <int>[]).toSet();

  // ------------------------------------------------------------
  // FREEZE DAYS
  // ------------------------------------------------------------

  final Set<String> selectedFreezeDays =
      (freezeDays ?? <String>[]).map((freezeDay) {
    try {
      final DateTime parsed = DateTime.parse(freezeDay);

      return '${parsed.year}-'
          '${parsed.month.toString().padLeft(2, '0')}-'
          '${parsed.day.toString().padLeft(2, '0')}';
    } catch (_) {
      return freezeDay;
    }
  }).toSet();

  // ------------------------------------------------------------
  // TODAY
  // ------------------------------------------------------------

  final DateTime now = DateTime.now();

  final DateTime today = DateTime(
    now.year,
    now.month,
    now.day,
  );

  final String todayKey = '${today.year}-'
      '${today.month.toString().padLeft(2, '0')}-'
      '${today.day.toString().padLeft(2, '0')}';

  // ------------------------------------------------------------
  // DETERMINE STARTING DATE
  // ------------------------------------------------------------

  DateTime currentDay;

  if (workoutDays.contains(todayKey)) {
    currentDay = today;
  } else {
    currentDay = today.subtract(
      const Duration(days: 1),
    );
  }

  // ------------------------------------------------------------
  // CALCULATE CURRENT STREAK
  // ------------------------------------------------------------

  int streak = 0;

  while (true) {
    final String key = '${currentDay.year}-'
        '${currentDay.month.toString().padLeft(2, '0')}-'
        '${currentDay.day.toString().padLeft(2, '0')}';

    // ----------------------------------------------------------
    // WORKOUT
    // ----------------------------------------------------------

    if (workoutDays.contains(key)) {
      streak++;
    }

    // ----------------------------------------------------------
    // MANUAL FREEZE
    // ----------------------------------------------------------

    else if (selectedFreezeDays.contains(key)) {
      streak++;
    }

    // ----------------------------------------------------------
    // PLANNED REST DAY
    // ----------------------------------------------------------

    else if (selectedRestDays.contains(
      currentDay.weekday,
    )) {
      // Rest day protects the streak.
      // It does not increase the streak.
    }

    // ----------------------------------------------------------
    // MISSED DAY
    // ----------------------------------------------------------

    else {
      break;
    }

    currentDay = currentDay.subtract(
      const Duration(days: 1),
    );
  }

  return streak;

  /// MODIFY CODE ONLY ABOVE THIS LINE
}
