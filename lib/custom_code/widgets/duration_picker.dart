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

class DurationPicker extends StatefulWidget {
  const DurationPicker({
    super.key,
    this.width,
    this.height,
    this.initialMinutes = 1,
    this.initialSeconds = 0,
    this.onDurationChanged,
  });

  final double? width;
  final double? height;

  final int initialMinutes;
  final int initialSeconds;

  final Future Function(int minutes, int seconds)? onDurationChanged;

  @override
  State<DurationPicker> createState() => _DurationPickerState();
}

class _DurationPickerState extends State<DurationPicker> {
  late int selectedMinutes;
  late int selectedSeconds;

  late FixedExtentScrollController minutesController;
  late FixedExtentScrollController secondsController;

  @override
  void initState() {
    super.initState();

    // Clamp initial duration between 00:01 and 15:00.
    int totalSeconds = (widget.initialMinutes * 60) + widget.initialSeconds;

    totalSeconds = totalSeconds.clamp(1, 15 * 60);

    selectedMinutes = totalSeconds ~/ 60;
    selectedSeconds = totalSeconds % 60;

    minutesController = FixedExtentScrollController(
      initialItem: selectedMinutes,
    );

    secondsController = FixedExtentScrollController(
      initialItem: selectedSeconds,
    );
  }

  @override
  void dispose() {
    minutesController.dispose();
    secondsController.dispose();
    super.dispose();
  }

  Future<void> _sendValue() async {
    if (widget.onDurationChanged != null) {
      await widget.onDurationChanged!(
        selectedMinutes,
        selectedSeconds,
      );
    }
  }

  void _updateMinutes(int value) {
    int newMinutes = value;
    int newSeconds = selectedSeconds;

    // Maximum allowed duration is 15:00.
    if (newMinutes == 15) {
      newSeconds = 0;

      if (secondsController.hasClients) {
        secondsController.jumpToItem(0);
      }
    }

    // Minimum allowed duration is 00:01.
    if (newMinutes == 0 && newSeconds == 0) {
      newSeconds = 1;

      if (secondsController.hasClients) {
        secondsController.jumpToItem(1);
      }
    }

    setState(() {
      selectedMinutes = newMinutes;
      selectedSeconds = newSeconds;
    });

    _sendValue();
  }

  void _updateSeconds(int value) {
    int newMinutes = selectedMinutes;
    int newSeconds = value;

    // 15:xx is not allowed.
    if (newMinutes == 15) {
      newSeconds = 0;

      if (secondsController.hasClients) {
        secondsController.jumpToItem(0);
      }
    }

    // 00:00 is not allowed.
    if (newMinutes == 0 && newSeconds == 0) {
      newSeconds = 1;

      if (secondsController.hasClients) {
        secondsController.jumpToItem(1);
      }
    }

    setState(() {
      selectedMinutes = newMinutes;
      selectedSeconds = newSeconds;
    });

    _sendValue();
  }

  Widget _buildPicker({
    required FixedExtentScrollController controller,
    required int itemCount,
    required int selectedValue,
    required ValueChanged<int> onChanged,
  }) {
    return SizedBox(
      width: 90,
      height: 150,
      child: CupertinoPicker.builder(
        scrollController: controller,
        itemExtent: 44,
        diameterRatio: 1.2,
        squeeze: 1.0,
        magnification: 1.08,
        useMagnifier: true,
        onSelectedItemChanged: onChanged,
        childCount: itemCount,
        itemBuilder: (context, index) {
          final isSelected = index == selectedValue;

          return Center(
            child: Text(
              index.toString().padLeft(2, '0'),
              style: TextStyle(
                fontSize: isSelected ? 24 : 20,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                color: isSelected ? Colors.white : Colors.white54,
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height ?? 210,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'REST DURATION',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 150,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // MINUTES
                _buildPicker(
                  controller: minutesController,
                  itemCount: 16, // 00 → 15
                  selectedValue: selectedMinutes,
                  onChanged: _updateMinutes,
                ),

                const Text(
                  ':',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                // SECONDS
                _buildPicker(
                  controller: secondsController,
                  itemCount: 60, // 00 → 59
                  selectedValue: selectedSeconds,
                  onChanged: _updateSeconds,
                ),
              ],
            ),
          ),
          const SizedBox(height: 4),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 90,
                child: Center(
                  child: Text(
                    'MIN',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 20),
              SizedBox(
                width: 90,
                child: Center(
                  child: Text(
                    'SEC',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
