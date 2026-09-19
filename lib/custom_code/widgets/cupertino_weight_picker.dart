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

class CupertinoWeightPicker extends StatefulWidget {
  const CupertinoWeightPicker({
    super.key,
    this.width,
    this.height = 356.0,
    this.initialWeight = 70.0,
    this.initialUnit = 'kg',
    this.textColor = Colors.white,
    this.fontSize = 25.0,
    this.selectedBackgroundColor = const Color(0xFF2C2C2E),
    this.onWeightChanged,
  });

  final double? width;
  final double? height;

  /// Weight stored internally and returned in KG.
  final double initialWeight;

  /// 'kg' or 'lb'
  final String initialUnit;

  final Color textColor;
  final double fontSize;

  final Color selectedBackgroundColor;

  /// Returns converted weight in KG.
  ///
  /// Example:
  /// 176 lb → 79.83 kg
  final Future Function(double weightKg)? onWeightChanged;

  @override
  State<CupertinoWeightPicker> createState() => _CupertinoWeightPickerState();
}

class _CupertinoWeightPickerState extends State<CupertinoWeightPicker> {
  // ============================================================
  // CONSTANTS
  // ============================================================

  // KG range.
  static const int minKg = 30;
  static const int maxKg = 200;

  // LB range.
  static const int minLb = 66;
  static const int maxLb = 441;

  // Same as DOB / Height.
  static const double itemExtent = 48.0;

  static const double pickerWidth = 300.0;

  // ============================================================
  // STATE
  // ============================================================

  late double weightKg;

  late int kilograms;

  late int pounds;

  late String unit;

  // ============================================================
  // CONTROLLERS
  // ============================================================

  late FixedExtentScrollController kgController;

  late FixedExtentScrollController lbController;

  // ============================================================
  // INIT
  // ============================================================

  @override
  void initState() {
    super.initState();

    // ----------------------------------------------------------
    // INITIAL KG
    // ----------------------------------------------------------

    weightKg = widget.initialWeight.clamp(
      minKg.toDouble(),
      maxKg.toDouble(),
    );

    // KG picker displays whole numbers.
    kilograms = weightKg.round();

    // ----------------------------------------------------------
    // INITIAL UNIT
    // ----------------------------------------------------------

    unit = widget.initialUnit == 'lb' ? 'lb' : 'kg';

    // ----------------------------------------------------------
    // KG → LB
    // ----------------------------------------------------------

    _updatePoundsFromKg();

    // ----------------------------------------------------------
    // CONTROLLERS
    // ----------------------------------------------------------

    kgController = FixedExtentScrollController(
      initialItem: kilograms - minKg,
    );

    lbController = FixedExtentScrollController(
      initialItem: pounds - minLb,
    );
  }

  // ============================================================
  // DISPOSE
  // ============================================================

  @override
  void dispose() {
    kgController.dispose();
    lbController.dispose();

    super.dispose();
  }

  // ============================================================
  // ROUND TO 2 DECIMAL PLACES
  // ============================================================

  double _round2(double value) {
    return double.parse(
      value.toStringAsFixed(2),
    );
  }

  // ============================================================
  // KG → LB
  //
  // DISPLAY = WHOLE NUMBER
  // ============================================================

  void _updatePoundsFromKg() {
    pounds = (weightKg * 2.2046226218).round();

    pounds = pounds.clamp(
      minLb,
      maxLb,
    );
  }

  // ============================================================
  // LB → KG
  //
  // INTERNAL RESULT = 2 DECIMALS
  // ============================================================

  void _updateKgFromPounds() {
    weightKg = _round2(
      pounds / 2.2046226218,
    );

    weightKg = weightKg.clamp(
      minKg.toDouble(),
      maxKg.toDouble(),
    );

    weightKg = _round2(
      weightKg,
    );

    // The KG wheel remains whole-number.
    kilograms = weightKg.round();
  }

  // ============================================================
  // UNIT CHANGE
  // ============================================================

  void _changeUnit(
    String newUnit,
  ) {
    if (unit == newUnit) {
      return;
    }

    setState(() {
      if (newUnit == 'lb') {
        // Current KG → whole LB.
        _updatePoundsFromKg();
      } else {
        // Current LB → KG with 2 decimals.
        _updateKgFromPounds();

        // KG picker only displays integer.
        kilograms = weightKg.round();
      }

      unit = newUnit;
    });

    _syncControllers();

    HapticFeedback.selectionClick();
  }

  // ============================================================
  // SYNC WHEELS
  // ============================================================

  void _syncControllers() {
    if (unit == 'kg') {
      if (kgController.hasClients) {
        kgController.animateToItem(
          kilograms - minKg,
          duration: const Duration(
            milliseconds: 250,
          ),
          curve: Curves.easeOut,
        );
      }
    } else {
      if (lbController.hasClients) {
        lbController.animateToItem(
          pounds - minLb,
          duration: const Duration(
            milliseconds: 250,
          ),
          curve: Curves.easeOut,
        );
      }
    }
  }

  // ============================================================
  // CALLBACK
  // ============================================================

  Future<void> _sendWeight() async {
    if (widget.onWeightChanged != null) {
      final double value = _round2(weightKg);

      await widget.onWeightChanged!(
        value,
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
  // SAME DESIGN AS DOB / HEIGHT.
  // ============================================================

  Widget _buildSelectedBackground() {
    return IgnorePointer(
      child: Center(
        child: Container(
          width: pickerWidth,
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
  // SAME DESIGN SYSTEM.
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
  // KG PICKER
  //
  // WHOLE NUMBERS ONLY
  //
  // 79 kg
  // 80 kg
  // 81 kg
  // 82 kg
  // ============================================================

  Widget _buildKgPicker() {
    return SizedBox(
      width: pickerWidth,
      child: CupertinoPicker.builder(
        scrollController: kgController,

        itemExtent: itemExtent,

        diameterRatio: 1.07,

        squeeze: 1.0,

        useMagnifier: true,

        magnification: 1.08,

        // Background is controlled
        // by the parent Stack.
        selectionOverlay: const SizedBox.shrink(),

        childCount: maxKg - minKg + 1,

        onSelectedItemChanged: (index) {
          kilograms = minKg + index;

          // KG is whole number.
          weightKg = kilograms.toDouble();

          // Keep LB synchronized.
          _updatePoundsFromKg();

          // Haptic.
          _haptic();

          // Callback.
          _sendWeight();

          if (mounted) {
            setState(() {});
          }
        },

        itemBuilder: (context, index) {
          final int value = minKg + index;

          return Center(
            child: Text(
              '$value kg',
            ),
          );
        },
      ),
    );
  }

  // ============================================================
  // LB PICKER
  //
  // WHOLE NUMBERS ONLY
  //
  // 174 lb
  // 175 lb
  // 176 lb
  // 177 lb
  // ============================================================

  Widget _buildLbPicker() {
    return SizedBox(
      width: pickerWidth,
      child: CupertinoPicker.builder(
        scrollController: lbController,

        itemExtent: itemExtent,

        diameterRatio: 1.07,

        squeeze: 1.0,

        useMagnifier: true,

        magnification: 1.08,

        // Background controlled by parent.
        selectionOverlay: const SizedBox.shrink(),

        childCount: maxLb - minLb + 1,

        onSelectedItemChanged: (index) {
          pounds = minLb + index;

          // IMPORTANT:
          // LB is displayed as integer,
          // but conversion to KG is 2 decimals.
          _updateKgFromPounds();

          // Haptic.
          _haptic();

          // Callback returns KG
          // with 2 decimals.
          _sendWeight();

          if (mounted) {
            setState(() {});
          }
        },

        itemBuilder: (context, index) {
          final int value = minLb + index;

          return Center(
            child: Text(
              '$value lb',
            ),
          );
        },
      ),
    );
  }

  // ============================================================
  // SMALL S TOGGLE
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
          // KG
          // ======================================================

          Expanded(
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                _changeUnit(
                  'kg',
                );
              },
              child: AnimatedContainer(
                duration: const Duration(
                  milliseconds: 180,
                ),
                curve: Curves.easeOut,
                height: 38,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: unit == 'kg' ? Colors.white : Colors.transparent,
                  borderRadius: BorderRadius.circular(
                    20,
                  ),
                ),
                child: Text(
                  'KG',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: unit == 'kg' ? Colors.black : Colors.white,
                  ),
                ),
              ),
            ),
          ),

          // ======================================================
          // LB
          // ======================================================

          Expanded(
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                _changeUnit(
                  'lb',
                );
              },
              child: AnimatedContainer(
                duration: const Duration(
                  milliseconds: 180,
                ),
                curve: Curves.easeOut,
                height: 38,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: unit == 'lb' ? Colors.white : Colors.transparent,
                  borderRadius: BorderRadius.circular(
                    20,
                  ),
                ),
                child: Text(
                  'LB',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: unit == 'lb' ? Colors.black : Colors.white,
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
          // ======================================================

          SizedBox(
            height: 70.0,
            child: Center(
              child: Text(
                'Weight',
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
          // TOGGLE
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
                // ------------------------------------------------
                // SELECTED BACKGROUND
                // ------------------------------------------------

                _buildSelectedBackground(),

                // ------------------------------------------------
                // CUPERTINO WHEEL
                // ------------------------------------------------

                Theme(
                  data: Theme.of(
                    context,
                  ).copyWith(
                    cupertinoOverrideTheme: _pickerTheme(),
                  ),
                  child: unit == 'kg' ? _buildKgPicker() : _buildLbPicker(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
