import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'cardio_exercise_card_model.dart';
export 'cardio_exercise_card_model.dart';

class CardioExerciseCardWidget extends StatefulWidget {
  const CardioExerciseCardWidget({
    super.key,
    this.exerciseId,
  });

  final String? exerciseId;

  @override
  State<CardioExerciseCardWidget> createState() =>
      _CardioExerciseCardWidgetState();
}

class _CardioExerciseCardWidgetState extends State<CardioExerciseCardWidget> {
  late CardioExerciseCardModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CardioExerciseCardModel());

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
    return FutureBuilder<List<ExerciseLibraryRow>>(
      future: ExerciseLibraryTable().querySingleRow(
        queryFn: (q) => q.eqOrNull(
          'id',
          widget.exerciseId,
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
        List<ExerciseLibraryRow> containerExerciseLibraryRowList =
            snapshot.data!;

        final containerExerciseLibraryRow =
            containerExerciseLibraryRowList.isNotEmpty
                ? containerExerciseLibraryRowList.first
                : null;

        return Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: FlutterFlowTheme.of(context).secondaryBackground,
          ),
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(15.0, 0.0, 15.0, 0.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 44.0,
                      height: 44.0,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).primaryBackground,
                        shape: BoxShape.circle,
                      ),
                      child: Opacity(
                        opacity: 0.3,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(200.0),
                          child: Image.asset(
                            Theme.of(context).brightness == Brightness.dark
                                ? 'assets/images/image_icon.png'
                                : 'assets/images/image_icon_02.png',
                            width: 44.0,
                            height: 44.0,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            valueOrDefault<String>(
                              functions.capitalize(
                                  containerExerciseLibraryRow!.name),
                              'TITLE',
                            ),
                            maxLines: 3,
                            style: FlutterFlowTheme.of(context)
                                .titleMedium
                                .override(
                                  font: GoogleFonts.urbanist(
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .titleMedium
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .titleMedium
                                        .fontStyle,
                                  ),
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .titleMedium
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .titleMedium
                                      .fontStyle,
                                ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ].divide(SizedBox(height: 6.0)),
                      ),
                    ),
                    SizedBox(
                      height: 36.0,
                      child: VerticalDivider(
                        width: 1.0,
                        thickness: 0.5,
                        color: FlutterFlowTheme.of(context).alternate,
                      ),
                    ),
                    Container(
                      width: 36.0,
                      height: 36.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      child: Icon(
                        Icons.more_vert_sharp,
                        color: FlutterFlowTheme.of(context).secondaryText,
                        size: 20.0,
                      ),
                    ),
                  ].divide(SizedBox(width: 10.0)),
                ),
                TextFormField(
                  controller: _model.exercisenoteTextController,
                  focusNode: _model.exercisenoteFocusNode,
                  autofocus: true,
                  enabled: true,
                  textInputAction: TextInputAction.done,
                  obscureText: false,
                  decoration: InputDecoration(
                    isDense: true,
                    labelStyle: FlutterFlowTheme.of(context)
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
                          letterSpacing: 0.0,
                          fontWeight: FlutterFlowTheme.of(context)
                              .bodyMedium
                              .fontWeight,
                          fontStyle:
                              FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                        ),
                    hintText: 'note..',
                    hintStyle: FlutterFlowTheme.of(context).bodyMedium.override(
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
                          fontStyle:
                              FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                        ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: FlutterFlowTheme.of(context).alternate,
                        width: 0.5,
                      ),
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: FlutterFlowTheme.of(context).primaryText,
                        width: 0.5,
                      ),
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    errorBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: FlutterFlowTheme.of(context).error,
                        width: 0.5,
                      ),
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    focusedErrorBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: FlutterFlowTheme.of(context).error,
                        width: 0.5,
                      ),
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    contentPadding:
                        EdgeInsetsDirectional.fromSTEB(10.0, 15.0, 10.0, 15.0),
                  ),
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        font: GoogleFonts.urbanist(
                          fontWeight: FlutterFlowTheme.of(context)
                              .bodyMedium
                              .fontWeight,
                          fontStyle:
                              FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                        ),
                        color: FlutterFlowTheme.of(context).primaryText,
                        letterSpacing: 0.0,
                        fontWeight:
                            FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                        fontStyle:
                            FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                      ),
                  maxLines: null,
                  maxLength: 100,
                  cursorColor: FlutterFlowTheme.of(context).primaryText,
                  enableInteractiveSelection: true,
                  validator: _model.exercisenoteTextControllerValidator
                      .asValidator(context),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 0.0, 20.0),
                  child: Container(
                    width: double.infinity,
                    height: 300.0,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).primaryBackground,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: double.infinity,
                          height: 200.0,
                          child: custom_widgets.DurationPicker(
                            width: double.infinity,
                            height: 200.0,
                            initialMinutes: _model.durationMinutes,
                            initialSeconds: _model.durationSeconds,
                            onDurationChanged: (minutes, seconds) async {
                              _model.durationMinutes = minutes;
                              _model.durationSeconds = seconds;
                              safeSetState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Text(
                            'DURATION',
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
                                      .secondaryText,
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
                        Icon(
                          Icons.checklist_rtl,
                          color: FlutterFlowTheme.of(context).secondaryText,
                          size: 20.0,
                        ),
                      ].divide(SizedBox(width: 10.0)),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          '${formatNumber(
                            _model.durationMinutes,
                            formatType: FormatType.custom,
                            format: '00',
                            locale: '',
                          )}:${formatNumber(
                            _model.durationSeconds,
                            formatType: FormatType.custom,
                            format: '00',
                            locale: '',
                          )}',
                          style: FlutterFlowTheme.of(context)
                              .headlineSmall
                              .override(
                                font: GoogleFonts.urbanist(
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .headlineSmall
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .headlineSmall
                                      .fontStyle,
                                ),
                                letterSpacing: 0.0,
                                fontWeight: FlutterFlowTheme.of(context)
                                    .headlineSmall
                                    .fontWeight,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .headlineSmall
                                    .fontStyle,
                              ),
                        ),
                      ],
                    ),
                  ].divide(SizedBox(height: 10.0)),
                ),
              ]
                  .divide(SizedBox(height: 20.0))
                  .addToStart(SizedBox(height: 20.0))
                  .addToEnd(SizedBox(height: 20.0)),
            ),
          ),
        );
      },
    );
  }
}
