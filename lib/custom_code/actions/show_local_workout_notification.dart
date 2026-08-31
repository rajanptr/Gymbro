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

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

Future showLocalWorkoutNotification() async {
  final FlutterLocalNotificationsPlugin notifications =
      FlutterLocalNotificationsPlugin();

  // --------------------------------------------------
  // INITIALIZATION
  // --------------------------------------------------

  const AndroidInitializationSettings androidSettings =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  const DarwinInitializationSettings iosSettings = DarwinInitializationSettings(
    requestAlertPermission: true,
    requestBadgePermission: true,
    requestSoundPermission: true,

    // Show notification while GYMBRO is open
    defaultPresentAlert: true,
    defaultPresentBanner: true,
    defaultPresentList: true,
    defaultPresentSound: true,
    defaultPresentBadge: true,
  );

  const InitializationSettings settings = InitializationSettings(
    android: androidSettings,
    iOS: iosSettings,
  );

  final initialized = await notifications.initialize(
    settings,
    onDidReceiveNotificationResponse: (NotificationResponse response) {
      print(
        'GYMBRO: Notification tapped: ${response.payload}',
      );
    },
  );

  if (initialized != true) {
    print(
      'GYMBRO: Notification plugin failed to initialize',
    );

    // Do NOT block the app flow.
    return;
  }

  // --------------------------------------------------
  // iOS PERMISSION
  // --------------------------------------------------

  final iosPlugin = notifications.resolvePlatformSpecificImplementation<
      IOSFlutterLocalNotificationsPlugin>();

  if (iosPlugin != null) {
    final permission = await iosPlugin.requestPermissions(
      alert: true,
      badge: true,
      sound: true,
    );

    print(
      'GYMBRO: iOS notification permission: $permission',
    );

    // Permission denied does NOT stop the app flow.
  }

  // --------------------------------------------------
  // ANDROID PERMISSION + CHANNEL
  // --------------------------------------------------

  final androidPlugin = notifications.resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>();

  if (androidPlugin != null) {
    // Request permission, but don't block the app if denied.
    final permission = await androidPlugin.requestNotificationsPermission();

    print(
      'GYMBRO: Android notification permission: $permission',
    );

    // Create the notification channel regardless of permission result.
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'gymbro_workout',
      'Workout Notifications',
      description: 'Notifications related to completed workouts.',
      importance: Importance.high,
      playSound: true,
    );

    await androidPlugin.createNotificationChannel(
      channel,
    );
  }

  // --------------------------------------------------
  // NOTIFICATION DETAILS
  // --------------------------------------------------

  const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
    'gymbro_workout',
    'Workout Notifications',
    channelDescription: 'Notifications related to completed workouts.',
    importance: Importance.high,
    priority: Priority.high,
    playSound: true,
    enableVibration: true,
  );

  const DarwinNotificationDetails iosDetails = DarwinNotificationDetails(
    presentAlert: true,
    presentBanner: true,
    presentList: true,
    presentSound: true,
    presentBadge: true,
  );

  const NotificationDetails details = NotificationDetails(
    android: androidDetails,
    iOS: iosDetails,
  );

  // --------------------------------------------------
  // SHOW LOCAL NOTIFICATION
  // --------------------------------------------------

  final notificationId = DateTime.now().millisecondsSinceEpoch.remainder(
        2147483647,
      );

  await notifications.show(
    notificationId,
    'Workout complete 💪',
    'Great work. Keep the streak going.',
    details,
    payload: 'workout_complete',
  );

  print(
    'GYMBRO: Local workout notification sent successfully',
  );
}
