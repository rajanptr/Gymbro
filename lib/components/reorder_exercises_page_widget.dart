import '/backend/supabase/supabase.dart';
import '/components/drag_widget.dart';
import '/components/empty_exercise_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'reorder_exercises_page_model.dart';
export 'reorder_exercises_page_model.dart';

class ReorderExercisesPageWidget extends StatefulWidget {
  const ReorderExercisesPageWidget({
    super.key,
    required this.workoutId,
  });

  final String? workoutId;

  @override
  State<ReorderExercisesPageWidget> createState() =>
      _ReorderExercisesPageWidgetState();
}

class _ReorderExercisesPageWidgetState
    extends State<ReorderExercisesPageWidget> {
  late ReorderExercisesPageModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ReorderExercisesPageModel());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.reorderable = await WorkoutExercisesTable().queryRows(
        queryFn: (q) => q
            .eqOrNull(
              'workout_id',
              widget.workoutId,
            )
            .order('order_index', ascending: true),
      );
      _model.reorderExercises =
          _model.reorderable!.toList().cast<WorkoutExercisesRow>();
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
        color: FlutterFlowTheme.of(context).primaryBackground,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(),
            alignment: AlignmentDirectional(0.0, 0.0),
            child: Align(
              alignment: AlignmentDirectional(1.0, 0.0),
              child: Padding(
                padding: EdgeInsets.all(15.0),
                child: InkWell(
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () async {
                    Navigator.pop(context);
                    HapticFeedback.lightImpact();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).accent3,
                      shape: BoxShape.circle,
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Icon(
                        Icons.close,
                        color: FlutterFlowTheme.of(context).primaryText,
                        size: 20.0,
                      ),
                    ),
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
          Padding(
            padding: EdgeInsets.all(15.0),
            child: Text(
              'REORDER EXERCISES',
              style: FlutterFlowTheme.of(context).headlineSmall.override(
                    font: GoogleFonts.urbanist(
                      fontWeight:
                          FlutterFlowTheme.of(context).headlineSmall.fontWeight,
                      fontStyle:
                          FlutterFlowTheme.of(context).headlineSmall.fontStyle,
                    ),
                    letterSpacing: 0.0,
                    fontWeight:
                        FlutterFlowTheme.of(context).headlineSmall.fontWeight,
                    fontStyle:
                        FlutterFlowTheme.of(context).headlineSmall.fontStyle,
                  ),
            ),
          ),
          Expanded(
            child: Stack(
              children: [
                Builder(
                  builder: (context) {
                    final reorderExerciselist =
                        _model.reorderExercises.map((e) => e).toList();
                    if (reorderExerciselist.isEmpty) {
                      return Center(
                        child: EmptyExerciseWidget(),
                      );
                    }

                    return ReorderableListView.builder(
                      padding: EdgeInsets.fromLTRB(
                        0,
                        10.0,
                        0,
                        156.0,
                      ),
                      proxyDecorator: (Widget child, int index,
                              Animation<double> animation) =>
                          Material(color: Colors.transparent, child: child),
                      buildDefaultDragHandles: false,
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: reorderExerciselist.length,
                      itemBuilder: (context, reorderExerciselistIndex) {
                        final reorderExerciselistItem =
                            reorderExerciselist[reorderExerciselistIndex];
                        return Stack(
                          key: ValueKey("ListView_rle0v50z" +
                              '_' +
                              reorderExerciselistIndex.toString()),
                          children: [
                            Align(
                              alignment: AlignmentDirectional(0.0, -1.0),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    15.0, 5.0, 15.0, 5.0),
                                child: FutureBuilder<List<ExerciseLibraryRow>>(
                                  future: ExerciseLibraryTable().querySingleRow(
                                    queryFn: (q) => q.eqOrNull(
                                      'id',
                                      reorderExerciselistItem.exerciseId,
                                    ),
                                  ),
                                  builder: (context, snapshot) {
                                    // Customize what your widget looks like when it's loading.
                                    if (!snapshot.hasData) {
                                      return Center(
                                        child: SizedBox(
                                          width: 36.0,
                                          height: 36.0,
                                          child: SpinKitPulse(
                                            color: FlutterFlowTheme.of(context)
                                                .primary,
                                            size: 36.0,
                                          ),
                                        ),
                                      );
                                    }
                                    List<ExerciseLibraryRow>
                                        containerExerciseLibraryRowList =
                                        snapshot.data!;

                                    final containerExerciseLibraryRow =
                                        containerExerciseLibraryRowList
                                                .isNotEmpty
                                            ? containerExerciseLibraryRowList
                                                .first
                                            : null;

                                    return Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryBackground,
                                        borderRadius:
                                            BorderRadius.circular(4.0),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.all(15.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Container(
                                              width: 44.0,
                                              height: 44.0,
                                              decoration: BoxDecoration(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .accent3,
                                                shape: BoxShape.circle,
                                              ),
                                              child: Stack(
                                                children: [
                                                  if (containerExerciseLibraryRow
                                                                  ?.imageUrl ==
                                                              null ||
                                                          containerExerciseLibraryRow
                                                                  ?.imageUrl ==
                                                              ''
                                                      ? false
                                                      : true)
                                                    Container(
                                                      width: 44.0,
                                                      height: 44.0,
                                                      clipBehavior:
                                                          Clip.antiAlias,
                                                      decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                      ),
                                                      child: Image.network(
                                                        containerExerciseLibraryRow!
                                                            .imageUrl!,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  if (containerExerciseLibraryRow
                                                                  ?.imageUrl !=
                                                              null &&
                                                          containerExerciseLibraryRow
                                                                  ?.imageUrl !=
                                                              ''
                                                      ? false
                                                      : true)
                                                    Align(
                                                      alignment:
                                                          AlignmentDirectional(
                                                              0.0, 0.0),
                                                      child: Text(
                                                        (String name) {
                                                          return name
                                                                      .trim()
                                                                      .split(
                                                                          ' ')
                                                                      .length ==
                                                                  1
                                                              ? name
                                                                  .trim()
                                                                  .substring(
                                                                      0, 2)
                                                                  .toUpperCase()
                                                              : (name
                                                                          .trim()
                                                                          .split(' ')[
                                                                              0]
                                                                          .substring(
                                                                              0,
                                                                              1) +
                                                                      name
                                                                          .trim()
                                                                          .split(' ')[
                                                                              1]
                                                                          .substring(
                                                                              0,
                                                                              1))
                                                                  .toUpperCase();
                                                        }(containerExerciseLibraryRow!
                                                            .name),
                                                        textAlign:
                                                            TextAlign.center,
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .titleMedium
                                                                .override(
                                                                  font: GoogleFonts
                                                                      .urbanist(
                                                                    fontWeight: FlutterFlowTheme.of(
                                                                            context)
                                                                        .titleMedium
                                                                        .fontWeight,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .titleMedium
                                                                        .fontStyle,
                                                                  ),
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .secondaryText,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .titleMedium
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .titleMedium
                                                                      .fontStyle,
                                                                ),
                                                      ),
                                                    ),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    valueOrDefault<String>(
                                                      functions.capitalize(
                                                          containerExerciseLibraryRow!
                                                              .name),
                                                      'Title',
                                                    ),
                                                    maxLines: 3,
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .titleMedium
                                                        .override(
                                                          font: GoogleFonts
                                                              .urbanist(
                                                            fontWeight:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .titleMedium
                                                                    .fontWeight,
                                                            fontStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .titleMedium
                                                                    .fontStyle,
                                                          ),
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .titleMedium
                                                                  .fontWeight,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .titleMedium
                                                                  .fontStyle,
                                                        ),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                  Text(
                                                    valueOrDefault<String>(
                                                      containerExerciseLibraryRow
                                                          .muscleGroup,
                                                      'Muscle Group',
                                                    ),
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          font: GoogleFonts
                                                              .urbanist(
                                                            fontWeight:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontWeight,
                                                            fontStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontStyle,
                                                          ),
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .secondaryText,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontWeight,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontStyle,
                                                        ),
                                                  ),
                                                ].divide(SizedBox(height: 5.0)),
                                              ),
                                            ),
                                          ].divide(SizedBox(width: 10.0)),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                            Positioned.fill(
                              child: Align(
                                alignment: AlignmentDirectional.centerEnd,
                                child: MouseRegion(
                                  cursor: SystemMouseCursors.grab,
                                  child: ReorderableDragStartListener(
                                    index: reorderExerciselistIndex,
                                    child: DragWidget(),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                      onReorder: (int reorderableOldIndex,
                          int reorderableNewIndex) async {
                        _model.reorderedExercises =
                            await actions.reorderWorkoutExercises(
                          _model.reorderExercises.toList(),
                          reorderableOldIndex,
                          reorderableNewIndex,
                        );
                        _model.reorderExercises = _model.reorderedExercises!
                            .toList()
                            .cast<WorkoutExercisesRow>();
                        safeSetState(() {});

                        safeSetState(() {});
                      },
                    );
                  },
                ),
                Align(
                  alignment: AlignmentDirectional(0.0, 1.0),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          FlutterFlowTheme.of(context).accent4,
                          FlutterFlowTheme.of(context).primaryBackground,
                          FlutterFlowTheme.of(context).primaryBackground
                        ],
                        stops: [0.0, 0.4, 1.0],
                        begin: AlignmentDirectional(0.0, -1.0),
                        end: AlignmentDirectional(0, 1.0),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(
                          15.0, 20.0, 15.0, 36.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: FFButtonWidget(
                              onPressed: () async {
                                for (int loop1Index = 0;
                                    loop1Index <
                                        _model.reorderExercises
                                            .map((e) => e)
                                            .toList()
                                            .length;
                                    loop1Index++) {
                                  final currentLoop1Item = _model
                                      .reorderExercises
                                      .map((e) => e)
                                      .toList()[loop1Index];
                                  await WorkoutExercisesTable().update(
                                    data: {
                                      'order_index': loop1Index,
                                    },
                                    matchingRows: (rows) => rows.eqOrNull(
                                      'id',
                                      currentLoop1Item.id,
                                    ),
                                  );
                                }
                                Navigator.pop(context);

                                safeSetState(() {});
                              },
                              text: valueOrDefault<String>(
                                functions.capitalize('save'),
                                'SAVE',
                              ),
                              options: FFButtonOptions(
                                width: double.infinity,
                                height: 44.0,
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    16.0, 0.0, 16.0, 0.0),
                                iconPadding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 0.0),
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
                              ),
                            ),
                          ),
                        ].divide(SizedBox(width: 10.0)),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
