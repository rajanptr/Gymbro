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
import 'package:flutter/services.dart';

class CupertinoHeightPicker extends StatefulWidget {
  const CupertinoHeightPicker({
    super.key,
    this.width,
    this.height = 356.0,
    this.initialHeight = 170.0,
    this.initialUnit = 'cm',
    this.textColor = Colors.white,
    this.fontSize = 25.0,
    this.selectedBackgroundColor = const Color(0xFF2C2C2E),
    this.onHeightChanged,
  });

  final double? width;
  final double? height;

  /// Initial height.
  /// The value is always stored/returned in centimeters.
  final double initialHeight;

  /// 'cm' or 'ft'
  final String initialUnit;

  /// Same typography customization system as DOB picker.
  final Color textColor;
  final double fontSize;

  /// Selected row background.
  final Color selectedBackgroundColor;

  /// Sends selected height back to FlutterFlow.
  /// Value returned is always in centimeters,
  /// rounded to 2 decimal places.
  final Future Function(double heightCm)? onHeightChanged;

  @override
  State<CupertinoHeightPicker> createState() => _CupertinoHeightPickerState();
}

class _CupertinoHeightPickerState extends State<CupertinoHeightPicker> {
  // ============================================================
  // CONSTANTS
  // ============================================================

  static const int minCm = 100;
  static const int maxCm = 250;

  // Same selected-row height as DOB picker.
  static const double itemExtent = 48.0;

  // Compact CM picker.
  static const double cmPickerWidth = 300.0;

  // Compact FT / IN picker.
  static const double imperialPickerWidth = 292.0;

  // ============================================================
  // STATE
  // ============================================================

  late double heightCm;

  late int centimeters;

  late int feet;

  late int inches;

  late String unit;

  // ============================================================
  // CONTROLLERS
  // ============================================================

  late FixedExtentScrollController cmController;

  late FixedExtentScrollController feetController;

  late FixedExtentScrollController inchController;

  // ============================================================
  // INIT
  // ============================================================

  @override
  void initState() {
    super.initState();

    // Clamp initial CM value.
    heightCm = widget.initialHeight.clamp(
      minCm.toDouble(),
      maxCm.toDouble(),
    );

    // Keep initial CM value at 2 decimal places.
    heightCm = _roundToTwoDecimals(heightCm);

    centimeters = heightCm.round();

    // Unit.
    unit = widget.initialUnit == 'ft' ? 'ft' : 'cm';

    // Convert CM → FT / IN.
    _updateImperialFromCm();

    // CM wheel controller.
    cmController = FixedExtentScrollController(
      initialItem: centimeters - minCm,
    );

    // Feet wheel controller.
    feetController = FixedExtentScrollController(
      initialItem: feet - 3,
    );

    // Inches wheel controller.
    inchController = FixedExtentScrollController(
      initialItem: inches,
    );
  }

  // ============================================================
  // DISPOSE
  // ============================================================

  @override
  void dispose() {
    cmController.dispose();
    feetController.dispose();
    inchController.dispose();

    super.dispose();
  }

  // ============================================================
  // ROUNDING
  // ============================================================

  double _roundToTwoDecimals(double value) {
    return double.parse(value.toStringAsFixed(2));
  }

  // ============================================================
  // CM → FT / IN
  // ============================================================

  void _updateImperialFromCm() {
    final double totalInches = heightCm / 2.54;

    feet = totalInches.floor();

    inches = (totalInches - (feet * 12)).round();

    if (inches == 12) {
      feet += 1;
      inches = 0;
    }

    feet = feet.clamp(3, 8);

    inches = inches.clamp(0, 11);
  }

  // ============================================================
  // FT / IN → CM
  // ============================================================

  void _updateCmFromImperial() {
    final int totalInches = (feet * 12) + inches;

    // Convert FT / IN → CM.
    heightCm = totalInches * 2.54;

    // Keep converted CM to exactly 2 decimal precision.
    heightCm = _roundToTwoDecimals(heightCm);

    // Clamp to allowed range.
    heightCm = heightCm.clamp(
      minCm.toDouble(),
      maxCm.toDouble(),
    );

    // CM wheel itself displays whole numbers only.
    centimeters = heightCm.round();
  }

  // ============================================================
  // UNIT CHANGE
  // ============================================================

  void _changeUnit(String newUnit) {
    if (unit == newUnit) {
      return;
    }

    setState(() {
      if (newUnit == 'ft') {
        // Current CM → FT / IN.
        _updateImperialFromCm();
      } else {
        // Current value remains the same CM value.
        centimeters = heightCm.round();
      }

      unit = newUnit;
    });

    // Move wheels to correct positions.
    _syncControllers();

    // Haptic when switching unit.
    HapticFeedback.selectionClick();
  }

  // ============================================================
  // SYNC CONTROLLERS
  // ============================================================

  void _syncControllers() {
    if (unit == 'cm') {
      if (cmController.hasClients) {
        cmController.animateToItem(
          centimeters - minCm,
          duration: const Duration(
            milliseconds: 250,
          ),
          curve: Curves.easeOut,
        );
      }
    } else {
      if (feetController.hasClients) {
        feetController.animateToItem(
          feet - 3,
          duration: const Duration(
            milliseconds: 250,
          ),
          curve: Curves.easeOut,
        );
      }

      if (inchController.hasClients) {
        inchController.animateToItem(
          inches,
          duration: const Duration(
            milliseconds: 250,
          ),
          curve: Curves.easeOut,
        );
      }
    }
  }

  // ============================================================
  // FLUTTERFLOW CALLBACK
  // ============================================================

  Future<void> _sendHeight() async {
    if (widget.onHeightChanged != null) {
      await widget.onHeightChanged!(
        _roundToTwoDecimals(heightCm),
      );
    }
  }

  // ============================================================
  // HAPTIC
  // ============================================================

  void _haptic() {
    HapticFeedback.selectionClick();
  }

  // ============================================================
  // SELECTED BACKGROUND
  //
  // IMPORTANT:
  // This follows the DOB picker design.
  //
  // It is NOT full screen width.
  // It is a contained 48px selected row.
  // ============================================================

  Widget _buildSelectedBackground({
    required double width,
  }) {
    return IgnorePointer(
      child: Center(
        child: Container(
          width: width,
          height: itemExtent,
          decoration: BoxDecoration(
            color: widget.selectedBackgroundColor,
            borderRadius: BorderRadius.circular(
              14.0,
            ),
          ),
        ),
      ),
    );
  }

  // ============================================================
  // CUPERTINO THEME
  //
  // EXACT SAME TYPOGRAPHY SYSTEM AS DOB.
  // ============================================================

  CupertinoThemeData _pickerTheme() {
    return CupertinoThemeData(
      textTheme: CupertinoTextThemeData(
        pickerTextStyle: TextStyle(
          color: widget.textColor,
          fontSize: widget.fontSize,
          fontWeight: FontWeight.w400,
          letterSpacing: -0.4,
        ),
      ),
    );
  }

  // ============================================================
  // CM PICKER
  // ============================================================

  Widget _buildCmPicker() {
    return SizedBox(
      width: cmPickerWidth,
      child: CupertinoPicker.builder(
        scrollController: cmController,
        itemExtent: itemExtent,

        // Native Cupertino geometry.
        diameterRatio: 1.07,
        squeeze: 1.0,
        useMagnifier: true,
        magnification: 1.08,

        // Disable native full-width overlay.
        selectionOverlay: const SizedBox.shrink(),

        childCount: maxCm - minCm + 1,

        onSelectedItemChanged: (index) {
          centimeters = minCm + index;

          // CM wheel uses whole numbers.
          heightCm = centimeters.toDouble();

          // Haptic on wheel movement.
          _haptic();

          // Send value to FlutterFlow.
          _sendHeight();

          if (mounted) {
            setState(() {});
          }
        },

        itemBuilder: (context, index) {
          final int value = minCm + index;

          return Center(
            child: Text(
              '$value cm',
            ),
          );
        },
      ),
    );
  }

  // ============================================================
  // FEET PICKER
  // ============================================================

  Widget _buildFeetPicker() {
    return SizedBox(
      width: 145,
      child: CupertinoPicker.builder(
        scrollController: feetController,
        itemExtent: itemExtent,

        diameterRatio: 1.07,
        squeeze: 1.0,
        useMagnifier: true,
        magnification: 1.08,

        // Background is controlled by parent.
        selectionOverlay: const SizedBox.shrink(),

        childCount: 6,

        onSelectedItemChanged: (index) {
          feet = 3 + index;

          _updateCmFromImperial();

          // Haptic.
          _haptic();

          // Callback.
          _sendHeight();

          if (mounted) {
            setState(() {});
          }
        },

        itemBuilder: (context, index) {
          final int value = 3 + index;

          return Center(
            child: Text(
              '$value ft',
            ),
          );
        },
      ),
    );
  }

  // ============================================================
  // INCH PICKER
  // ============================================================

  Widget _buildInchPicker() {
    return SizedBox(
      width: 145,
      child: CupertinoPicker.builder(
        scrollController: inchController,
        itemExtent: itemExtent,

        diameterRatio: 1.07,
        squeeze: 1.0,
        useMagnifier: true,
        magnification: 1.08,

        // Background is controlled by parent.
        selectionOverlay: const SizedBox.shrink(),

        childCount: 12,

        onSelectedItemChanged: (index) {
          inches = index;

          _updateCmFromImperial();

          // Haptic.
          _haptic();

          // Callback.
          _sendHeight();

          if (mounted) {
            setState(() {});
          }
        },

        itemBuilder: (context, index) {
          return Center(
            child: Text(
              '$index in',
            ),
          );
        },
      ),
    );
  }

  // ============================================================
  // SMALL-SIZE TOGGLE
  // ============================================================

  Widget _buildUnitToggle() {
    return Container(
      width: 180,
      height: 44,
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: const Color(0xFF2C2C2E),
        borderRadius: BorderRadius.circular(
          24,
        ),
      ),
      child: Row(
        children: [
          // ======================================================
          // CM
          // ======================================================

          Expanded(
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                _changeUnit('cm');
              },
              child: AnimatedContainer(
                duration: const Duration(
                  milliseconds: 180,
                ),
                curve: Curves.easeOut,
                height: 38,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: unit == 'cm' ? Colors.white : Colors.transparent,
                  borderRadius: BorderRadius.circular(
                    20,
                  ),
                ),
                child: Text(
                  'CM',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: unit == 'cm' ? Colors.black : Colors.white,
                  ),
                ),
              ),
            ),
          ),

          // ======================================================
          // FT / IN
          // ======================================================

          Expanded(
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                _changeUnit('ft');
              },
              child: AnimatedContainer(
                duration: const Duration(
                  milliseconds: 180,
                ),
                curve: Curves.easeOut,
                height: 38,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: unit == 'ft' ? Colors.white : Colors.transparent,
                  borderRadius: BorderRadius.circular(
                    20,
                  ),
                ),
                child: Text(
                  'FT / IN',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: unit == 'ft' ? Colors.black : Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // BUILD
  // ============================================================

  @override
  Widget build(
    BuildContext context,
  ) {
    return SizedBox(
      width: widget.width ?? double.infinity,
      height: widget.height ?? 356.0,
      child: Column(
        children: [
          // ======================================================
          // TITLE
          //
          // SAME AS DOB
          // ======================================================

          SizedBox(
            height: 70.0,
            child: Center(
              child: Text(
                'Height',
                style: TextStyle(
                  color: widget.textColor,
                  fontSize: 32.0,
                  fontWeight: FontWeight.w600,
                  letterSpacing: -0.8,
                ),
              ),
            ),
          ),

          // ======================================================
          // SMALL TOGGLE
          // ======================================================

          _buildUnitToggle(),

          // ======================================================
          // GAP
          // ======================================================

          const SizedBox(
            height: 12,
          ),

          // ======================================================
          // PICKER
          // ======================================================

          Expanded(
            child: Stack(
              alignment: Alignment.center,
              children: [
                // ==================================================
                // SELECTED BACKGROUND
                //
                // CONTAINED — NOT FULL WIDTH.
                // ==================================================

                if (unit == 'cm')
                  _buildSelectedBackground(
                    width: 300,
                  )
                else
                  _buildSelectedBackground(
                    width: imperialPickerWidth,
                  ),

                // ==================================================
                // WHEELS
                // ==================================================

                Theme(
                  data: Theme.of(
                    context,
                  ).copyWith(
                    cupertinoOverrideTheme: _pickerTheme(),
                  ),
                  child: unit == 'cm'
                      ? _buildCmPicker()
                      : SizedBox(
                          width: imperialPickerWidth,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // --------------------------------
                              // FEET
                              // --------------------------------

                              _buildFeetPicker(),

                              // --------------------------------
                              // VERY SMALL GAP
                              // --------------------------------

                              const SizedBox(
                                width: 2,
                              ),

                              // --------------------------------
                              // INCHES
                              // --------------------------------

                              _buildInchPicker(),
                            ],
                          ),
                        ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
