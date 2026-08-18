import '/flutter_flow/flutter_flow_util.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'no_workout_model.dart';
export 'no_workout_model.dart';

class NoWorkoutWidget extends StatefulWidget {
  const NoWorkoutWidget({
    super.key,
    required this.exerciseORworkout,
  });

  final String? exerciseORworkout;

  @override
  State<NoWorkoutWidget> createState() => _NoWorkoutWidgetState();
}

class _NoWorkoutWidgetState extends State<NoWorkoutWidget> {
  late NoWorkoutModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => NoWorkoutModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'NO ${widget.exerciseORworkout} FOUND',
            style: FlutterFlowTheme.of(context).bodyLarge.override(
                  font: GoogleFonts.urbanist(
                    fontWeight:
                        FlutterFlowTheme.of(context).bodyLarge.fontWeight,
                    fontStyle: FlutterFlowTheme.of(context).bodyLarge.fontStyle,
                  ),
                  color: FlutterFlowTheme.of(context).secondaryText,
                  letterSpacing: 0.0,
                  fontWeight: FlutterFlowTheme.of(context).bodyLarge.fontWeight,
                  fontStyle: FlutterFlowTheme.of(context).bodyLarge.fontStyle,
                ),
          ),
        ],
      ),
    );
  }
}
