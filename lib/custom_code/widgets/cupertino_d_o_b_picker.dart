// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/widgets/index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:flutter/cupertino.dart';

class CupertinoDOBPicker extends StatefulWidget {
  const CupertinoDOBPicker({
    super.key,
    this.width,
    this.height = 356.0,
    this.initialDate,

    // Text customization
    this.textColor = Colors.white,
    this.fontSize = 25.0,

    // Selection background
    this.selectedBackgroundColor = const Color(0xFF2C2C2E),

    // Callback
    this.onDateChanged,
  });

  final double? width;
  final double? height;

  final DateTime? initialDate;

  final Color textColor;
  final double fontSize;

  final Color selectedBackgroundColor;

  final Future Function(DateTime selectedDate)? onDateChanged;

  @override
  State<CupertinoDOBPicker> createState() => _CupertinoDOBPickerState();
}

class _CupertinoDOBPickerState extends State<CupertinoDOBPicker> {
  late DateTime selectedDate;

  // --------------------------------------------------
  // TODAY
  // --------------------------------------------------

  DateTime get today {
    final now = DateTime.now();

    return DateTime(
      now.year,
      now.month,
      now.day,
    );
  }

  // --------------------------------------------------
  // 100 YEAR MAXIMUM AGE
  // --------------------------------------------------

  DateTime get minimumDate {
    final now = today;

    return DateTime(
      now.year - 100,
      now.month,
      now.day,
    );
  }

  // --------------------------------------------------
  // NO FUTURE DOB
  // --------------------------------------------------

  DateTime get maximumDate {
    return today;
  }

  // --------------------------------------------------
  // CLAMP DATE
  // --------------------------------------------------

  DateTime clampDate(DateTime date) {
    DateTime value = DateTime(
      date.year,
      date.month,
      date.day,
    );

    if (value.isBefore(minimumDate)) {
      value = minimumDate;
    }

    if (value.isAfter(maximumDate)) {
      value = maximumDate;
    }

    return value;
  }

  // --------------------------------------------------
  // INIT
  // --------------------------------------------------

  @override
  void initState() {
    super.initState();

    selectedDate = clampDate(
      widget.initialDate ?? today,
    );
  }

  // --------------------------------------------------
  // DATE CHANGED
  // --------------------------------------------------

  Future<void> _onDateChanged(
    DateTime newDate,
  ) async {
    final normalized = clampDate(newDate);

    setState(() {
      selectedDate = normalized;
    });

    if (widget.onDateChanged != null) {
      await widget.onDateChanged!(
        normalized,
      );
    }
  }

  // --------------------------------------------------
  // PICKER
  // --------------------------------------------------

  Widget _buildDatePicker() {
    return CupertinoDatePicker(
      mode: CupertinoDatePickerMode.date,

      initialDateTime: selectedDate,

      minimumDate: minimumDate,

      maximumDate: maximumDate,

      // Native iOS date picker behavior.
      use24hFormat: false,

      onDateTimeChanged: _onDateChanged,
    );
  }

  // --------------------------------------------------
  // BUILD
  // --------------------------------------------------

  @override
  Widget build(
    BuildContext context,
  ) {
    return SizedBox(
      width: widget.width ?? double.infinity,
      height: widget.height ?? 356.0,
      child: Column(
        children: [
          // ------------------------------------------
          // TITLE
          // ------------------------------------------

          SizedBox(
            height: 70.0,
            child: Center(
              child: Text(
                'Date of Birth',
                style: TextStyle(
                  color: widget.textColor,
                  fontSize: 32.0,
                  fontWeight: FontWeight.w600,
                  letterSpacing: -0.8,
                ),
              ),
            ),
          ),

          // ------------------------------------------
          // PICKER
          // ------------------------------------------

          Expanded(
            child: Stack(
              alignment: Alignment.center,
              children: [
                // ------------------------------------
                // SELECTED ROW BACKGROUND
                // ------------------------------------

                IgnorePointer(
                  child: Container(
                    height: 48.0,
                    margin: const EdgeInsets.symmetric(
                      horizontal: 0,
                    ),
                    decoration: BoxDecoration(
                      color: widget.selectedBackgroundColor,
                      borderRadius: BorderRadius.circular(
                        14.0,
                      ),
                    ),
                  ),
                ),

                // ------------------------------------
                // NATIVE CUPERTINO PICKER
                // ------------------------------------

                Theme(
                  data: Theme.of(
                    context,
                  ).copyWith(
                    cupertinoOverrideTheme: CupertinoThemeData(
                      textTheme: CupertinoTextThemeData(
                        dateTimePickerTextStyle: TextStyle(
                          color: widget.textColor,
                          fontSize: widget.fontSize,
                          fontWeight: FontWeight.w400,
                          letterSpacing: -0.4,
                        ),
                      ),
                    ),
                  ),
                  child: _buildDatePicker(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
