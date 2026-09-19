import '/auth/supabase_auth/auth_util.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'rest_days_model.dart';
export 'rest_days_model.dart';

class RestDaysWidget extends StatefulWidget {
  const RestDaysWidget({super.key});

  @override
  State<RestDaysWidget> createState() => _RestDaysWidgetState();
}

class _RestDaysWidgetState extends State<RestDaysWidget> {
  late RestDaysModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => RestDaysModel());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.profileQuery = await ProfilesTable().queryRows(
        queryFn: (q) => q.eqOrNull(
          'id',
          currentUserUid,
        ),
      );
      _model.selectedDays =
          _model.profileQuery!.firstOrNull!.restDays.toList().cast<int>();
      safeSetState(() {});
    });
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
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              width: MediaQuery.sizeOf(context).width * 1.0,
              height: 200.0,
              child: custom_widgets.RestDaysPicker(
                width: MediaQuery.sizeOf(context).width * 1.0,
                height: 200.0,
                initialRestDays: _model.selectedDays,
                titleFontSize: 24.0,
                selectedColor: FlutterFlowTheme.of(context).primaryText,
                selectedTextColor: FlutterFlowTheme.of(context).primaryText,
                selectedDotColor: FlutterFlowTheme.of(context).primaryText,
                unselectedBackgroundColor:
                    FlutterFlowTheme.of(context).alternate,
                borderColor: FlutterFlowTheme.of(context).accent3,
                selectedBorderColor: FlutterFlowTheme.of(context).primaryText,
                descriptionFontSize: 16.0,
                dayFontSize: 12.0,
                statusFontSize: 16.0,
                titleTextColor: FlutterFlowTheme.of(context).primaryText,
                descriptionTextColor:
                    FlutterFlowTheme.of(context).secondaryText,
                dayTextColor: FlutterFlowTheme.of(context).primaryText,
                statusTextColor: FlutterFlowTheme.of(context).success,
                onRestDaysChanged: (selectedDays) async {
                  _model.selectedDays = selectedDays.toList().cast<int>();
                  safeSetState(() {});
                },
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 0.0, 36.0),
              child: FFButtonWidget(
                onPressed: () async {
                  HapticFeedback.lightImpact();
                  await ProfilesTable().update(
                    data: {
                      'rest_days': _model.selectedDays,
                    },
                    matchingRows: (rows) => rows.eqOrNull(
                      'id',
                      currentUserUid,
                    ),
                  );
                  Navigator.pop(context);
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
          ],
        ),
      ),
    );
  }
}
