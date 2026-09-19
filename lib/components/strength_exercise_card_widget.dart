import '/auth/supabase_auth/auth_util.dart';
import '/backend/supabase/supabase.dart';
import '/components/card_edit_widget.dart';
import '/components/set_row_widget.dart';
import '/components/specific_exercise_component_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'strength_exercise_card_model.dart';
export 'strength_exercise_card_model.dart';

class StrengthExerciseCardWidget extends StatefulWidget {
  const StrengthExerciseCardWidget({
    super.key,
    required this.workoutExerciseId,
    required this.workoutId,
    required this.exerciseId,
  });

  final String? workoutExerciseId;
  final String? workoutId;
  final String? exerciseId;

  @override
  State<StrengthExerciseCardWidget> createState() =>
      _StrengthExerciseCardWidgetState();
}

class _StrengthExerciseCardWidgetState
    extends State<StrengthExerciseCardWidget> {
  late StrengthExerciseCardModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => StrengthExerciseCardModel());

    _model.exercisenoteTextController ??= TextEditingController();
    _model.exercisenoteFocusNode ??= FocusNode();
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<WorkoutExercisesRow>>(
      future: WorkoutExercisesTable().querySingleRow(
        queryFn: (q) => q.eqOrNull(
          'id',
          widget.workoutExerciseId,
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
                color: FlutterFlowTheme.of(context).primary,
                size: 36.0,
              ),
            ),
          );
        }
        List<WorkoutExercisesRow> topCardWorkoutExercisesRowList =
            snapshot.data!;

        final topCardWorkoutExercisesRow =
            topCardWorkoutExercisesRowList.isNotEmpty
                ? topCardWorkoutExercisesRowList.first
                : null;

        return Container(
          constraints: BoxConstraints(
            maxHeight: double.infinity,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(0.0),
          ),
          child: FutureBuilder<List<ExerciseLibraryRow>>(
            future: ExerciseLibraryTable().querySingleRow(
              queryFn: (q) => q
                  .eqOrNull(
                    'id',
                    topCardWorkoutExercisesRow?.exerciseId,
                  )
                  .eqOrNull(
                    'exercise_type',
                    'strength',
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
                      color: FlutterFlowTheme.of(context).primary,
                      size: 36.0,
                    ),
                  ),
                );
              }
              List<ExerciseLibraryRow> cardContainerExerciseLibraryRowList =
                  snapshot.data!;

              final cardContainerExerciseLibraryRow =
                  cardContainerExerciseLibraryRowList.isNotEmpty
                      ? cardContainerExerciseLibraryRowList.first
                      : null;

              return Container(
                constraints: BoxConstraints(
                  maxHeight: double.infinity,
                ),
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: FutureBuilder<List<ExerciseSetsRow>>(
                  future: ExerciseSetsTable().queryRows(
                    queryFn: (q) => q
                        .eqOrNull(
                          'workout_exercise_id',
                          widget.workoutExerciseId,
                        )
                        .order('set_number', ascending: true),
                  ),
                  builder: (context, snapshot) {
                    // Customize what your widget looks like when it's loading.
                    if (!snapshot.hasData) {
                      return Center(
                        child: SizedBox(
                          width: 36.0,
                          height: 36.0,
                          child: SpinKitPulse(
                            color: FlutterFlowTheme.of(context).primary,
                            size: 36.0,
                          ),
                        ),
                      );
                    }
                    List<ExerciseSetsRow> containerExerciseSetsRowList =
                        snapshot.data!;

                    return Container(
                      decoration: BoxDecoration(),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            15.0, 0.0, 15.0, 0.0),
                        child: IntrinsicWidth(
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  InkWell(
                                    splashColor: Colors.transparent,
                                    focusColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () async {
                                      await showModalBottomSheet(
                                        isScrollControlled: true,
                                        backgroundColor: Colors.transparent,
                                        isDismissible: false,
                                        enableDrag: false,
                                        context: context,
                                        builder: (context) {
                                          return Padding(
                                            padding: MediaQuery.viewInsetsOf(
                                                context),
                                            child: Container(
                                              height: MediaQuery.sizeOf(context)
                                                      .height *
                                                  0.8,
                                              child:
                                                  SpecificExerciseComponentWidget(
                                                iD: widget.exerciseId!,
                                              ),
                                            ),
                                          );
                                        },
                                      ).then((value) => safeSetState(() {}));
                                    },
                                    child: Container(
                                      width: 44.0,
                                      height: 44.0,
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context)
                                            .accent3,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Stack(
                                        children: [
                                          if (cardContainerExerciseLibraryRow
                                                          ?.imageUrl ==
                                                      null ||
                                                  cardContainerExerciseLibraryRow
                                                          ?.imageUrl ==
                                                      ''
                                              ? true
                                              : false)
                                            Align(
                                              alignment: AlignmentDirectional(
                                                  0.0, 0.0),
                                              child: Text(
                                                (String name) {
                                                  return name
                                                              .trim()
                                                              .split(' ')
                                                              .length ==
                                                          1
                                                      ? name
                                                          .trim()
                                                          .substring(0, 2)
                                                          .toUpperCase()
                                                      : (name
                                                                  .trim()
                                                                  .split(' ')[0]
                                                                  .substring(
                                                                      0, 1) +
                                                              name
                                                                  .trim()
                                                                  .split(' ')[1]
                                                                  .substring(
                                                                      0, 1))
                                                          .toUpperCase();
                                                }(cardContainerExerciseLibraryRow!
                                                    .name),
                                                textAlign: TextAlign.center,
                                                style: FlutterFlowTheme.of(
                                                        context)
                                                    .titleMedium
                                                    .override(
                                                      font:
                                                          GoogleFonts.urbanist(
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
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .secondaryText,
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
                                              ),
                                            ),
                                          if (cardContainerExerciseLibraryRow
                                                          ?.imageUrl ==
                                                      null ||
                                                  cardContainerExerciseLibraryRow
                                                          ?.imageUrl ==
                                                      ''
                                              ? false
                                              : true)
                                            Opacity(
                                              opacity: 0.3,
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        200.0),
                                                child: Image.network(
                                                  cardContainerExerciseLibraryRow!
                                                      .imageUrl!,
                                                  width: 44.0,
                                                  height: 44.0,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                        ],
                                      ),
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
                                                cardContainerExerciseLibraryRow!
                                                    .name),
                                            'TITLE',
                                          ),
                                          maxLines: 3,
                                          style: FlutterFlowTheme.of(context)
                                              .titleMedium
                                              .override(
                                                font: GoogleFonts.urbanist(
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
                                                    FlutterFlowTheme.of(context)
                                                        .titleMedium
                                                        .fontWeight,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .titleMedium
                                                        .fontStyle,
                                              ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        FutureBuilder<
                                            List<ExerciseProgressRow>>(
                                          future: ExerciseProgressTable()
                                              .querySingleRow(
                                            queryFn: (q) => q
                                                .eqOrNull(
                                                  'user_id',
                                                  currentUserUid,
                                                )
                                                .eqOrNull(
                                                  'exercise_id',
                                                  widget.exerciseId,
                                                )
                                                .order('weight'),
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
                                            List<ExerciseProgressRow>
                                                textExerciseProgressRowList =
                                                snapshot.data!;

                                            final textExerciseProgressRow =
                                                textExerciseProgressRowList
                                                        .isNotEmpty
                                                    ? textExerciseProgressRowList
                                                        .first
                                                    : null;

                                            return Text(
                                              'PR Set: ${textExerciseProgressRow?.weight == null ? '_' : formatNumber(
                                                  textExerciseProgressRow
                                                      ?.weight,
                                                  formatType: FormatType.custom,
                                                  format: '##.## Kg ',
                                                  locale: '',
                                                )}${textExerciseProgressRow?.reps == null ? '_' : formatNumber(
                                                  textExerciseProgressRow?.reps,
                                                  formatType: FormatType.custom,
                                                  format: 'X ##',
                                                  locale: '',
                                                )}',
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .bodyMedium
                                                  .override(
                                                    font: GoogleFonts.urbanist(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMedium
                                                              .fontStyle,
                                                    ),
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .secondaryText,
                                                    letterSpacing: 0.0,
                                                    fontWeight: FontWeight.w600,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyMedium
                                                            .fontStyle,
                                                  ),
                                            );
                                          },
                                        ),
                                      ].divide(SizedBox(height: 6.0)),
                                    ),
                                  ),
                                  InkWell(
                                    splashColor: Colors.transparent,
                                    focusColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () async {
                                      HapticFeedback.lightImpact();
                                      await ExerciseSetsTable().insert({
                                        'workout_exercise_id':
                                            widget.workoutExerciseId,
                                        'completed': false,
                                        'created_at': supaSerialize<DateTime>(
                                            getCurrentTimestamp),
                                      });
                                    },
                                    child: Container(
                                      height: 44.0,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(4.0),
                                      ),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.add,
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryText,
                                            size: 16.0,
                                          ),
                                          Text(
                                            'Add Set',
                                            textAlign: TextAlign.center,
                                            style: FlutterFlowTheme.of(context)
                                                .bodySmall
                                                .override(
                                                  font: GoogleFonts.urbanist(
                                                    fontWeight:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodySmall
                                                            .fontWeight,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodySmall
                                                            .fontStyle,
                                                  ),
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondaryText,
                                                  letterSpacing: 0.0,
                                                  fontWeight:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodySmall
                                                          .fontWeight,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodySmall
                                                          .fontStyle,
                                                ),
                                          ),
                                        ].divide(SizedBox(height: 5.0)),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 36.0,
                                    child: VerticalDivider(
                                      width: 1.0,
                                      thickness: 0.5,
                                      color: FlutterFlowTheme.of(context)
                                          .alternate,
                                    ),
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
                                        backgroundColor: Colors.transparent,
                                        enableDrag: false,
                                        context: context,
                                        builder: (context) {
                                          return Padding(
                                            padding: MediaQuery.viewInsetsOf(
                                                context),
                                            child: Container(
                                              height: 300.0,
                                              child: CardEditWidget(
                                                workoutId: widget.workoutId!,
                                                setnumber:
                                                    containerExerciseSetsRowList
                                                        .map((e) => e.setNumber)
                                                        .toList(),
                                                workoutExerciseId:
                                                    widget.workoutExerciseId!,
                                              ),
                                            ),
                                          );
                                        },
                                      ).then((value) => safeSetState(() {}));
                                    },
                                    child: Container(
                                      width: 36.0,
                                      height: 36.0,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(4.0),
                                      ),
                                      child: Icon(
                                        Icons.more_vert_sharp,
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryText,
                                        size: 20.0,
                                      ),
                                    ),
                                  ),
                                ].divide(SizedBox(width: 10.0)),
                              ),
                              TextFormField(
                                controller: _model.exercisenoteTextController,
                                focusNode: _model.exercisenoteFocusNode,
                                autofocus: false,
                                enabled: true,
                                textInputAction: TextInputAction.done,
                                obscureText: false,
                                decoration: InputDecoration(
                                  isDense: true,
                                  labelStyle: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        font: GoogleFonts.urbanist(
                                          fontWeight:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .fontWeight,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .fontStyle,
                                        ),
                                        letterSpacing: 0.0,
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
                                      ),
                                  hintText: 'note..',
                                  hintStyle: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        font: GoogleFonts.urbanist(
                                          fontWeight:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .fontWeight,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .fontStyle,
                                        ),
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryText,
                                        letterSpacing: 0.0,
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
                                      ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: FlutterFlowTheme.of(context)
                                          .alternate,
                                      width: 0.5,
                                    ),
                                    borderRadius: BorderRadius.circular(0.0),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      width: 0.5,
                                    ),
                                    borderRadius: BorderRadius.circular(0.0),
                                  ),
                                  errorBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: FlutterFlowTheme.of(context).error,
                                      width: 0.5,
                                    ),
                                    borderRadius: BorderRadius.circular(0.0),
                                  ),
                                  focusedErrorBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: FlutterFlowTheme.of(context).error,
                                      width: 0.5,
                                    ),
                                    borderRadius: BorderRadius.circular(0.0),
                                  ),
                                  contentPadding:
                                      EdgeInsetsDirectional.fromSTEB(
                                          10.0, 15.0, 10.0, 15.0),
                                ),
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      font: GoogleFonts.urbanist(
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
                                      ),
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      letterSpacing: 0.0,
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                                maxLines: null,
                                maxLength: 100,
                                cursorColor:
                                    FlutterFlowTheme.of(context).primaryText,
                                enableInteractiveSelection: true,
                                validator: _model
                                    .exercisenoteTextControllerValidator
                                    .asValidator(context),
                              ),
                              Container(
                                width: MediaQuery.sizeOf(context).width * 1.0,
                                decoration: BoxDecoration(),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 48.0,
                                      decoration: BoxDecoration(),
                                      child: Text(
                                        'SETS',
                                        textAlign: TextAlign.start,
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              font: GoogleFonts.urbanist(
                                                fontWeight:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontWeight,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontStyle,
                                              ),
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryText,
                                              letterSpacing: 0.0,
                                              fontWeight:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontWeight,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontStyle,
                                            ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Text(
                                        'WEIGHTS',
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              font: GoogleFonts.urbanist(
                                                fontWeight:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontWeight,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontStyle,
                                              ),
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryText,
                                              letterSpacing: 0.0,
                                              fontWeight:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontWeight,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontStyle,
                                            ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Text(
                                        'REPS',
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              font: GoogleFonts.urbanist(
                                                fontWeight:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontWeight,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontStyle,
                                              ),
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryText,
                                              letterSpacing: 0.0,
                                              fontWeight:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontWeight,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontStyle,
                                            ),
                                      ),
                                    ),
                                    Icon(
                                      Icons.checklist_rtl,
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryText,
                                      size: 20.0,
                                    ),
                                  ].divide(SizedBox(width: 10.0)),
                                ),
                              ),
                              Builder(
                                builder: (context) {
                                  final setReps = containerExerciseSetsRowList
                                      .map((e) => e)
                                      .toList();

                                  return Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: List.generate(setReps.length,
                                        (setRepsIndex) {
                                      final setRepsItem = setReps[setRepsIndex];
                                      return Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: SetRowWidget(
                                              key: Key(
                                                  'Key4vl_${setRepsIndex}_of_${setReps.length}'),
                                              setId: setRepsItem.id!,
                                              setNumber: setRepsItem.setNumber,
                                              weight: setRepsItem.weight,
                                              reps: setRepsItem.reps,
                                              completed: setRepsItem.completed!,
                                              onSetTypeChanged: (type) async {},
                                            ),
                                          ),
                                        ],
                                      );
                                    }).divide(SizedBox(height: 10.0)),
                                  );
                                },
                              ),
                            ]
                                .divide(SizedBox(height: 20.0))
                                .addToStart(SizedBox(height: 20.0))
                                .addToEnd(SizedBox(height: 20.0)),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        );
      },
    );
  }
}
