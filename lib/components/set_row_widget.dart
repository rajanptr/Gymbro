import '/backend/supabase/supabase.dart';
import '/components/rest_timer_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'set_row_model.dart';
export 'set_row_model.dart';

class SetRowWidget extends StatefulWidget {
  const SetRowWidget({
    super.key,
    required this.setId,
    this.weight,
    this.reps,
    required this.completed,
    required this.setNumber,
  });

  final String? setId;
  final double? weight;
  final int? reps;
  final bool? completed;
  final int? setNumber;

  @override
  State<SetRowWidget> createState() => _SetRowWidgetState();
}

class _SetRowWidgetState extends State<SetRowWidget> {
  late SetRowModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SetRowModel());

    _model.tfWeightTextController ??= TextEditingController();
    _model.tfWeightFocusNode ??= FocusNode();
    _model.tfWeightFocusNode!.addListener(() => safeSetState(() {}));
    _model.tfRepsTextController ??= TextEditingController();
    _model.tfRepsFocusNode ??= FocusNode();
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return FutureBuilder<List<ExerciseSetsRow>>(
      future: (_model.requestCompleter ??= Completer<List<ExerciseSetsRow>>()
            ..complete(ExerciseSetsTable().querySingleRow(
              queryFn: (q) => q.eqOrNull(
                'id',
                widget.setId,
              ),
            )))
          .future,
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
        List<ExerciseSetsRow> rowExerciseSetsRowList = snapshot.data!;

        final rowExerciseSetsRow = rowExerciseSetsRowList.isNotEmpty
            ? rowExerciseSetsRowList.first
            : null;

        return IntrinsicHeight(
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 48.0,
                decoration: BoxDecoration(),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(5.0, 0.0, 0.0, 0.0),
                  child: Text(
                    widget.setNumber == 0
                        ? 'W'
                        : formatNumber(
                            widget.setNumber,
                            formatType: FormatType.custom,
                            format: '#',
                            locale: '',
                          ),
                    textAlign: TextAlign.start,
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
                          fontStyle:
                              FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                        ),
                  ),
                ),
              ),
              Flexible(
                flex: 2,
                child: TextFormField(
                  controller: _model.tfWeightTextController,
                  focusNode: _model.tfWeightFocusNode,
                  onFieldSubmitted: (_) async {
                    await ExerciseSetsTable().update(
                      data: {
                        'weight':
                            double.tryParse(_model.tfWeightTextController.text),
                      },
                      matchingRows: (rows) => rows.eqOrNull(
                        'id',
                        widget.setId,
                      ),
                    );
                  },
                  autofocus: false,
                  enabled: true,
                  textInputAction: TextInputAction.done,
                  readOnly: rowExerciseSetsRow?.completed == true,
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
                    alignLabelWithHint: false,
                    hintText: formatNumber(
                      rowExerciseSetsRow?.weight,
                      formatType: FormatType.custom,
                      format: '##.##',
                      locale: '',
                    ),
                    hintStyle:
                        FlutterFlowTheme.of(context).labelMedium.override(
                              font: GoogleFonts.urbanist(
                                fontWeight: FlutterFlowTheme.of(context)
                                    .labelMedium
                                    .fontWeight,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .labelMedium
                                    .fontStyle,
                              ),
                              letterSpacing: 0.0,
                              fontWeight: FlutterFlowTheme.of(context)
                                  .labelMedium
                                  .fontWeight,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .labelMedium
                                  .fontStyle,
                            ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0x00000000),
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(0.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: rowExerciseSetsRow!.completed!
                            ? Color(0x00000000)
                            : FlutterFlowTheme.of(context).primaryText,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(0.0),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: FlutterFlowTheme.of(context).error,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(0.0),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: FlutterFlowTheme.of(context).error,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(0.0),
                    ),
                    filled: true,
                    fillColor: FlutterFlowTheme.of(context).primaryBackground,
                  ),
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        font: GoogleFonts.urbanist(
                          fontWeight: FlutterFlowTheme.of(context)
                              .bodyMedium
                              .fontWeight,
                          fontStyle:
                              FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                        ),
                        letterSpacing: 0.0,
                        fontWeight:
                            FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                        fontStyle:
                            FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                      ),
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  cursorColor: FlutterFlowTheme.of(context).primaryText,
                  enableInteractiveSelection: true,
                  validator: _model.tfWeightTextControllerValidator
                      .asValidator(context),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp('[0-9]'))
                  ],
                ),
              ),
              Flexible(
                flex: 2,
                child: TextFormField(
                  controller: _model.tfRepsTextController,
                  focusNode: _model.tfRepsFocusNode,
                  onFieldSubmitted: (_) async {
                    await ExerciseSetsTable().update(
                      data: {
                        'reps': int.tryParse(_model.tfRepsTextController.text),
                      },
                      matchingRows: (rows) => rows.eqOrNull(
                        'id',
                        widget.setId,
                      ),
                    );
                  },
                  autofocus: false,
                  enabled: true,
                  textInputAction: TextInputAction.done,
                  readOnly: rowExerciseSetsRow.completed == true,
                  obscureText: false,
                  decoration: InputDecoration(
                    isDense: true,
                    labelStyle:
                        FlutterFlowTheme.of(context).labelMedium.override(
                              font: GoogleFonts.urbanist(
                                fontWeight: FlutterFlowTheme.of(context)
                                    .labelMedium
                                    .fontWeight,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .labelMedium
                                    .fontStyle,
                              ),
                              letterSpacing: 0.0,
                              fontWeight: FlutterFlowTheme.of(context)
                                  .labelMedium
                                  .fontWeight,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .labelMedium
                                  .fontStyle,
                            ),
                    hintText: formatNumber(
                      rowExerciseSetsRow.reps,
                      formatType: FormatType.custom,
                      format: '##',
                      locale: '',
                    ),
                    hintStyle:
                        FlutterFlowTheme.of(context).labelMedium.override(
                              font: GoogleFonts.urbanist(
                                fontWeight: FlutterFlowTheme.of(context)
                                    .labelMedium
                                    .fontWeight,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .labelMedium
                                    .fontStyle,
                              ),
                              letterSpacing: 0.0,
                              fontWeight: FlutterFlowTheme.of(context)
                                  .labelMedium
                                  .fontWeight,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .labelMedium
                                  .fontStyle,
                            ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0x00000000),
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(0.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: rowExerciseSetsRow.completed!
                            ? Color(0x00000000)
                            : FlutterFlowTheme.of(context).primaryText,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(0.0),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: FlutterFlowTheme.of(context).error,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(0.0),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: FlutterFlowTheme.of(context).error,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(0.0),
                    ),
                    filled: true,
                    fillColor: FlutterFlowTheme.of(context).primaryBackground,
                  ),
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        font: GoogleFonts.urbanist(
                          fontWeight: FlutterFlowTheme.of(context)
                              .bodyMedium
                              .fontWeight,
                          fontStyle:
                              FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                        ),
                        letterSpacing: 0.0,
                        fontWeight:
                            FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                        fontStyle:
                            FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                      ),
                  keyboardType: TextInputType.number,
                  cursorColor: FlutterFlowTheme.of(context).primaryText,
                  enableInteractiveSelection: true,
                  validator:
                      _model.tfRepsTextControllerValidator.asValidator(context),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp('[0-9]'))
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 5.0, 0.0),
                child: InkWell(
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () async {
                    if ((_model.tfWeightTextController.text == '') ||
                        (_model.tfRepsTextController.text == '')) {
                      HapticFeedback.vibrate();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Fill the text field',
                            style: TextStyle(
                              color: FlutterFlowTheme.of(context).primaryText,
                            ),
                          ),
                          duration: Duration(milliseconds: 4000),
                          backgroundColor:
                              FlutterFlowTheme.of(context).secondary,
                        ),
                      );
                    } else {
                      HapticFeedback.selectionClick();
                      await ExerciseSetsTable().update(
                        data: {
                          'weight': double.tryParse(
                              _model.tfWeightTextController.text),
                          'reps':
                              int.tryParse(_model.tfRepsTextController.text),
                          'completed': true,
                        },
                        matchingRows: (rows) => rows.eqOrNull(
                          'id',
                          widget.setId,
                        ),
                      );
                      safeSetState(() => _model.requestCompleter = null);
                      await _model.waitForRequestCompleted();
                      FFAppState().isResting = true;
                      FFAppState().restRemaining = FFAppState().restRemaining;
                      FFAppState().isTimerPaused = false;
                      FFAppState().restStartTime = getCurrentTimestamp;
                      if (rowExerciseSetsRow.completed == false) {
                        await showModalBottomSheet(
                          isScrollControlled: true,
                          backgroundColor: Color(0xA6000000),
                          isDismissible: false,
                          enableDrag: false,
                          context: context,
                          builder: (context) {
                            return Padding(
                              padding: MediaQuery.viewInsetsOf(context),
                              child: Container(
                                height: 240.0,
                                child: RestTimerWidget(
                                  duration: FFAppState().restDuration,
                                ),
                              ),
                            );
                          },
                        ).then((value) => safeSetState(() {}));
                      }
                    }

                    safeSetState(() {});
                  },
                  child: Stack(
                    children: [
                      if (rowExerciseSetsRow.completed == false)
                        Icon(
                          Icons.radio_button_off_sharp,
                          color: FlutterFlowTheme.of(context).primaryText,
                          size: 20.0,
                        ),
                      if (rowExerciseSetsRow.completed == true)
                        Icon(
                          Icons.done,
                          color: FlutterFlowTheme.of(context).primaryText,
                          size: 20.0,
                        ),
                    ],
                  ),
                ),
              ),
            ].divide(SizedBox(width: 10.0)),
          ),
        );
      },
    );
  }
}
