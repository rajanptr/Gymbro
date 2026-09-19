import '/backend/supabase/supabase.dart';
import '/components/rest_timer_widget.dart';
import '/components/set_filter_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'dart:async';
import 'package:easy_debounce/easy_debounce.dart';
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
    required this.onSetTypeChanged,
  });

  final String? setId;
  final double? weight;
  final int? reps;
  final bool? completed;
  final int? setNumber;
  final Future Function(String type)? onSetTypeChanged;

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
              InkWell(
                splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                hoverColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () async {
                  HapticFeedback.selectionClick();
                  await showModalBottomSheet(
                    isScrollControlled: true,
                    backgroundColor: Color(0xA5000000),
                    enableDrag: false,
                    useSafeArea: true,
                    context: context,
                    builder: (context) {
                      return Padding(
                        padding: MediaQuery.viewInsetsOf(context),
                        child: Container(
                          height: 300.0,
                          child: SetFilterWidget(
                            selectedType: rowExerciseSetsRow!.setType!,
                            onTypeSelected: (type) async {
                              await ExerciseSetsTable().update(
                                data: {
                                  'set_type': type,
                                },
                                matchingRows: (rows) => rows.eqOrNull(
                                  'id',
                                  rowExerciseSetsRow.id,
                                ),
                              );
                              safeSetState(
                                  () => _model.requestCompleter = null);
                              await _model.waitForRequestCompleted();
                            },
                          ),
                        ),
                      );
                    },
                  ).then((value) => safeSetState(() {}));
                },
                child: Container(
                  width: 48.0,
                  decoration: BoxDecoration(),
                  alignment: AlignmentDirectional(-1.0, 0.0),
                  child: Container(
                    width: 32.0,
                    height: 32.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: () {
                          if (functions.getSetlabel(rowExerciseSetsRow?.setType,
                                  rowExerciseSetsRow?.setNumber) ==
                              'W') {
                            return FlutterFlowTheme.of(context).success;
                          } else if (functions.getSetlabel(
                                  rowExerciseSetsRow?.setType,
                                  rowExerciseSetsRow?.setNumber) ==
                              'D') {
                            return FlutterFlowTheme.of(context).warning;
                          } else if (functions.getSetlabel(
                                  rowExerciseSetsRow?.setType,
                                  rowExerciseSetsRow?.setNumber) ==
                              'F') {
                            return FlutterFlowTheme.of(context).primary;
                          } else {
                            return FlutterFlowTheme.of(context).alternate;
                          }
                        }(),
                        width: 0.5,
                      ),
                    ),
                    child: Align(
                      alignment: AlignmentDirectional(0.0, 0.0),
                      child: Text(
                        functions.getSetlabel(rowExerciseSetsRow?.setType,
                            rowExerciseSetsRow?.setNumber),
                        textAlign: TextAlign.start,
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              font: GoogleFonts.urbanist(
                                fontWeight: FontWeight.w600,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .fontStyle,
                              ),
                              color: () {
                                if (functions.getSetlabel(
                                        rowExerciseSetsRow?.setType,
                                        rowExerciseSetsRow?.setNumber) ==
                                    'W') {
                                  return FlutterFlowTheme.of(context).success;
                                } else if (functions.getSetlabel(
                                        rowExerciseSetsRow?.setType,
                                        rowExerciseSetsRow?.setNumber) ==
                                    'D') {
                                  return FlutterFlowTheme.of(context).warning;
                                } else if (functions.getSetlabel(
                                        rowExerciseSetsRow?.setType,
                                        rowExerciseSetsRow?.setNumber) ==
                                    'F') {
                                  return FlutterFlowTheme.of(context).primary;
                                } else {
                                  return FlutterFlowTheme.of(context)
                                      .secondaryText;
                                }
                              }(),
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.w600,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .fontStyle,
                            ),
                      ),
                    ),
                  ),
                ),
              ),
              Flexible(
                flex: 2,
                child: TextFormField(
                  controller: _model.tfWeightTextController,
                  focusNode: _model.tfWeightFocusNode,
                  onChanged: (_) => EasyDebounce.debounce(
                    '_model.tfWeightTextController',
                    Duration(milliseconds: 2000),
                    () async {
                      await ExerciseSetsTable().update(
                        data: {
                          'weight': double.tryParse(
                              _model.tfWeightTextController.text),
                        },
                        matchingRows: (rows) => rows.eqOrNull(
                          'id',
                          widget.setId,
                        ),
                      );
                    },
                  ),
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
                  onChanged: (_) => EasyDebounce.debounce(
                    '_model.tfRepsTextController',
                    Duration(milliseconds: 2000),
                    () async {
                      await ExerciseSetsTable().update(
                        data: {
                          'reps':
                              int.tryParse(_model.tfRepsTextController.text),
                        },
                        matchingRows: (rows) => rows.eqOrNull(
                          'id',
                          widget.setId,
                        ),
                      );
                    },
                  ),
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
                      HapticFeedback.mediumImpact();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Enter sets and reps before continuing.',
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
                                  color: Colors.white,
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontStyle,
                                ),
                          ),
                          duration: Duration(milliseconds: 4000),
                          backgroundColor: FlutterFlowTheme.of(context).error,
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
                          'id': widget.setId,
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
