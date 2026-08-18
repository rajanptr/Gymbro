import '/auth/supabase_auth/auth_util.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/index.dart';
import 'package:cupertino_time_picker_hiuzb7/app_state.dart'
    as cupertino_time_picker_hiuzb7_app_state;
import 'package:easy_debounce/easy_debounce.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'workout_start_model.dart';
export 'workout_start_model.dart';

class WorkoutStartWidget extends StatefulWidget {
  const WorkoutStartWidget({super.key});

  @override
  State<WorkoutStartWidget> createState() => _WorkoutStartWidgetState();
}

class _WorkoutStartWidgetState extends State<WorkoutStartWidget> {
  late WorkoutStartModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => WorkoutStartModel());

    _model.workoutNameControllerTextController ??= TextEditingController();
    _model.workoutNameControllerFocusNode ??= FocusNode();
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();
    context.watch<cupertino_time_picker_hiuzb7_app_state.FFAppState>();

    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.all(20.0),
            child: Container(
              width: double.infinity,
              child: TextFormField(
                controller: _model.workoutNameControllerTextController,
                focusNode: _model.workoutNameControllerFocusNode,
                onChanged: (_) => EasyDebounce.debounce(
                  '_model.workoutNameControllerTextController',
                  Duration(milliseconds: 2000),
                  () => safeSetState(() {}),
                ),
                autofocus: true,
                enabled: true,
                textCapitalization: TextCapitalization.characters,
                obscureText: false,
                decoration: InputDecoration(
                  isDense: true,
                  labelStyle: FlutterFlowTheme.of(context).bodyLarge.override(
                        font: GoogleFonts.urbanist(
                          fontWeight:
                              FlutterFlowTheme.of(context).bodyLarge.fontWeight,
                          fontStyle:
                              FlutterFlowTheme.of(context).bodyLarge.fontStyle,
                        ),
                        letterSpacing: 0.0,
                        fontWeight:
                            FlutterFlowTheme.of(context).bodyLarge.fontWeight,
                        fontStyle:
                            FlutterFlowTheme.of(context).bodyLarge.fontStyle,
                      ),
                  hintText: 'Workout Name',
                  hintStyle: FlutterFlowTheme.of(context).bodyLarge.override(
                        font: GoogleFonts.urbanist(
                          fontWeight:
                              FlutterFlowTheme.of(context).bodyLarge.fontWeight,
                          fontStyle:
                              FlutterFlowTheme.of(context).bodyLarge.fontStyle,
                        ),
                        letterSpacing: 0.0,
                        fontWeight:
                            FlutterFlowTheme.of(context).bodyLarge.fontWeight,
                        fontStyle:
                            FlutterFlowTheme.of(context).bodyLarge.fontStyle,
                      ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: FlutterFlowTheme.of(context).alternate,
                      width: 0.5,
                    ),
                    borderRadius: BorderRadius.circular(0.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: FlutterFlowTheme.of(context).primaryText,
                      width: 0.5,
                    ),
                    borderRadius: BorderRadius.circular(0.0),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: FlutterFlowTheme.of(context).error,
                      width: 0.5,
                    ),
                    borderRadius: BorderRadius.circular(0.0),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: FlutterFlowTheme.of(context).error,
                      width: 0.5,
                    ),
                    borderRadius: BorderRadius.circular(0.0),
                  ),
                  filled: true,
                  fillColor: FlutterFlowTheme.of(context).secondaryBackground,
                  contentPadding: EdgeInsets.all(15.0),
                  suffixIcon: _model
                          .workoutNameControllerTextController!.text.isNotEmpty
                      ? InkWell(
                          onTap: () async {
                            _model.workoutNameControllerTextController?.clear();
                            safeSetState(() {});
                          },
                          child: Icon(
                            Icons.clear,
                            color: FlutterFlowTheme.of(context).primaryText,
                            size: 22,
                          ),
                        )
                      : null,
                ),
                style: FlutterFlowTheme.of(context).bodyLarge.override(
                      font: GoogleFonts.urbanist(
                        fontWeight:
                            FlutterFlowTheme.of(context).bodyLarge.fontWeight,
                        fontStyle:
                            FlutterFlowTheme.of(context).bodyLarge.fontStyle,
                      ),
                      letterSpacing: 0.0,
                      fontWeight:
                          FlutterFlowTheme.of(context).bodyLarge.fontWeight,
                      fontStyle:
                          FlutterFlowTheme.of(context).bodyLarge.fontStyle,
                    ),
                maxLength: 20,
                maxLengthEnforcement: MaxLengthEnforcement.none,
                buildCounter: (context,
                        {required currentLength,
                        required isFocused,
                        maxLength}) =>
                    null,
                cursorColor: FlutterFlowTheme.of(context).primaryText,
                enableInteractiveSelection: false,
                validator: _model.workoutNameControllerTextControllerValidator
                    .asValidator(context),
                inputFormatters: [
                  if (!isAndroid && !isiOS)
                    TextInputFormatter.withFunction((oldValue, newValue) {
                      return TextEditingValue(
                        selection: newValue.selection,
                        text: newValue.text
                            .toCapitalization(TextCapitalization.characters),
                      );
                    }),
                ],
              ),
            ),
          ),
          Align(
            alignment: AlignmentDirectional(0.0, 1.0),
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(20.0, 20.0, 20.0, 20.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: FFButtonWidget(
                      onPressed: () async {
                        Navigator.pop(context);
                        HapticFeedback.mediumImpact();
                      },
                      text: 'CANCEL',
                      options: FFButtonOptions(
                        height: 44.0,
                        padding: EdgeInsetsDirectional.fromSTEB(
                            16.0, 0.0, 16.0, 0.0),
                        iconPadding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                        color: FlutterFlowTheme.of(context).secondaryBackground,
                        textStyle: FlutterFlowTheme.of(context)
                            .titleSmall
                            .override(
                              font: GoogleFonts.urbanist(
                                fontWeight: FlutterFlowTheme.of(context)
                                    .titleSmall
                                    .fontWeight,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .titleSmall
                                    .fontStyle,
                              ),
                              color: FlutterFlowTheme.of(context).primaryText,
                              letterSpacing: 0.0,
                              fontWeight: FlutterFlowTheme.of(context)
                                  .titleSmall
                                  .fontWeight,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .titleSmall
                                  .fontStyle,
                            ),
                        elevation: 0.0,
                        borderSide: BorderSide(
                          color: FlutterFlowTheme.of(context).alternate,
                          width: 0.5,
                        ),
                        borderRadius: BorderRadius.circular(120.0),
                      ),
                    ),
                  ),
                  Expanded(
                    child: FFButtonWidget(
                      onPressed: (_model.workoutNameControllerTextController.text ==
                                  '')
                          ? null
                          : () async {
                              await WorkoutSessionsTable().insert({
                                'user_id': currentUserUid,
                                'title': _model
                                    .workoutNameControllerTextController.text,
                                'notes': '',
                                'duration_seconds': 0,
                                'is_completed': false,
                                'created_at': supaSerialize<DateTime>(
                                    getCurrentTimestamp),
                              });
                              _model.latestWorkout =
                                  await WorkoutSessionsTable().queryRows(
                                queryFn: (q) => q
                                    .eqOrNull(
                                      'user_id',
                                      currentUserUid,
                                    )
                                    .order('created_at'),
                              );
                              FFAppState().currentWorkoutId =
                                  _model.latestWorkout!.elementAtOrNull(0)!.id!;
                              safeSetState(() {});

                              context.goNamed(
                                ActiveWorkoutPageWidget.routeName,
                                queryParameters: {
                                  'workoutId': serializeParam(
                                    FFAppState().currentWorkoutId,
                                    ParamType.String,
                                  ),
                                }.withoutNulls,
                              );

                              HapticFeedback.selectionClick();

                              safeSetState(() {});
                            },
                      text: 'START WORKOUT',
                      options: FFButtonOptions(
                        height: 44.0,
                        padding: EdgeInsetsDirectional.fromSTEB(
                            16.0, 0.0, 16.0, 0.0),
                        iconPadding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                        color: FlutterFlowTheme.of(context).primaryText,
                        textStyle:
                            FlutterFlowTheme.of(context).titleSmall.override(
                                  font: GoogleFonts.urbanist(
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .fontStyle,
                                  ),
                                  color: FlutterFlowTheme.of(context)
                                      .primaryBackground,
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .fontStyle,
                                ),
                        elevation: 0.0,
                        borderRadius: BorderRadius.circular(120.0),
                        disabledColor: FlutterFlowTheme.of(context).alternate,
                        disabledTextColor:
                            FlutterFlowTheme.of(context).secondaryText,
                      ),
                    ),
                  ),
                ].divide(SizedBox(width: 10.0)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
