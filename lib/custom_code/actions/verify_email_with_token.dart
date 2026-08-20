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

import 'package:supabase_flutter/supabase_flutter.dart';

Future<bool> verifyEmailWithToken(
  String email,
  String? token,
) async {
  // Add your function code here!
  // instantiate Supabase client
  final supabase = Supabase.instance.client;

  try {
    // call the supabase verifyOTP function
    // if successful, a response with the user and session is returned
    final AuthResponse res = await supabase.auth.verifyOTP(
      type: OtpType.signup,
      token: token ?? " ",
      email: email,
    );

    // return true if session is not null (i.e. user has signed in)
    return res.session != null;
  } on AuthException catch (e) {
    // catch any authenticatino errors and print them to the console
    print(e.message);
    return false;
  } catch (error) {
    // catch any other errors
    print(error);
    return false;
  }
}
// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the `</>` button on the right!
