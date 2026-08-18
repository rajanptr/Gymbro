// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/backend/supabase/supabase.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
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
    this.initialMinutes = 0,
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

    selectedMinutes = widget.initialMinutes.clamp(0, 180);
    selectedSeconds = widget.initialSeconds.clamp(0, 59);

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
            'Duration',
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
                _buildPicker(
                  controller: minutesController,
                  itemCount: 181,
                  selectedValue: selectedMinutes,
                  onChanged: (value) {
                    setState(() {
                      selectedMinutes = value;
                    });

                    _sendValue();
                  },
                ),
                const Text(
                  ':',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                _buildPicker(
                  controller: secondsController,
                  itemCount: 60,
                  selectedValue: selectedSeconds,
                  onChanged: (value) {
                    setState(() {
                      selectedSeconds = value;
                    });

                    _sendValue();
                  },
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
// Set your widget name, define your parameter, and then add the
// boilerplate code using the `</>` button on the right!
