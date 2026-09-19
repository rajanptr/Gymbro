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

import 'package:share_plus/share_plus.dart';

Future<bool> shareWorkoutImage(
  BuildContext context,
  String filePath,
) async {
  try {
    debugPrint('GYMBRO SHARE: ACTION STARTED');
    debugPrint('GYMBRO SHARE: filePath = $filePath');

    // ------------------------------------------------------------
    // CHECK PATH
    // ------------------------------------------------------------

    if (filePath.isEmpty) {
      debugPrint(
        'GYMBRO SHARE ERROR: filePath is EMPTY',
      );
      return false;
    }

    // ------------------------------------------------------------
    // CHECK FILE
    // ------------------------------------------------------------

    final File file = File(filePath);

    final bool exists = await file.exists();

    debugPrint(
      'GYMBRO SHARE: file exists = $exists',
    );

    if (!exists) {
      debugPrint(
        'GYMBRO SHARE ERROR: FILE DOES NOT EXIST',
      );
      return false;
    }

    final int fileSize = await file.length();

    debugPrint(
      'GYMBRO SHARE: file size = $fileSize bytes',
    );

    if (fileSize == 0) {
      debugPrint(
        'GYMBRO SHARE ERROR: FILE IS EMPTY',
      );
      return false;
    }

    // ------------------------------------------------------------
    // CREATE XFILE
    // ------------------------------------------------------------

    final XFile imageFile = XFile(
      filePath,
      mimeType: 'image/png',
      name: 'gymbro_workout.png',
    );

    debugPrint(
      'GYMBRO SHARE: XFile created',
    );

    // ------------------------------------------------------------
    // SHARE POSITION
    // ------------------------------------------------------------

    Rect? sharePositionOrigin;

    final RenderObject? renderObject = context.findRenderObject();

    if (renderObject is RenderBox) {
      sharePositionOrigin = renderObject.localToGlobal(
            Offset.zero,
          ) &
          renderObject.size;

      debugPrint(
        'GYMBRO SHARE: Share position available',
      );
    }

    // ------------------------------------------------------------
    // SHARE TEXT
    // ------------------------------------------------------------

    const String shareText = 'Just finished a workout 💪\n'
        'A little glimpse of my session — tracked with GYMBRO.\n\n'
        'Designed & built with ♥ by RAjan\n'
        'https://portfolio.byrajan.design/';

    // ------------------------------------------------------------
    // OPEN NATIVE SHARE SHEET
    // ------------------------------------------------------------

    debugPrint(
      'GYMBRO SHARE: OPENING NATIVE SHARE SHEET...',
    );

    final ShareResult result = await SharePlus.instance.share(
      ShareParams(
        files: [
          imageFile,
        ],
        text: shareText,
        title: 'GYMBRO Workout',
        subject: 'GYMBRO Workout',
        sharePositionOrigin: sharePositionOrigin,
        fileNameOverrides: [
          'gymbro_workout.png',
        ],
      ),
    );

    // ------------------------------------------------------------
    // RESULT
    // ------------------------------------------------------------

    debugPrint(
      'GYMBRO SHARE: RESULT = ${result.status}',
    );

    debugPrint(
      'GYMBRO SHARE: RAW = ${result.raw}',
    );

    if (result.status == ShareResultStatus.success) {
      debugPrint(
        'GYMBRO SHARE: SUCCESS',
      );

      return true;
    }

    if (result.status == ShareResultStatus.dismissed) {
      debugPrint(
        'GYMBRO SHARE: DISMISSED',
      );

      return false;
    }

    debugPrint(
      'GYMBRO SHARE: UNAVAILABLE',
    );

    return false;
  } catch (e, stackTrace) {
    debugPrint(
      'GYMBRO SHARE ERROR: $e',
    );

    debugPrint(
      'GYMBRO SHARE STACK TRACE:',
    );

    debugPrint(
      '$stackTrace',
    );

    return false;
  }
}

// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the `</>` button on the right!
