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
  List<CompletedWorkoutsRow> workouts,
) async {
  if (workouts.isEmpty) return 0;

  // Store unique workout dates as strings (yyyy-mm-dd)
  final Set<String> workoutDays = {};

  for (final workout in workouts) {
    if (workout.startedAt != null) {
      final d = workout.startedAt!.toLocal();
      workoutDays.add(
        '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}',
      );
    }
  }

  DateTime currentDay = DateTime.now();
  currentDay = DateTime(currentDay.year, currentDay.month, currentDay.day);

  int streak = 0;
  int missedDays = 0;

  while (true) {
    final key =
        '${currentDay.year}-${currentDay.month.toString().padLeft(2, '0')}-${currentDay.day.toString().padLeft(2, '0')}';

    if (workoutDays.contains(key)) {
      streak++;
      missedDays = 0;
    } else {
      missedDays++;

      if (missedDays >= 2) {
        break;
      }
    }

    currentDay = currentDay.subtract(const Duration(days: 1));
  }

  return streak;
}
// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the `</>` button on the right!
