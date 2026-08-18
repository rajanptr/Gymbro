import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import '/flutter_flow/custom_functions.dart';
import 'package:ff_commons/flutter_flow/lat_lng.dart';
import 'package:ff_commons/flutter_flow/place.dart';
import 'package:ff_commons/flutter_flow/uploaded_file.dart';
import '/backend/schema/structs/index.dart';
import '/backend/supabase/supabase.dart';
import '/auth/supabase_auth/auth_util.dart';

List<CalendarDayStruct> generateCurrentMonth() {
  final now = DateTime.now();

  final firstDay = DateTime(now.year, now.month, 1);
  final lastDay = DateTime(now.year, now.month + 1, 0);

  final List<CalendarDayStruct> calendar = [];

  for (int day = 1; day <= lastDay.day; day++) {
    final currentDate = DateTime(now.year, now.month, day);

    calendar.add(
      CalendarDayStruct(
        dayNumber: day,
        date: currentDate,
        isCurrentMonth: true,
        isToday: currentDate.year == now.year &&
            currentDate.month == now.month &&
            currentDate.day == now.day,
        hasWorkout: false,
        isRestDay: false,
      ),
    );
  }

  return calendar;
}
