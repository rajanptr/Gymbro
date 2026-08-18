import '/backend/supabase/supabase.dart';
import '/components/reorder_exercises_page_widget.dart';
import '/components/replace_exercise_bottom_sheet_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'card_edit_model.dart';
export 'card_edit_model.dart';

class CardEditWidget extends StatefulWidget {
  const CardEditWidget({
    super.key,
    required this.workoutId,
    required this.setnumber,
    required this.workoutExerciseId,
  });

  final String? workoutId;
  final List<int>? setnumber;
  final String? workoutExerciseId;

  @override
  State<CardEditWidget> createState() => _CardEditWidgetState();
}

class _CardEditWidgetState extends State<CardEditWidget> {
  late CardEditModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CardEditModel());
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
        padding: EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 0.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 0.0),
              child: InkWell(
                splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                hoverColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () async {
                  HapticFeedback.lightImpact();
                  await showModalBottomSheet(
                    isScrollControlled: true,
                    backgroundColor: Color(0xA6000000),
                    enableDrag: false,
                    context: context,
                    builder: (context) {
                      return Padding(
                        padding: MediaQuery.viewInsetsOf(context),
                        child: Container(
                          height: MediaQuery.sizeOf(context).height * 0.8,
                          child: ReplaceExerciseBottomSheetWidget(
                            workoutExerciseId: widget.workoutExerciseId!,
                          ),
                        ),
                      );
                    },
                  ).then((value) => safeSetState(() {}));

                  Navigator.pop(context);
                },
                child: Container(
                  decoration: BoxDecoration(),
                  child: Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 15.0, 10.0, 15.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.loop_outlined,
                          color: FlutterFlowTheme.of(context).primaryText,
                          size: 20.0,
                        ),
                        Expanded(
                          child: Text(
                            'Switch Exercise',
                            style:
                                FlutterFlowTheme.of(context).bodyLarge.override(
                                      font: GoogleFonts.urbanist(
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .bodyLarge
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodyLarge
                                            .fontStyle,
                                      ),
                                      letterSpacing: 0.0,
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .bodyLarge
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyLarge
                                          .fontStyle,
                                    ),
                          ),
                        ),
                      ].divide(SizedBox(width: 10.0)),
                    ),
                  ),
                ),
              ),
            ),
            Divider(
              height: 1.0,
              thickness: 0.5,
              color: FlutterFlowTheme.of(context).alternate,
            ),
            InkWell(
              splashColor: Colors.transparent,
              focusColor: Colors.transparent,
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () async {
                HapticFeedback.lightImpact();
                await showModalBottomSheet(
                  isScrollControlled: true,
                  backgroundColor: Color(0xA5000000),
                  isDismissible: false,
                  enableDrag: false,
                  context: context,
                  builder: (context) {
                    return Padding(
                      padding: MediaQuery.viewInsetsOf(context),
                      child: Container(
                        height: MediaQuery.sizeOf(context).height * 0.85,
                        child: ReorderExercisesPageWidget(
                          workoutId: widget.workoutId!,
                        ),
                      ),
                    );
                  },
                ).then((value) => safeSetState(() {}));

                Navigator.pop(context);
              },
              child: Container(
                decoration: BoxDecoration(),
                child: Padding(
                  padding:
                      EdgeInsetsDirectional.fromSTEB(0.0, 15.0, 10.0, 15.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.reorder_sharp,
                        color: FlutterFlowTheme.of(context).primaryText,
                        size: 20.0,
                      ),
                      Expanded(
                        child: Text(
                          'Reorder Exercises',
                          style:
                              FlutterFlowTheme.of(context).bodyLarge.override(
                                    font: GoogleFonts.urbanist(
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .bodyLarge
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyLarge
                                          .fontStyle,
                                    ),
                                    letterSpacing: 0.0,
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .bodyLarge
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyLarge
                                        .fontStyle,
                                  ),
                        ),
                      ),
                    ].divide(SizedBox(width: 10.0)),
                  ),
                ),
              ),
            ),
            Divider(
              height: 1.0,
              thickness: 0.5,
              color: FlutterFlowTheme.of(context).alternate,
            ),
            InkWell(
              splashColor: Colors.transparent,
              focusColor: Colors.transparent,
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () async {
                HapticFeedback.lightImpact();
                await ExerciseSetsTable().insert({
                  'workout_exercise_id': widget.workoutId,
                  'completed': false,
                  'created_at': supaSerialize<DateTime>(getCurrentTimestamp),
                });
                Navigator.pop(context);
              },
              child: Container(
                decoration: BoxDecoration(),
                child: Padding(
                  padding:
                      EdgeInsetsDirectional.fromSTEB(0.0, 15.0, 10.0, 15.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.add_sharp,
                        color: FlutterFlowTheme.of(context).primaryText,
                        size: 20.0,
                      ),
                      Expanded(
                        child: Text(
                          'Add Set',
                          style:
                              FlutterFlowTheme.of(context).bodyLarge.override(
                                    font: GoogleFonts.urbanist(
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .bodyLarge
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyLarge
                                          .fontStyle,
                                    ),
                                    letterSpacing: 0.0,
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .bodyLarge
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyLarge
                                        .fontStyle,
                                  ),
                        ),
                      ),
                    ].divide(SizedBox(width: 10.0)),
                  ),
                ),
              ),
            ),
            Divider(
              height: 1.0,
              thickness: 0.5,
              color: FlutterFlowTheme.of(context).alternate,
            ),
            Container(
              decoration: BoxDecoration(),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 0.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 15.0, 0.0, 0.0),
                      child: Text(
                        'Any weight or reps entered for this set will also be deleted. This action can\'t be undone.',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              font: GoogleFonts.urbanist(
                                fontWeight: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .fontWeight,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .fontStyle,
                              ),
                              color: FlutterFlowTheme.of(context).secondaryText,
                              letterSpacing: 0.0,
                              fontWeight: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .fontWeight,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .fontStyle,
                            ),
                      ),
                    ),
                    InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () async {
                        HapticFeedback.lightImpact();
                        await ExerciseSetsTable().delete(
                          matchingRows: (rows) => rows
                              .eqOrNull(
                                'workout_exercise_id',
                                widget.workoutExerciseId,
                              )
                              .eqOrNull(
                                'set_number',
                                widget.setnumber?.lastOrNull,
                              ),
                        );
                        Navigator.pop(context);
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.close,
                            color: FlutterFlowTheme.of(context).primary,
                            size: 20.0,
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 15.0, 10.0, 15.0),
                            child: Text(
                              'Remove Last Set',
                              style: FlutterFlowTheme.of(context)
                                  .bodyLarge
                                  .override(
                                    font: GoogleFonts.urbanist(
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .bodyLarge
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyLarge
                                          .fontStyle,
                                    ),
                                    color: FlutterFlowTheme.of(context).primary,
                                    letterSpacing: 0.0,
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .bodyLarge
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyLarge
                                        .fontStyle,
                                  ),
                            ),
                          ),
                        ].divide(SizedBox(width: 10.0)),
                      ),
                    ),
                  ].divide(SizedBox(height: 10.0)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
