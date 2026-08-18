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

import 'package:fl_chart/fl_chart.dart';

class ProgressChart extends StatelessWidget {
  const ProgressChart({
    super.key,
    required this.weights,
    required this.labels,
    this.width,
    this.height,
  });

  final List<double> weights;
  final List<String> labels;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    if (weights.isEmpty) {
      return const Center(
        child: Text("No workout data"),
      );
    }

    return SizedBox(
      width: width,
      height: height,
      child: LineChart(
        LineChartData(
          minX: 0,
          maxX: (weights.length - 1).toDouble(),
          minY: weights.reduce((a, b) => a < b ? a : b) - 5,
          maxY: weights.reduce((a, b) => a > b ? a : b) + 5,
          gridData: const FlGridData(show: true),
          borderData: FlBorderData(show: false),
          titlesData: FlTitlesData(
            topTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            rightTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                interval: 1,
                getTitlesWidget: (value, meta) {
                  int i = value.toInt();

                  if (i >= labels.length) {
                    return const SizedBox();
                  }

                  return Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      labels[i],
                      style: const TextStyle(fontSize: 10),
                    ),
                  );
                },
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 40,
              ),
            ),
          ),
          lineBarsData: [
            LineChartBarData(
              isCurved: true,
              spots: List.generate(
                weights.length,
                (i) => FlSpot(
                  i.toDouble(),
                  weights[i],
                ),
              ),
              barWidth: 3,
              isStrokeCapRound: true,
              dotData: const FlDotData(show: true),
              belowBarData: BarAreaData(show: true),
            ),
          ],
        ),
      ),
    );
  }
}
// Set your widget name, define your parameter, and then add the
// boilerplate code using the `</>` button on the right!
