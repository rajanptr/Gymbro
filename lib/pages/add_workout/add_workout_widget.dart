import '/auth/supabase_auth/auth_util.dart';
import '/backend/supabase/supabase.dart';
import '/components/bottom_nav_widget.dart';
import '/components/edit_bottomsheet_widget.dart';
import '/components/no_workout_widget.dart';
import '/components/workout_start_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'add_workout_model.dart';
export 'add_workout_model.dart';

class AddWorkoutWidget extends StatefulWidget {
  const AddWorkoutWidget({super.key});

  static String routeName = 'addWorkout';
  static String routePath = 'addWorkout';

  @override
  State<AddWorkoutWidget> createState() => _AddWorkoutWidgetState();
}

class _AddWorkoutWidgetState extends State<AddWorkoutWidget> {
  late AddWorkoutModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AddWorkoutModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.searchQuery = '';
      safeSetState(() {});
    });
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: SafeArea(
          top: true,
          child: Stack(
            children: [
              Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    width: double.infinity,
                    height: 54.0,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).primaryBackground,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.asset(
                              Theme.of(context).brightness == Brightness.dark
                                  ? 'assets/images/logo_dark.png'
                                  : 'assets/images/logo_light.png',
                              height: 36.0,
                              fit: BoxFit.contain,
                              alignment: Alignment(-1.0, 0.0),
                            ),
                          ),
                        ),
                        InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            context.pushNamed(AllExercisesWidget.routeName);

                            HapticFeedback.selectionClick();
                          },
                          child: Container(
                            width: 44.0,
                            height: 44.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(120.0),
                              border: Border.all(
                                color: FlutterFlowTheme.of(context).alternate,
                                width: 0.5,
                              ),
                            ),
                            child: Icon(
                              Icons.fitness_center_outlined,
                              color: FlutterFlowTheme.of(context).primaryText,
                              size: 20.0,
                            ),
                          ),
                        ),
                      ]
                          .addToStart(SizedBox(width: 15.0))
                          .addToEnd(SizedBox(width: 15.0)),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(),
                    child: Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(15.0, 0.0, 15.0, 0.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 16.0, 0.0, 0.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Expanded(
                                      child: Container(
                                        height: 1.0,
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            colors: [
                                              FlutterFlowTheme.of(context)
                                                  .alternate,
                                              FlutterFlowTheme.of(context)
                                                  .primaryBackground
                                            ],
                                            stops: [0.0, 1.0],
                                            begin:
                                                AlignmentDirectional(1.0, 0.0),
                                            end: AlignmentDirectional(-1.0, 0),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Text(
                                      'WORKOUTS',
                                      style: FlutterFlowTheme.of(context)
                                          .bodySmall
                                          .override(
                                            font: GoogleFonts.urbanist(
                                              fontWeight: FontWeight.w600,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodySmall
                                                      .fontStyle,
                                            ),
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryText,
                                            letterSpacing: 4.0,
                                            fontWeight: FontWeight.w600,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodySmall
                                                    .fontStyle,
                                          ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        height: 1.0,
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            colors: [
                                              FlutterFlowTheme.of(context)
                                                  .primaryBackground,
                                              FlutterFlowTheme.of(context)
                                                  .alternate
                                            ],
                                            stops: [0.0, 1.0],
                                            begin:
                                                AlignmentDirectional(1.0, 0.0),
                                            end: AlignmentDirectional(-1.0, 0),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ].divide(SizedBox(width: 15.0)),
                                ),
                              ),
                              Builder(
                                builder: (context) => InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    await showDialog(
                                      barrierColor: Color(0xA7000000),
                                      barrierDismissible: false,
                                      context: context,
                                      builder: (dialogContext) {
                                        return Dialog(
                                          elevation: 0,
                                          insetPadding: EdgeInsets.zero,
                                          backgroundColor: Colors.transparent,
                                          alignment: AlignmentDirectional(
                                                  0.0, 0.0)
                                              .resolve(
                                                  Directionality.of(context)),
                                          child: GestureDetector(
                                            onTap: () {
                                              FocusScope.of(dialogContext)
                                                  .unfocus();
                                              FocusManager.instance.primaryFocus
                                                  ?.unfocus();
                                            },
                                            child: Container(
                                              height: 220.0,
                                              width: MediaQuery.sizeOf(context)
                                                      .width *
                                                  0.9,
                                              child: WorkoutStartWidget(),
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  child: Container(
                                    width: double.infinity,
                                    height: 64.0,
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                      borderRadius:
                                          BorderRadius.circular(120.0),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Icon(
                                              Icons.add_circle_outline_sharp,
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                              size: 20.0,
                                            ),
                                            Text(
                                              'Start Empty Workout',
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .bodyLarge
                                                  .override(
                                                    font: GoogleFonts.urbanist(
                                                      fontWeight:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyLarge
                                                              .fontWeight,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyLarge
                                                              .fontStyle,
                                                    ),
                                                    letterSpacing: 0.0,
                                                    fontWeight:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyLarge
                                                            .fontWeight,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyLarge
                                                            .fontStyle,
                                                  ),
                                            ),
                                          ].divide(SizedBox(width: 10.0)),
                                        ),
                                      ]
                                          .divide(SizedBox(width: 20.0))
                                          .around(SizedBox(width: 20.0)),
                                    ),
                                  ),
                                ),
                              ),
                              InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  context.goNamed(
                                    CreateTemplatePageWidget.routeName,
                                    queryParameters: {
                                      'isEdit': serializeParam(
                                        false,
                                        ParamType.bool,
                                      ),
                                      'templateId': serializeParam(
                                        '',
                                        ParamType.String,
                                      ),
                                      'name': serializeParam(
                                        null,
                                        ParamType.String,
                                      ),
                                    }.withoutNulls,
                                    extra: <String, dynamic>{
                                      '__transition_info__': TransitionInfo(
                                        hasTransition: true,
                                        transitionType: PageTransitionType.fade,
                                        duration: Duration(milliseconds: 200),
                                      ),
                                    },
                                  );

                                  HapticFeedback.lightImpact();
                                },
                                child: Container(
                                  width: double.infinity,
                                  height: 64.0,
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
                                    borderRadius: BorderRadius.circular(120.0),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Icon(
                                            Icons.add_circle_outline_sharp,
                                            color: FlutterFlowTheme.of(context)
                                                .primaryText,
                                            size: 20.0,
                                          ),
                                          Text(
                                            'Create New Routine',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyLarge
                                                .override(
                                                  font: GoogleFonts.urbanist(
                                                    fontWeight:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyLarge
                                                            .fontWeight,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyLarge
                                                            .fontStyle,
                                                  ),
                                                  letterSpacing: 0.0,
                                                  fontWeight:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyLarge
                                                          .fontWeight,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyLarge
                                                          .fontStyle,
                                                ),
                                          ),
                                        ].divide(SizedBox(width: 10.0)),
                                      ),
                                    ]
                                        .divide(SizedBox(width: 20.0))
                                        .around(SizedBox(width: 20.0)),
                                  ),
                                ),
                              ),
                            ].divide(SizedBox(height: 20.0)),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 16.0, 0.0, 0.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Expanded(
                                  child: Container(
                                    height: 1.0,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          FlutterFlowTheme.of(context)
                                              .alternate,
                                          FlutterFlowTheme.of(context)
                                              .primaryBackground
                                        ],
                                        stops: [0.0, 1.0],
                                        begin: AlignmentDirectional(1.0, 0.0),
                                        end: AlignmentDirectional(-1.0, 0),
                                      ),
                                    ),
                                  ),
                                ),
                                Text(
                                  'ROUTINES',
                                  style: FlutterFlowTheme.of(context)
                                      .bodySmall
                                      .override(
                                        font: GoogleFonts.urbanist(
                                          fontWeight: FontWeight.w600,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .bodySmall
                                                  .fontStyle,
                                        ),
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryText,
                                        letterSpacing: 4.0,
                                        fontWeight: FontWeight.w600,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodySmall
                                            .fontStyle,
                                      ),
                                ),
                                Expanded(
                                  child: Container(
                                    height: 1.0,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          FlutterFlowTheme.of(context)
                                              .primaryBackground,
                                          FlutterFlowTheme.of(context).alternate
                                        ],
                                        stops: [0.0, 1.0],
                                        begin: AlignmentDirectional(1.0, 0.0),
                                        end: AlignmentDirectional(-1.0, 0),
                                      ),
                                    ),
                                  ),
                                ),
                              ].divide(SizedBox(width: 15.0)),
                            ),
                          ),
                          FutureBuilder<List<RoutineTemplatesRow>>(
                            future: RoutineTemplatesTable().queryRows(
                              queryFn: (q) => q
                                  .eqOrNull(
                                    'user_id',
                                    currentUserUid,
                                  )
                                  .order('created_at'),
                            ),
                            builder: (context, snapshot) {
                              // Customize what your widget looks like when it's loading.
                              if (!snapshot.hasData) {
                                return Center(
                                  child: SizedBox(
                                    width: 36.0,
                                    height: 36.0,
                                    child: SpinKitPulse(
                                      color:
                                          FlutterFlowTheme.of(context).primary,
                                      size: 36.0,
                                    ),
                                  ),
                                );
                              }
                              List<RoutineTemplatesRow>
                                  templetsRoutineTemplatesRowList =
                                  snapshot.data!;

                              return Container(
                                decoration: BoxDecoration(),
                                child: Builder(
                                  builder: (context) {
                                    final templetCreated =
                                        templetsRoutineTemplatesRowList
                                            .map((e) => e)
                                            .toList();
                                    if (templetCreated.isEmpty) {
                                      return Center(
                                        child: Container(
                                          height: 300.0,
                                          child: NoWorkoutWidget(
                                            exerciseORworkout: 'ROUTINES',
                                          ),
                                        ),
                                      );
                                    }

                                    return Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children:
                                          List.generate(templetCreated.length,
                                              (templetCreatedIndex) {
                                        final templetCreatedItem =
                                            templetCreated[templetCreatedIndex];
                                        return FutureBuilder<
                                            List<RoutineExercisesRow>>(
                                          future:
                                              RoutineExercisesTable().queryRows(
                                            queryFn: (q) => q
                                                .eqOrNull(
                                                  'template_id',
                                                  templetCreatedItem.id,
                                                )
                                                .order('order_index',
                                                    ascending: true),
                                          ),
                                          builder: (context, snapshot) {
                                            // Customize what your widget looks like when it's loading.
                                            if (!snapshot.hasData) {
                                              return Center(
                                                child: SizedBox(
                                                  width: 36.0,
                                                  height: 36.0,
                                                  child: SpinKitPulse(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primary,
                                                    size: 36.0,
                                                  ),
                                                ),
                                              );
                                            }
                                            List<RoutineExercisesRow>
                                                containerRoutineExercisesRowList =
                                                snapshot.data!;

                                            return Container(
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryBackground,
                                                borderRadius:
                                                    BorderRadius.circular(4.0),
                                              ),
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        15.0, 20.0, 15.0, 20.0),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Expanded(
                                                          child: Text(
                                                            valueOrDefault<
                                                                String>(
                                                              functions.capitalize(
                                                                  templetCreatedItem
                                                                      .name),
                                                              'Workout Name',
                                                            ),
                                                            maxLines: 2,
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .titleLarge
                                                                .override(
                                                                  font: GoogleFonts
                                                                      .urbanist(
                                                                    fontWeight: FlutterFlowTheme.of(
                                                                            context)
                                                                        .titleLarge
                                                                        .fontWeight,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .titleLarge
                                                                        .fontStyle,
                                                                  ),
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .titleLarge
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .titleLarge
                                                                      .fontStyle,
                                                                ),
                                                          ),
                                                        ),
                                                        InkWell(
                                                          splashColor: Colors
                                                              .transparent,
                                                          focusColor: Colors
                                                              .transparent,
                                                          hoverColor: Colors
                                                              .transparent,
                                                          highlightColor: Colors
                                                              .transparent,
                                                          onTap: () async {
                                                            HapticFeedback
                                                                .lightImpact();
                                                            await showModalBottomSheet(
                                                              isScrollControlled:
                                                                  true,
                                                              backgroundColor:
                                                                  Color(
                                                                      0x99000000),
                                                              enableDrag: false,
                                                              useSafeArea: true,
                                                              context: context,
                                                              builder:
                                                                  (context) {
                                                                return GestureDetector(
                                                                  onTap: () {
                                                                    FocusScope.of(
                                                                            context)
                                                                        .unfocus();
                                                                    FocusManager
                                                                        .instance
                                                                        .primaryFocus
                                                                        ?.unfocus();
                                                                  },
                                                                  child:
                                                                      Padding(
                                                                    padding: MediaQuery
                                                                        .viewInsetsOf(
                                                                            context),
                                                                    child:
                                                                        Container(
                                                                      height:
                                                                          185.0,
                                                                      child:
                                                                          EditBottomsheetWidget(
                                                                        templetId:
                                                                            templetCreatedItem.id!,
                                                                        name: templetCreatedItem
                                                                            .name,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                );
                                                              },
                                                            ).then((value) =>
                                                                safeSetState(
                                                                    () {}));
                                                          },
                                                          child: Container(
                                                            width: 36.0,
                                                            height: 36.0,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .secondaryBackground,
                                                            ),
                                                            child: Icon(
                                                              Icons
                                                                  .keyboard_control,
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .primaryText,
                                                              size: 20.0,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0.0,
                                                                  0.0,
                                                                  0.0,
                                                                  15.0),
                                                      child: Text(
                                                        'Note: ${valueOrDefault<String>(
                                                          templetCreatedItem
                                                              .notes,
                                                          'notes',
                                                        )}',
                                                        maxLines: 3,
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .labelLarge
                                                                .override(
                                                                  font: GoogleFonts
                                                                      .urbanist(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .labelLarge
                                                                        .fontStyle,
                                                                  ),
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelLarge
                                                                      .fontStyle,
                                                                ),
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ),
                                                    Divider(
                                                      height: 1.0,
                                                      thickness: 0.5,
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .alternate,
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0.0,
                                                                  15.0,
                                                                  15.0,
                                                                  0.0),
                                                      child: Builder(
                                                        builder: (context) {
                                                          final exercises =
                                                              containerRoutineExercisesRowList
                                                                  .map((e) => e)
                                                                  .toList()
                                                                  .take(3)
                                                                  .toList();

                                                          return ListView
                                                              .builder(
                                                            padding:
                                                                EdgeInsets.zero,
                                                            primary: false,
                                                            shrinkWrap: true,
                                                            scrollDirection:
                                                                Axis.vertical,
                                                            itemCount: exercises
                                                                .length,
                                                            itemBuilder: (context,
                                                                exercisesIndex) {
                                                              final exercisesItem =
                                                                  exercises[
                                                                      exercisesIndex];
                                                              return FutureBuilder<
                                                                  List<
                                                                      ExerciseLibraryRow>>(
                                                                future: ExerciseLibraryTable()
                                                                    .querySingleRow(
                                                                  queryFn: (q) =>
                                                                      q.eqOrNull(
                                                                    'id',
                                                                    exercisesItem
                                                                        .exerciseId,
                                                                  ),
                                                                ),
                                                                builder: (context,
                                                                    snapshot) {
                                                                  // Customize what your widget looks like when it's loading.
                                                                  if (!snapshot
                                                                      .hasData) {
                                                                    return Center(
                                                                      child:
                                                                          SizedBox(
                                                                        width:
                                                                            36.0,
                                                                        height:
                                                                            36.0,
                                                                        child:
                                                                            SpinKitPulse(
                                                                          color:
                                                                              FlutterFlowTheme.of(context).primary,
                                                                          size:
                                                                              36.0,
                                                                        ),
                                                                      ),
                                                                    );
                                                                  }
                                                                  List<ExerciseLibraryRow>
                                                                      containerExerciseLibraryRowList =
                                                                      snapshot
                                                                          .data!;

                                                                  final containerExerciseLibraryRow = containerExerciseLibraryRowList
                                                                          .isNotEmpty
                                                                      ? containerExerciseLibraryRowList
                                                                          .first
                                                                      : null;

                                                                  return Container(
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .secondaryBackground,
                                                                    ),
                                                                    child: Text(
                                                                      valueOrDefault<
                                                                          String>(
                                                                        containerExerciseLibraryRow
                                                                            ?.name,
                                                                        'name',
                                                                      ),
                                                                      maxLines:
                                                                          1,
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .titleSmall
                                                                          .override(
                                                                            font:
                                                                                GoogleFonts.urbanist(
                                                                              fontWeight: FontWeight.w500,
                                                                              fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                                                            ),
                                                                            color:
                                                                                FlutterFlowTheme.of(context).secondaryText,
                                                                            letterSpacing:
                                                                                0.0,
                                                                            fontWeight:
                                                                                FontWeight.w500,
                                                                            fontStyle:
                                                                                FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                                                            lineHeight:
                                                                                1.0,
                                                                          ),
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                    ),
                                                                  );
                                                                },
                                                              );
                                                            },
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                    if (((int var1) {
                                                          return var1 > 3
                                                              ? var1 - 3
                                                              : 0;
                                                        }(containerRoutineExercisesRowList
                                                                .length))
                                                            .toString() !=
                                                        '0')
                                                      Text(
                                                        '+${((containerRoutineExercisesRowList.length - 3)).toString()} more',
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyLarge
                                                                .override(
                                                                  font: GoogleFonts
                                                                      .urbanist(
                                                                    fontWeight: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyLarge
                                                                        .fontWeight,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyLarge
                                                                        .fontStyle,
                                                                  ),
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .secondaryText,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyLarge
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyLarge
                                                                      .fontStyle,
                                                                ),
                                                      ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0.0,
                                                                  36.0,
                                                                  0.0,
                                                                  0.0),
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Expanded(
                                                            child:
                                                                FFButtonWidget(
                                                              onPressed:
                                                                  () async {
                                                                _model.newWorkoutSession =
                                                                    await WorkoutSessionsTable()
                                                                        .insert({
                                                                  'user_id':
                                                                      currentUserUid,
                                                                  'title':
                                                                      templetCreatedItem
                                                                          .name,
                                                                  'notes':
                                                                      templetCreatedItem
                                                                          .notes,
                                                                  'is_completed':
                                                                      false,
                                                                  'template_id':
                                                                      templetCreatedItem
                                                                          .id,
                                                                  'duration_seconds':
                                                                      0,
                                                                });
                                                                _model.templateExercises =
                                                                    await RoutineExercisesTable()
                                                                        .queryRows(
                                                                  queryFn: (q) => q
                                                                      .eqOrNull(
                                                                        'template_id',
                                                                        templetCreatedItem
                                                                            .id,
                                                                      )
                                                                      .order('order_index'),
                                                                );
                                                                for (int loop1Index =
                                                                        0;
                                                                    loop1Index <
                                                                        _model
                                                                            .templateExercises!
                                                                            .length;
                                                                    loop1Index++) {
                                                                  final currentLoop1Item =
                                                                      _model.templateExercises![
                                                                          loop1Index];
                                                                  _model.action3 =
                                                                      await WorkoutExercisesTable()
                                                                          .insert({
                                                                    'workout_id':
                                                                        _model
                                                                            .newWorkoutSession
                                                                            ?.id,
                                                                    'exercise_id':
                                                                        currentLoop1Item
                                                                            .exerciseId,
                                                                    'order_index':
                                                                        currentLoop1Item
                                                                            .orderIndex,
                                                                  });
                                                                  _model.routineSets =
                                                                      await RoutineSetsTable()
                                                                          .queryRows(
                                                                    queryFn: (q) => q
                                                                        .eqOrNull(
                                                                          'routine_exercise_id',
                                                                          currentLoop1Item
                                                                              .id,
                                                                        )
                                                                        .order('set_number', ascending: true),
                                                                  );
                                                                  if (_model.routineSets !=
                                                                          null &&
                                                                      (_model.routineSets)!
                                                                          .isNotEmpty) {
                                                                    for (int loop2Index =
                                                                            0;
                                                                        loop2Index <
                                                                            _model.routineSets!.length;
                                                                        loop2Index++) {
                                                                      final currentLoop2Item =
                                                                          _model
                                                                              .routineSets![loop2Index];
                                                                      await ExerciseSetsTable()
                                                                          .insert({
                                                                        'workout_exercise_id': _model
                                                                            .action3
                                                                            ?.id,
                                                                        'set_number':
                                                                            currentLoop2Item.setNumber,
                                                                        'is_warmup':
                                                                            false,
                                                                        'completed':
                                                                            false,
                                                                        'weight':
                                                                            0.0,
                                                                        'reps':
                                                                            0,
                                                                      });
                                                                    }
                                                                  } else {
                                                                    await ExerciseSetsTable()
                                                                        .insert({
                                                                      'workout_exercise_id': _model
                                                                          .action3
                                                                          ?.id,
                                                                      'set_number':
                                                                          1,
                                                                      'is_warmup':
                                                                          false,
                                                                      'completed':
                                                                          false,
                                                                    });
                                                                    await ExerciseSetsTable()
                                                                        .insert({
                                                                      'workout_exercise_id': _model
                                                                          .action3
                                                                          ?.id,
                                                                      'set_number':
                                                                          2,
                                                                      'is_warmup':
                                                                          false,
                                                                      'completed':
                                                                          false,
                                                                    });
                                                                    await ExerciseSetsTable()
                                                                        .insert({
                                                                      'workout_exercise_id': _model
                                                                          .action3
                                                                          ?.id,
                                                                      'set_number':
                                                                          3,
                                                                      'is_warmup':
                                                                          false,
                                                                      'completed':
                                                                          false,
                                                                    });
                                                                  }
                                                                }

                                                                context.goNamed(
                                                                  ActiveWorkoutPageWidget
                                                                      .routeName,
                                                                  queryParameters:
                                                                      {
                                                                    'workoutId':
                                                                        serializeParam(
                                                                      _model
                                                                          .newWorkoutSession
                                                                          ?.id,
                                                                      ParamType
                                                                          .String,
                                                                    ),
                                                                  }.withoutNulls,
                                                                );

                                                                safeSetState(
                                                                    () {});
                                                              },
                                                              text:
                                                                  valueOrDefault<
                                                                      String>(
                                                                functions
                                                                    .capitalize(
                                                                        'Start Exercise'),
                                                                'Start Exercise',
                                                              ),
                                                              options:
                                                                  FFButtonOptions(
                                                                height: 44.0,
                                                                padding: EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        16.0,
                                                                        0.0,
                                                                        16.0,
                                                                        0.0),
                                                                iconPadding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0.0,
                                                                            0.0,
                                                                            0.0,
                                                                            0.0),
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryText,
                                                                textStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .titleSmall
                                                                    .override(
                                                                      font: GoogleFonts
                                                                          .urbanist(
                                                                        fontWeight: FlutterFlowTheme.of(context)
                                                                            .titleSmall
                                                                            .fontWeight,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .titleSmall
                                                                            .fontStyle,
                                                                      ),
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .primaryBackground,
                                                                      letterSpacing:
                                                                          0.0,
                                                                      fontWeight: FlutterFlowTheme.of(
                                                                              context)
                                                                          .titleSmall
                                                                          .fontWeight,
                                                                      fontStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .titleSmall
                                                                          .fontStyle,
                                                                    ),
                                                                elevation: 0.0,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            120.0),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                      }).divide(SizedBox(height: 10.0)),
                                    );
                                  },
                                ),
                              );
                            },
                          ),
                        ].divide(SizedBox(height: 20.0)),
                      ),
                    ),
                  ),
                ],
              ),
              Align(
                alignment: AlignmentDirectional(0.0, 1.0),
                child: wrapWithModel(
                  model: _model.bottomNavModel,
                  updateCallback: () => safeSetState(() {}),
                  updateOnChange: true,
                  child: Hero(
                    tag: 'line',
                    transitionOnUserGestures: true,
                    child: Material(
                      color: Colors.transparent,
                      child: BottomNavWidget(
                        page: 'exercises',
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
