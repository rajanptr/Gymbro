import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dob_picker_model.dart';
export 'dob_picker_model.dart';

class DobPickerWidget extends StatefulWidget {
  const DobPickerWidget({super.key});

  @override
  State<DobPickerWidget> createState() => _DobPickerWidgetState();
}

class _DobPickerWidgetState extends State<DobPickerWidget> {
  late DobPickerModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => DobPickerModel());
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
            child: custom_widgets.CupertinoDOBPicker(
              width: double.infinity,
              height: 300.0,
              initialDate: getCurrentTimestamp,
              selectedBackgroundColor: FlutterFlowTheme.of(context).tertiary,
              textColor: FlutterFlowTheme.of(context).primaryText,
              fontSize: 24.0,
              onDateChanged: (selectedDate) async {
                _model.datePicked = selectedDate;
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
                  Navigator.pop(context, _model.datePicked);
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
