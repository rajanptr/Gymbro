import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import '/flutter_flow/custom_functions.dart';
import '/flutter_flow/lat_lng.dart';
import '/flutter_flow/place.dart';
import '/flutter_flow/uploaded_file.dart';
import '/backend/schema/structs/index.dart';
import '/backend/supabase/supabase.dart';
import '/auth/supabase_auth/auth_util.dart';

bool canFreezeToday(
  List<DateTime>? freezeDays,
  DateTime? selectedDate,
  String? calendarStatus,
) {
  if (selectedDate == null || calendarStatus == null) {
    return false;
  }

  final status = calendarStatus.toLowerCase().trim();

  // These days cannot be frozen.
  if (status == 'completed' ||
      status == 'workout' ||
      status == 'rest' ||
      status == 'future' ||
      status == 'outside' ||
      status == 'freeze') {
    return false;
  }

  final day = DateTime(
    selectedDate.year,
    selectedDate.month,
    selectedDate.day,
  );

  final days = freezeDays ?? [];

  final alreadyFrozen = days.any(
    (date) =>
        date.year == day.year && date.month == day.month && date.day == day.day,
  );

  return !alreadyFrozen;
}
