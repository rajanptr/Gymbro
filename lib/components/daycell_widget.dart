import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'daycell_model.dart';
export 'daycell_model.dart';

class DaycellWidget extends StatefulWidget {
  const DaycellWidget({
    super.key,
    required this.calendarDay,
  });

  final CalendarDayStruct? calendarDay;

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
      ),
      child: Padding(
        padding: EdgeInsets.all(4.0),
        child: Container(
          width: 36.0,
          height: 36.0,
          decoration: BoxDecoration(
            color: () {
              if (widget.calendarDay?.isToday == true) {
                return FlutterFlowTheme.of(context).primaryText;
              } else if (widget.calendarDay?.isEmpty == true) {
                return Color(0x00000000);
              } else if (widget.calendarDay?.hasWorkout == true) {
                return FlutterFlowTheme.of(context).accent3;
              } else {
                return Color(0x00000000);
              }
            }(),
            shape: BoxShape.circle,
          ),
          alignment: AlignmentDirectional(0.0, 0.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                formatNumber(
                  widget.calendarDay!.dayNumber,
                  formatType: FormatType.custom,
                  format: '00',
                  locale: '',
                ),
                style: FlutterFlowTheme.of(context).bodyLarge.override(
                      font: GoogleFonts.urbanist(
                        fontWeight:
                            FlutterFlowTheme.of(context).bodyLarge.fontWeight,
                        fontStyle:
                            FlutterFlowTheme.of(context).bodyLarge.fontStyle,
                      ),
                      color: () {
                        if (widget.calendarDay?.isEmpty == true) {
                          return Color(0x00000000);
                        } else if (widget.calendarDay?.isToday == true) {
                          return FlutterFlowTheme.of(context).primaryBackground;
                        } else if (widget.calendarDay?.hasWorkout == false) {
                          return FlutterFlowTheme.of(context).secondaryText;
                        } else {
                          return FlutterFlowTheme.of(context).primaryText;
                        }
                      }(),
                      letterSpacing: 0.0,
                      fontWeight:
                          FlutterFlowTheme.of(context).bodyLarge.fontWeight,
                      fontStyle:
                          FlutterFlowTheme.of(context).bodyLarge.fontStyle,
                    ),
              ),
              if (widget.calendarDay?.hasWorkout == true)
                Container(
                  width: 15.0,
                  height: 6.0,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).primary,
                    borderRadius: BorderRadius.circular(120.0),
                    shape: BoxShape.rectangle,
                  ),
                ),
            ].divide(SizedBox(height: 2.0)),
          ),
        ),
      ),
    );
  }
}
