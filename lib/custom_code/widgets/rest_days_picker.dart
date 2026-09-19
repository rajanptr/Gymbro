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

import 'package:flutter/services.dart';

class RestDaysPicker extends StatefulWidget {
  const RestDaysPicker({
    super.key,
    this.width,
    this.height,

    // Data
    this.initialRestDays,
    this.onRestDaysChanged,

    // Typography
    this.titleFontSize = 32.0,
    this.descriptionFontSize = 14.0,
    this.dayFontSize = 12.0,
    this.statusFontSize = 14.0,

    // Text Colors
    this.titleTextColor = Colors.white,
    this.descriptionTextColor = const Color(0xFF8E8E93),
    this.dayTextColor = const Color(0xFF8E8E93),
    this.selectedTextColor = Colors.white,
    this.statusTextColor = const Color(0xFF8E8E93),

    // Circle Colors
    this.selectedColor = const Color(0xFF2C2C2E),
    this.selectedDotColor = Colors.white,
    this.unselectedBackgroundColor = const Color(0xFF1C1C1E),
    this.borderColor = const Color(0xFF2C2C2E),
    this.selectedBorderColor = const Color(0xFF48484A),
  });

  final double? width;
  final double? height;

  // ------------------------------------------------------------
  // DATA
  // ------------------------------------------------------------

  /// 1 = Monday
  /// 2 = Tuesday
  /// 3 = Wednesday
  /// 4 = Thursday
  /// 5 = Friday
  /// 6 = Saturday
  /// 7 = Sunday
  final List<int>? initialRestDays;

  /// Returns currently selected weekdays.
  final Future Function(List<int> selectedDays)? onRestDaysChanged;

  // ------------------------------------------------------------
  // TYPOGRAPHY
  // ------------------------------------------------------------

  /// REST DAYS title size.
  final double titleFontSize;

  /// Description text size.
  final double descriptionFontSize;

  /// MON / TUE / WED / THU / FRI / SAT / SUN size.
  final double dayFontSize;

  /// Selection status text size.
  final double statusFontSize;

  // ------------------------------------------------------------
  // TEXT COLORS
  // ------------------------------------------------------------

  /// Color of "REST DAYS".
  final Color titleTextColor;

  /// Color of the description.
  final Color descriptionTextColor;

  /// Color of unselected MON-SUN labels.
  final Color dayTextColor;

  /// Color of selected MON-SUN labels.
  final Color selectedTextColor;

  /// Color of the bottom selection status.
  final Color statusTextColor;

  // ------------------------------------------------------------
  // CIRCLE COLORS
  // ------------------------------------------------------------

  /// Selected day circle.
  final Color selectedColor;

  /// White/colored dot inside selected day.
  final Color selectedDotColor;

  /// Background of unselected day circle.
  final Color unselectedBackgroundColor;

  /// Border of unselected day circle.
  final Color borderColor;

  /// Border of selected day circle.
  final Color selectedBorderColor;

  @override
  State<RestDaysPicker> createState() => _RestDaysPickerState();
}

class _RestDaysPickerState extends State<RestDaysPicker> {
  late List<int> selectedDays;

  final List<String> dayNames = const [
    'MON',
    'TUE',
    'WED',
    'THU',
    'FRI',
    'SAT',
    'SUN',
  ];

  @override
  void initState() {
    super.initState();

    selectedDays = List<int>.from(
      widget.initialRestDays ?? <int>[],
    );

    selectedDays.sort();
  }

  @override
  void didUpdateWidget(covariant RestDaysPicker oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.initialRestDays != oldWidget.initialRestDays) {
      selectedDays = List<int>.from(
        widget.initialRestDays ?? <int>[],
      );

      selectedDays.sort();
    }
  }

  // ------------------------------------------------------------
  // TOGGLE DAY
  // ------------------------------------------------------------

  Future<void> toggleDay(int day) async {
    HapticFeedback.selectionClick();

    setState(() {
      if (selectedDays.contains(day)) {
        selectedDays.remove(day);
      } else {
        selectedDays.add(day);
      }

      selectedDays.sort();
    });

    if (widget.onRestDaysChanged != null) {
      await widget.onRestDaysChanged!(
        List<int>.from(selectedDays),
      );
    }
  }

  // ------------------------------------------------------------
  // CHECK SELECTED
  // ------------------------------------------------------------

  bool isSelected(int day) {
    return selectedDays.contains(day);
  }

  // ------------------------------------------------------------
  // BUILD
  // ------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width ?? double.infinity,
      height: widget.height,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ======================================================
          // TITLE
          // ======================================================

          Text(
            'REST DAYS',
            style: TextStyle(
              color: widget.titleTextColor,
              fontSize: widget.titleFontSize,
              fontWeight: FontWeight.w600,
              letterSpacing: -0.8,
              height: 1.0,
            ),
          ),

          const SizedBox(height: 10),

          // ======================================================
          // DESCRIPTION
          // ======================================================

          Text(
            'Choose the days you normally take off from training.',
            style: TextStyle(
              color: widget.descriptionTextColor,
              fontSize: widget.descriptionFontSize,
              fontWeight: FontWeight.w400,
              letterSpacing: -0.2,
              height: 1.35,
            ),
          ),

          const SizedBox(height: 28),

          // ======================================================
          // DAYS
          // ======================================================

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
              7,
              (index) {
                final int day = index + 1;
                final bool selected = isSelected(day);

                return GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () => toggleDay(day),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // ------------------------------------------------
                      // DAY LABEL
                      // ------------------------------------------------

                      Text(
                        dayNames[index],
                        style: TextStyle(
                          color: selected
                              ? widget.selectedTextColor
                              : widget.dayTextColor,
                          fontSize: widget.dayFontSize,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.2,
                        ),
                      ),

                      const SizedBox(height: 10),

                      // ------------------------------------------------
                      // DAY CIRCLE
                      // ------------------------------------------------

                      AnimatedContainer(
                        duration: const Duration(
                          milliseconds: 160,
                        ),
                        curve: Curves.easeOut,
                        width: 42,
                        height: 42,
                        decoration: BoxDecoration(
                          color: selected
                              ? widget.selectedColor
                              : widget.unselectedBackgroundColor,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: selected
                                ? widget.selectedBorderColor
                                : widget.borderColor,
                            width: 1,
                          ),
                        ),
                        child: Center(
                          child: AnimatedContainer(
                            duration: const Duration(
                              milliseconds: 160,
                            ),
                            curve: Curves.easeOut,
                            width: selected ? 10 : 0,
                            height: selected ? 10 : 0,
                            decoration: BoxDecoration(
                              color: widget.selectedDotColor,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 28),

          // ======================================================
          // SELECTION STATUS
          // ======================================================

          Text(
            selectedDays.isEmpty
                ? 'No rest days selected'
                : selectedDays.length == 1
                    ? '1 rest day selected'
                    : '${selectedDays.length} rest days selected',
            style: TextStyle(
              color: widget.statusTextColor,
              fontSize: widget.statusFontSize,
              fontWeight: FontWeight.w400,
              letterSpacing: -0.1,
            ),
          ),
        ],
      ),
    );
  }
}
