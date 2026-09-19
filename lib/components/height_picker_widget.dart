import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'height_picker_model.dart';
export 'height_picker_model.dart';

class HeightPickerWidget extends StatefulWidget {
  const HeightPickerWidget({super.key});

  @override
  State<HeightPickerWidget> createState() => _HeightPickerWidgetState();
}

class _HeightPickerWidgetState extends State<HeightPickerWidget> {
  late HeightPickerModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HeightPickerModel());
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
      height: double.infinity,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            width: double.infinity,
            height: 300.0,
            child: custom_widgets.CupertinoHeightPicker(
              width: double.infinity,
              height: 300.0,
              initialHeight: 170.0,
              initialUnit: 'cm',
              textColor: FlutterFlowTheme.of(context).primaryText,
              fontSize: 20.0,
              selectedBackgroundColor: FlutterFlowTheme.of(context).accent3,
              onHeightChanged: (heightCm) async {
                _model.pickedHeight = heightCm;
                safeSetState(() {});
              },
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(15.0, 20.0, 15.0, 36.0),
            child: Container(
              decoration: BoxDecoration(),
              child: FFButtonWidget(
                onPressed: () async {
                  HapticFeedback.lightImpact();
                  Navigator.pop(context, _model.pickedHeight);
                },
                text: valueOrDefault<String>(
                  functions.capitalize('Confirm'),
                  'Confirm',
                ),
                options: FFButtonOptions(
                  width: double.infinity,
                  height: 44.0,
                  padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                  iconPadding:
                      EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                  color: FlutterFlowTheme.of(context).primaryText,
                  textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                        font: GoogleFonts.urbanist(
                          fontWeight: FlutterFlowTheme.of(context)
                              .titleSmall
                              .fontWeight,
                          fontStyle:
                              FlutterFlowTheme.of(context).titleSmall.fontStyle,
                        ),
                        color: FlutterFlowTheme.of(context).primaryBackground,
                        letterSpacing: 0.0,
                        fontWeight:
                            FlutterFlowTheme.of(context).titleSmall.fontWeight,
                        fontStyle:
                            FlutterFlowTheme.of(context).titleSmall.fontStyle,
                      ),
                  elevation: 0.0,
                  borderRadius: BorderRadius.circular(120.0),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
