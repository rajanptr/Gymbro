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

Future<List<ExerciseLibraryRow>> reorderExercises(
  List<ExerciseLibraryRow> list,
  int oldIndex,
  int newIndex,
) async {
  if (oldIndex < newIndex) {
    newIndex -= 1;
  }

  final item = list.removeAt(oldIndex);
  list.insert(newIndex, item);

  return list;
}
// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the `</>` button on the right!
