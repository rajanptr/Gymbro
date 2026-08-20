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

Future reindexSets(
  String workoutExerciseId,
) async {
  // Add your function code here!
  final rows = await SupaFlow.client
      .from('exercise_sets')
      .select()
      .eq('workout_exercise_id', workoutExerciseId)
      .order('set_number');

  for (int i = 1; i < rows.length; i++) {
    await SupaFlow.client
        .from('exercise_sets')
        .update({'set_number': i}).eq('id', rows[i]['id']);
  }
}
