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

class ExerciseDropdown extends StatefulWidget {
  const ExerciseDropdown({
    super.key,
    this.width,
    this.height,
    required this.labels,
    required this.values,
    this.selectedItem,
    this.hintText,
    this.textColor,
    this.backgroundColor,
    this.borderColor,
    required this.borderRadius,
    this.iconColor,
    required this.textSize,
  });

  final double? width;
  final double? height;

  final List<String> labels;
  final List<String> values;
  final String? selectedItem;

  final String? hintText;

  final Color? textColor;
  final Color? backgroundColor;
  final Color? borderColor;
  final Color? iconColor;

  final double borderRadius;
  final double textSize;

  @override
  State<ExerciseDropdown> createState() => _ExerciseDropdownState();
}

class _ExerciseDropdownState extends State<ExerciseDropdown> {
  String? value;

  @override
  void initState() {
    super.initState();
    value = widget.selectedItem;
  }

  @override
  void didUpdateWidget(covariant ExerciseDropdown oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.selectedItem != oldWidget.selectedItem) {
      value = widget.selectedItem;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: DropdownButtonFormField<String>(
        value: value,
        isExpanded: true,
        decoration: InputDecoration(
          filled: true,
          fillColor: widget.backgroundColor ?? Colors.grey.shade900,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            borderSide: BorderSide(
              color: widget.borderColor ?? Colors.grey,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            borderSide: BorderSide(
              color: widget.borderColor ?? Colors.blue,
              width: 2,
            ),
          ),
        ),
        hint: Text(
          widget.hintText ?? "Select Exercise",
          style: TextStyle(
            color: widget.textColor ?? Colors.white54,
            fontSize: widget.textSize,
          ),
        ),
        icon: Icon(
          Icons.keyboard_arrow_down_rounded,
          color: widget.iconColor ?? Colors.white,
        ),
        dropdownColor: widget.backgroundColor ?? Colors.grey.shade900,
        style: TextStyle(
          color: widget.textColor ?? Colors.white,
          fontSize: widget.textSize,
        ),
        items: List.generate(
          widget.labels.length,
          (index) => DropdownMenuItem<String>(
            value: widget.values[index],
            child: Text(widget.labels[index]),
          ),
        ),
        onChanged: (v) {
          setState(() {
            value = v;
          });
        },
      ),
    );
  }
}

// Set your widget name, define your parameter, and then add the
// boilerplate code using the `</>` button on the right!
