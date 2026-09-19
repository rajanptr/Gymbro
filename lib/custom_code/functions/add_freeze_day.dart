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

List<DateTime> addFreezeDay(
  List<DateTime>? freezeDays,
  DateTime? newFreezeDay,
) {
  final updatedDays = List<DateTime>.from(freezeDays ?? []);

  if (newFreezeDay == null) {
    return updatedDays;
  }

  // Store only the calendar date, without time.
  final freezeDate = DateTime(
    newFreezeDay.year,
    newFreezeDay.month,
    newFreezeDay.day,
  );

  // Prevent duplicate freeze days.
  final alreadyExists = updatedDays.any(
    (date) =>
        date.year == freezeDate.year &&
        date.month == freezeDate.month &&
        date.day == freezeDate.day,
  );

  if (!alreadyExists) {
    updatedDays.add(freezeDate);
  }

  // Keep dates in chronological order.
  updatedDays.sort();

  return updatedDays;
}
