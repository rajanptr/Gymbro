import '/auth/supabase_auth/auth_util.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'create_custom_exercise_model.dart';
export 'create_custom_exercise_model.dart';

class CreateCustomExerciseWidget extends StatefulWidget {
  const CreateCustomExerciseWidget({
    super.key,
    this.name,
    this.muscleprimary,
    this.equipment,
    this.id,
  });

  final String? name;
  final String? muscleprimary;
  final String? equipment;
  final String? id;

  @override
  State<CreateCustomExerciseWidget> createState() =>
      _CreateCustomExerciseWidgetState();
}

class _CreateCustomExerciseWidgetState
    extends State<CreateCustomExerciseWidget> {
  late CreateCustomExerciseModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CreateCustomExerciseModel());

    _model.nameTextController ??= TextEditingController(
        text: widget.name != null && widget.name != '' ? widget.name : '');
    _model.nameFocusNode ??= FocusNode();
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
            padding: EdgeInsetsDirectional.fromSTEB(15.0, 0.0, 15.0, 0.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Exercise Name',
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
                ),
                Container(
                  width: double.infinity,
                  child: TextFormField(
                    controller: _model.nameTextController,
                    focusNode: _model.nameFocusNode,
                    autofocus: false,
                    enabled: true,
                    obscureText: false,
                    decoration: InputDecoration(
                      isDense: true,
                      labelStyle:
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
                      hintText: 'Name',
                      hintStyle: FlutterFlowTheme.of(context)
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
                            color: FlutterFlowTheme.of(context).secondaryText,
                            letterSpacing: 0.0,
                            fontWeight: FlutterFlowTheme.of(context)
                                .bodyLarge
                                .fontWeight,
                            fontStyle: FlutterFlowTheme.of(context)
                                .bodyLarge
                                .fontStyle,
                          ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: FlutterFlowTheme.of(context).alternate,
                          width: 0.5,
                        ),
                        borderRadius: BorderRadius.circular(120.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: FlutterFlowTheme.of(context).primaryText,
                          width: 0.5,
                        ),
                        borderRadius: BorderRadius.circular(120.0),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: FlutterFlowTheme.of(context).error,
                          width: 0.5,
                        ),
                        borderRadius: BorderRadius.circular(120.0),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: FlutterFlowTheme.of(context).error,
                          width: 0.5,
                        ),
                        borderRadius: BorderRadius.circular(120.0),
                      ),
                      filled: true,
                      fillColor:
                          FlutterFlowTheme.of(context).secondaryBackground,
                      contentPadding: EdgeInsets.all(20.0),
                    ),
                    style: FlutterFlowTheme.of(context).bodyLarge.override(
                          font: GoogleFonts.urbanist(
                            fontWeight: FlutterFlowTheme.of(context)
                                .bodyLarge
                                .fontWeight,
                            fontStyle: FlutterFlowTheme.of(context)
                                .bodyLarge
                                .fontStyle,
                          ),
                          letterSpacing: 0.0,
                          fontWeight:
                              FlutterFlowTheme.of(context).bodyLarge.fontWeight,
                          fontStyle:
                              FlutterFlowTheme.of(context).bodyLarge.fontStyle,
                        ),
                    cursorColor: FlutterFlowTheme.of(context).primaryText,
                    enableInteractiveSelection: true,
                    validator:
                        _model.nameTextControllerValidator.asValidator(context),
                  ),
                ),
                Text(
                  'Primary Muscle',
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
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(120.0),
                    border: Border.all(
                      color: FlutterFlowTheme.of(context).alternate,
                      width: 0.4,
                    ),
                  ),
                  child: FlutterFlowDropDown<String>(
                    controller: _model.pMuscleValueController ??=
                        FormFieldController<String>(
                      _model.pMuscleValue ??=
                          widget.name != null && widget.name != ''
                              ? widget.muscleprimary
                              : '',
                    ),
                    options: [
                      'Chest',
                      'Back',
                      'Shoulders',
                      'Biceps',
                      'Triceps',
                      'Quads',
                      'Hamstrings',
                      'Glutes',
                      'Calves',
                      'Abs'
                    ],
                    onChanged: (val) async {
                      safeSetState(() => _model.pMuscleValue = val);
                      safeSetState(() {
                        _model.pMuscleValueController?.value =
                            _model.pMuscleValue!;
                        _model.pMuscleValue = _model.pMuscleValue!;
                      });
                    },
                    width: double.infinity,
                    height: 44.0,
                    textStyle: FlutterFlowTheme.of(context).bodyLarge.override(
                          font: GoogleFonts.urbanist(
                            fontWeight: FlutterFlowTheme.of(context)
                                .bodyLarge
                                .fontWeight,
                            fontStyle: FlutterFlowTheme.of(context)
                                .bodyLarge
                                .fontStyle,
                          ),
                          letterSpacing: 0.0,
                          fontWeight:
                              FlutterFlowTheme.of(context).bodyLarge.fontWeight,
                          fontStyle:
                              FlutterFlowTheme.of(context).bodyLarge.fontStyle,
                        ),
                    hintText: 'Select Muscle...',
                    icon: Icon(
                      Icons.expand_more,
                      color: FlutterFlowTheme.of(context).secondaryText,
                      size: 24.0,
                    ),
                    fillColor: FlutterFlowTheme.of(context).secondaryBackground,
                    elevation: 2.0,
                    borderColor: Colors.transparent,
                    borderWidth: 0.0,
                    borderRadius: 120.0,
                    margin:
                        EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 0.0),
                    hidesUnderline: true,
                    isOverButton: false,
                    isSearchable: false,
                    isMultiSelect: false,
                  ),
                ),
                Text(
                  'Equipment',
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
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(120.0),
                    border: Border.all(
                      color: FlutterFlowTheme.of(context).alternate,
                      width: 0.4,
                    ),
                  ),
                  child: FlutterFlowDropDown<String>(
                    controller: _model.equipmentValueController ??=
                        FormFieldController<String>(
                      _model.equipmentValue ??=
                          widget.name != null && widget.name != ''
                              ? widget.equipment
                              : 'None',
                    ),
                    options: [
                      'None',
                      'Barbell',
                      'Dumbbell',
                      'Cable',
                      'Machine',
                      'Bodyweight',
                      'Resistance Band'
                    ],
                    onChanged: (val) async {
                      safeSetState(() => _model.equipmentValue = val);
                      safeSetState(() {
                        _model.equipmentValueController?.value =
                            _model.equipmentValue!;
                        _model.equipmentValue = _model.equipmentValue!;
                      });
                    },
                    width: double.infinity,
                    height: 44.0,
                    textStyle: FlutterFlowTheme.of(context).bodyLarge.override(
                          font: GoogleFonts.urbanist(
                            fontWeight: FlutterFlowTheme.of(context)
                                .bodyLarge
                                .fontWeight,
                            fontStyle: FlutterFlowTheme.of(context)
                                .bodyLarge
                                .fontStyle,
                          ),
                          letterSpacing: 0.0,
                          fontWeight:
                              FlutterFlowTheme.of(context).bodyLarge.fontWeight,
                          fontStyle:
                              FlutterFlowTheme.of(context).bodyLarge.fontStyle,
                        ),
                    hintText: 'Select Equipment...',
                    icon: Icon(
                      Icons.expand_more,
                      color: FlutterFlowTheme.of(context).secondaryText,
                      size: 24.0,
                    ),
                    fillColor: FlutterFlowTheme.of(context).secondaryBackground,
                    elevation: 2.0,
                    borderColor: Colors.transparent,
                    borderWidth: 0.0,
                    borderRadius: 120.0,
                    margin:
                        EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 0.0),
                    hidesUnderline: true,
                    isOverButton: false,
                    isSearchable: false,
                    isMultiSelect: false,
                  ),
                ),
              ]
                  .divide(SizedBox(height: 10.0))
                  .addToStart(SizedBox(height: 20.0)),
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(15.0, 36.0, 15.0, 20.0),
            child: FFButtonWidget(
              onPressed: ((_model.nameTextController.text == '') ||
                      (_model.pMuscleValue == null ||
                          _model.pMuscleValue == ''))
                  ? null
                  : () async {
                      HapticFeedback.lightImpact();
                      if (widget.id == null || widget.id == '') {
                        _model.createExercisenoiD =
                            await ExerciseLibraryTable().upsert({
                          'name': _model.nameTextController.text,
                          'muscle_group': _model.pMuscleValue,
                          'equipment': _model.equipmentValue,
                          'is_custom': true,
                          'created_by': currentUserUid,
                          'created_at':
                              supaSerialize<DateTime>(getCurrentTimestamp),
                          'primary_muscle': _model.pMuscleValue,
                          'exercise_type': 'strength',
                          'tracking_mode': 'sets',
                        }, onConflict: 'id');
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Exercise created successfully',
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
                                        .primaryBackground,
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
                            backgroundColor:
                                FlutterFlowTheme.of(context).primaryText,
                          ),
                        );
                        Navigator.pop(context);
                      } else {
                        _model.createExercise =
                            await ExerciseLibraryTable().upsert({
                          'name': _model.nameTextController.text,
                          'muscle_group': _model.pMuscleValue,
                          'equipment': _model.equipmentValue,
                          'is_custom': true,
                          'created_by': currentUserUid,
                          'created_at':
                              supaSerialize<DateTime>(getCurrentTimestamp),
                          'primary_muscle': _model.pMuscleValue,
                          'exercise_type': 'strength',
                          'tracking_mode': 'sets',
                          'id': widget.id,
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Exercise edited successfully',
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
                                        .primaryBackground,
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
                            backgroundColor:
                                FlutterFlowTheme.of(context).primaryText,
                          ),
                        );
                        Navigator.pop(context);
                      }

                      safeSetState(() {});
                    },
              text: 'CREATE EXERCISE',
              options: FFButtonOptions(
                width: double.infinity,
                height: 44.0,
                padding: EdgeInsets.all(0.0),
                iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                color: FlutterFlowTheme.of(context).primaryText,
                textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                      font: GoogleFonts.urbanist(
                        fontWeight:
                            FlutterFlowTheme.of(context).titleSmall.fontWeight,
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
                disabledColor: FlutterFlowTheme.of(context).alternate,
                disabledTextColor: FlutterFlowTheme.of(context).secondaryText,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
