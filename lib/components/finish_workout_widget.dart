import '/auth/supabase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/backend/schema/structs/index.dart';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'finish_workout_model.dart';
export 'finish_workout_model.dart';

class FinishWorkoutWidget extends StatefulWidget {
  const FinishWorkoutWidget({
    super.key,
    this.currentWorkoutId,
    required this.title,
    this.note,
  });

  final String? currentWorkoutId;
  final String? title;
  final String? note;

  @override
  State<FinishWorkoutWidget> createState() => _FinishWorkoutWidgetState();
}

class _FinishWorkoutWidgetState extends State<FinishWorkoutWidget> {
  late FinishWorkoutModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => FinishWorkoutModel());
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Divider(
            height: 1.0,
            thickness: 0.5,
            color: FlutterFlowTheme.of(context).alternate,
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(15.0, 0.0, 15.0, 0.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Ready to finish?',
                  style: FlutterFlowTheme.of(context).titleMedium.override(
                        font: GoogleFonts.urbanist(
                          fontWeight: FlutterFlowTheme.of(context)
                              .titleMedium
                              .fontWeight,
                          fontStyle: FlutterFlowTheme.of(context)
                              .titleMedium
                              .fontStyle,
                        ),
                        letterSpacing: 0.0,
                        fontWeight:
                            FlutterFlowTheme.of(context).titleMedium.fontWeight,
                        fontStyle:
                            FlutterFlowTheme.of(context).titleMedium.fontStyle,
                      ),
                ),
                Text(
                  'Save your progress and generate your workout summary.',
                  style: FlutterFlowTheme.of(context).bodyLarge.override(
                        font: GoogleFonts.urbanist(
                          fontWeight:
                              FlutterFlowTheme.of(context).bodyLarge.fontWeight,
                          fontStyle:
                              FlutterFlowTheme.of(context).bodyLarge.fontStyle,
                        ),
                        color: FlutterFlowTheme.of(context).secondaryText,
                        letterSpacing: 0.0,
                        fontWeight:
                            FlutterFlowTheme.of(context).bodyLarge.fontWeight,
                        fontStyle:
                            FlutterFlowTheme.of(context).bodyLarge.fontStyle,
                      ),
                ),
              ].divide(SizedBox(height: 10.0)),
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(15.0, 36.0, 15.0, 20.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: FFButtonWidget(
                    onPressed: () async {
                      Navigator.pop(context);
                      HapticFeedback.selectionClick();
                    },
                    text: 'CANCEL',
                    options: FFButtonOptions(
                      height: 44.0,
                      padding:
                          EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                      iconPadding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                      color: FlutterFlowTheme.of(context).secondaryBackground,
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
                    onPressed: () async {
                      _model.workoutSession =
                          await WorkoutSessionsTable().queryRows(
                        queryFn: (q) => q.eqOrNull(
                          'id',
                          widget.currentWorkoutId,
                        ),
                      );
                      if (!(_model.workoutSession?.firstOrNull?.finishedAt !=
                          null)) {
                        await WorkoutSessionsTable().update(
                          data: {
                            'finished_at':
                                supaSerialize<DateTime>(getCurrentTimestamp),
                            'is_completed': true,
                            'id': widget.currentWorkoutId,
                            'duration_seconds':
                                getCurrentTimestamp.secondsSinceEpoch -
                                    _model.workoutSession!.firstOrNull!
                                        .startedAt!.secondsSinceEpoch,
                          },
                          matchingRows: (rows) => rows.eqOrNull(
                            'id',
                            widget.currentWorkoutId,
                          ),
                        );
                        _model.workoutExercises =
                            await WorkoutExercisesTable().queryRows(
                          queryFn: (q) => q.eqOrNull(
                            'workout_id',
                            widget.currentWorkoutId,
                          ),
                        );
                        _model.exerciseSets =
                            await ExerciseSetsTable().queryRows(
                          queryFn: (q) => q
                              .inFilterOrNull(
                                'workout_exercise_id',
                                _model.workoutExercises
                                    ?.map((e) => e.id)
                                    .withoutNulls
                                    .toList(),
                              )
                              .eqOrNull(
                                'completed',
                                true,
                              ),
                        );
                        _model.dataInserted =
                            await CompletedWorkoutsTable().insert({
                          'workout_id': widget.currentWorkoutId,
                          'workout_name': widget.title,
                          'started_at': supaSerialize<DateTime>(
                              _model.workoutSession?.firstOrNull?.startedAt),
                          'ended_at':
                              supaSerialize<DateTime>(getCurrentTimestamp),
                          'duration_seconds':
                              getCurrentTimestamp.secondsSinceEpoch -
                                  _model.workoutSession!.firstOrNull!.startedAt!
                                      .secondsSinceEpoch,
                          'total_exercises': _model.workoutExercises?.length,
                          'total_sets': _model.exerciseSets?.length,
                          'total_reps': (List<int> sets) {
                            return sets.fold<int>(
                                0, (sum, reps) => sum + (reps ?? 0));
                          }(_model.exerciseSets!
                              .map((e) => e.reps)
                              .withoutNulls
                              .toList()),
                          'total_volume':
                              (List<double> weights, List<int> reps) {
                            return weights.asMap().entries.fold<int>(
                                0,
                                (sum, entry) =>
                                    sum +
                                    ((entry.value ?? 0.0) *
                                            (reps[entry.key] ?? 0))
                                        .round());
                          }(
                                  _model.exerciseSets!
                                      .map((e) => e.weight)
                                      .withoutNulls
                                      .toList(),
                                  _model.exerciseSets!
                                      .map((e) => e.reps)
                                      .withoutNulls
                                      .toList()),
                          'total_prs': 0,
                          'notes': widget.note,
                          'user_id': currentUserUid,
                        });
                        HapticFeedback.lightImpact();
                        _model.aIWorkoutAnalysis =
                            await AIWorkoutAnalysisCall.call(
                          workoutId: widget.currentWorkoutId,
                          authToken: currentJwtToken,
                        );

                        context.goNamed(
                          WorkoutSummaryWidget.routeName,
                          queryParameters: {
                            'workoutId': serializeParam(
                              widget.currentWorkoutId,
                              ParamType.String,
                            ),
                            'aiAnalysis': serializeParam(
                              WorkoutAIResponseStruct.maybeFromMap(
                                      (_model.aIWorkoutAnalysis?.jsonBody ??
                                          ''))
                                  ?.analysis,
                              ParamType.DataStruct,
                            ),
                          }.withoutNulls,
                        );
                      }

                      safeSetState(() {});
                    },
                    text: 'SAVE AND FINISH',
                    options: FFButtonOptions(
                      height: 44.0,
                      padding:
                          EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                      iconPadding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                      color: FlutterFlowTheme.of(context).primaryText,
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
                            color:
                                FlutterFlowTheme.of(context).primaryBackground,
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
                    ),
                  ),
                ),
              ].divide(SizedBox(width: 10.0)),
            ),
          ),
        ].divide(SizedBox(height: 20.0)),
      ),
    );
  }
}
