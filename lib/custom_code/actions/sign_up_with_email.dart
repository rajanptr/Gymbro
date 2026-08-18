// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/backend/supabase/supabase.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/actions/index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:supabase_flutter/supabase_flutter.dart';

Future<String?> signUpWithEmail(
  String email,
  String password,
  String confirmPassword,
) async {
  // Add your function code here!
  if (password == confirmPassword) {
    try {
      final supabase = SupaFlow.client;

      final AuthResponse res = await supabase.auth.signUp(
        email: email,
        password: password,
      );
      return null;
    } on AuthException catch (e) {
      return (e.message);
    }
  } else {
    return ("Passwords do not match.");
  }
}

// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the `</>` button on the right!
