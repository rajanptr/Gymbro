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

import 'dart:io';
import 'dart:typed_data';

import 'package:gal/gal.dart';

Future<bool> saveWorkoutImageToGallery(
  String filePath,
) async {
  try {
    debugPrint('GYMBRO SAVE: $filePath');

    final File imageFile = File(filePath);

    // 1. Make sure the generated PNG exists.
    if (!await imageFile.exists()) {
      debugPrint('GYMBRO SAVE: File does not exist.');
      return false;
    }

    // 2. Read the PNG into memory.
    final Uint8List imageBytes = await imageFile.readAsBytes();

    if (imageBytes.isEmpty) {
      debugPrint('GYMBRO SAVE: Image bytes are empty.');
      return false;
    }

    debugPrint(
      'GYMBRO SAVE: ${imageBytes.length} bytes loaded.',
    );

    // 3. Check gallery permission.
    bool hasAccess = await Gal.hasAccess();

    debugPrint(
      'GYMBRO SAVE: Existing access = $hasAccess',
    );

    if (!hasAccess) {
      hasAccess = await Gal.requestAccess();

      debugPrint(
        'GYMBRO SAVE: Requested access = $hasAccess',
      );
    }

    if (!hasAccess) {
      debugPrint(
        'GYMBRO SAVE: Gallery permission denied.',
      );
      return false;
    }

    // 4. Save PNG bytes directly to the gallery.
    await Gal.putImageBytes(
      imageBytes,
      name: 'GYMBRO_${DateTime.now().millisecondsSinceEpoch}',
      album: 'GYMBRO',
    );

    debugPrint(
      'GYMBRO SAVE: IMAGE SAVED SUCCESSFULLY.',
    );

    return true;
  } catch (e, stackTrace) {
    debugPrint(
      'GYMBRO SAVE ERROR: $e',
    );

    debugPrint(
      stackTrace.toString(),
    );

    return false;
  }
}
// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the `</>` button on the right!
