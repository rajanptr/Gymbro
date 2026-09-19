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

DateTime changeCalendarMonth(
  DateTime? currentMonth,
  int? months,
  DateTime? accountCreatedAt,
) {
  final DateTime current = currentMonth ?? DateTime.now();
  final int offset = months ?? 0;

  // Normalize current month to the first day.
  final DateTime currentMonthOnly = DateTime(
    current.year,
    current.month,
    1,
  );

  // Target month after navigation.
  final DateTime targetMonth = DateTime(
    currentMonthOnly.year,
    currentMonthOnly.month + offset,
    1,
  );

  // If account creation date is unavailable,
  // allow normal month navigation.
  if (accountCreatedAt == null) {
    return targetMonth;
  }

  // Earliest month the user is allowed to see.
  final DateTime accountMonth = DateTime(
    accountCreatedAt.year,
    accountCreatedAt.month,
    1,
  );

  // Never allow navigation before account creation month.
  if (targetMonth.isBefore(accountMonth)) {
    return accountMonth;
  }

  return targetMonth;
}
