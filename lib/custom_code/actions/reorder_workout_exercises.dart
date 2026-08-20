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

Future<List<WorkoutExercisesRow>> reorderWorkoutExercises(
  List<WorkoutExercisesRow> list,
  int oldIndex,
  int newIndex,
) async {
  final reordered = List<WorkoutExercisesRow>.from(list);

  if (oldIndex < 0 ||
      oldIndex >= reordered.length ||
      newIndex < 0 ||
      newIndex >= reordered.length) {
    return reordered;
  }

  final item = reordered.removeAt(oldIndex);
  reordered.insert(newIndex, item);

  return reordered;
}
// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the `</>` button on the right!
