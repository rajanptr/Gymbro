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

String getCalendarStatusTitle(String? status) {
  switch (status) {
    case 'workout':
      return 'Workout completed';
    case 'rest':
      return 'Rest day';
    case 'freeze':
      return 'Freeze day';
    case 'empty':
      return 'Missed day';
    case 'future':
      return 'Upcoming';
    case 'outside':
      return 'Outside your journey';
    default:
      return '';
  }
}
