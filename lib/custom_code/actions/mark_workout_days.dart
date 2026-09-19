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

Future<List<CalendarDayStruct>> markWorkoutDays(
  List<CalendarDayStruct> calendarDays,
  List<CompletedWorkoutsRow> workouts,
) async {
  final workoutDates = <String>{};

  for (final workout in workouts) {
    if (workout.startedAt != null) {
      // IMPORTANT:
      // Keep the Supabase timestamp in UTC.
      final d = workout.startedAt!.toUtc();

      workoutDates.add(
        '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}',
      );
    }
  }

  for (final day in calendarDays) {
    if (day.date == null) continue;

    final d = day.date!;

    final key =
        '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';

    day.status = workoutDates.contains(key) ? 'workout' : 'empty';
  }

  return calendarDays;
}
// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the `</>` button on the right!
