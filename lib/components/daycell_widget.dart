import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'daycell_model.dart';
export 'daycell_model.dart';

class DaycellWidget extends StatefulWidget {
  const DaycellWidget({
    super.key,
    required this.calendarDay,
    required this.isSelected,
    this.onDateSelected,
  });

  final CalendarDayStruct? calendarDay;
  final bool? isSelected;
  final Future Function()? onDateSelected;

  @override
  State<DaycellWidget> createState() => _DaycellWidgetState();
}

class _DaycellWidgetState extends State<DaycellWidget> {
  late DaycellModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => DaycellModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(200.0),
        border: Border.all(
          color: widget.isSelected!
              ? FlutterFlowTheme.of(context).primaryText
              : Color(0x00000000),
          width: widget.isSelected! ? .5 : 0.0,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(4.0),
        child: Container(
          width: 36.0,
          height: 36.0,
          decoration: BoxDecoration(
            color: () {
              if (widget.calendarDay?.status == 'workout') {
                return FlutterFlowTheme.of(context).primary;
              } else if (widget.calendarDay?.status == 'freeze') {
                return Color(0xFF55B4F2);
              } else if (widget.calendarDay?.status == 'empty') {
                return FlutterFlowTheme.of(context).secondaryBackground;
              } else if (widget.calendarDay?.status == 'outside') {
                return Color(0x00000000);
              } else {
                return FlutterFlowTheme.of(context).tertiary;
              }
            }(),
            shape: BoxShape.circle,
          ),
          alignment: AlignmentDirectional(0.0, 0.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                children: [
                  if (!(widget.calendarDay?.status == 'rest' ? false : true))
                    Align(
                      alignment: AlignmentDirectional(0.0, 0.0),
                      child: Icon(
                        Icons.bed,
                        color: FlutterFlowTheme.of(context).alternate,
                        size: 20.0,
                      ),
                    ),
                  if ((widget.calendarDay?.status == 'workout') ||
                          (widget.calendarDay?.status == 'freeze')
                      ? false
                      : true)
                    Align(
                      alignment: AlignmentDirectional(0.0, 0.0),
                      child: Text(
                        widget.calendarDay?.status == 'rest'
                            ? ''
                            : formatNumber(
                                widget.calendarDay!.dayNumber,
                                formatType: FormatType.custom,
                                format: '00',
                                locale: '',
                              ),
                        maxLines: 4,
                        style: FlutterFlowTheme.of(context).bodyLarge.override(
                              font: GoogleFonts.urbanist(
                                fontWeight: FlutterFlowTheme.of(context)
                                    .bodyLarge
                                    .fontWeight,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .bodyLarge
                                    .fontStyle,
                              ),
                              color: () {
                                if (widget.calendarDay?.status == 'workout') {
                                  return Color(0x00000000);
                                } else if (widget.calendarDay?.status ==
                                    'rest') {
                                  return FlutterFlowTheme.of(context)
                                      .secondaryText;
                                } else if (widget.calendarDay?.status ==
                                    'empty') {
                                  return FlutterFlowTheme.of(context)
                                      .primaryText;
                                } else if (widget.calendarDay?.status ==
                                    'future') {
                                  return FlutterFlowTheme.of(context)
                                      .primaryText;
                                } else if (widget.calendarDay?.status ==
                                    'outside') {
                                  return FlutterFlowTheme.of(context).alternate;
                                } else {
                                  return FlutterFlowTheme.of(context)
                                      .primaryText;
                                }
                              }(),
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
                  if (!((widget.calendarDay?.status == 'workout') ||
                          (widget.calendarDay?.status == 'freeze')
                      ? false
                      : true))
                    Align(
                      alignment: AlignmentDirectional(0.0, 0.0),
                      child: FaIcon(
                        FontAwesomeIcons.fire,
                        color: Colors.white,
                        size: 20.0,
                      ),
                    ),
                ],
              ),
            ].divide(SizedBox(height: 2.0)),
          ),
        ),
      ),
    );
  }
}
