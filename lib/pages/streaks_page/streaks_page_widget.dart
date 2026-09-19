import '/auth/supabase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/schema/structs/index.dart';
import '/backend/supabase/supabase.dart';
import '/components/daycell_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'streaks_page_model.dart';
export 'streaks_page_model.dart';

class StreaksPageWidget extends StatefulWidget {
  const StreaksPageWidget({super.key});

  static String routeName = 'StreaksPage';
  static String routePath = 'streaksPage';

  @override
  State<StreaksPageWidget> createState() => _StreaksPageWidgetState();
}

class _StreaksPageWidgetState extends State<StreaksPageWidget> {
  late StreaksPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => StreaksPageModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.streakQuery = await CompletedWorkoutsTable().queryRows(
        queryFn: (q) => q
            .eqOrNull(
              'user_id',
              currentUserUid,
            )
            .order('started_at'),
      );
      _model.profileCreateQuery = await ProfilesTable().queryRows(
        queryFn: (q) => q.eqOrNull(
          'id',
          currentUserUid,
        ),
      );
      _model.calculateFreezePoints = await CalculateFreezePointsCall.call(
        authToken: currentJwtToken,
      );

      _model.restDays =
          _model.profileCreateQuery!.firstOrNull!.restDays.toList().cast<int>();
      _model.freezePoints = CalculateFreezePointsCall.availablefreezes(
        (_model.calculateFreezePoints?.jsonBody ?? ''),
      );
      _model.freezeDays = _model.profileCreateQuery!.firstOrNull!.freezeDays
          .map((e) => dateTimeFormat(
                "yyyy-MM-dd",
                e,
                locale: FFLocalizations.of(context).languageCode,
              ))
          .toList()
          .toList()
          .cast<String>();
      _model.calendarSelectedDate = functions.getTodayDate(getCurrentTimestamp);
      safeSetState(() {});
      _model.calculateStreak = await actions.calculateCurrentStreak(
        _model.streakQuery?.toList(),
        _model.freezePoints,
        _model.restDays.toList(),
        CalculateFreezePointsCall.freezedays(
          (_model.calculateFreezePoints?.jsonBody ?? ''),
        )?.map((e) => e.toString()).toList().toList(),
      );
      _model.calendarMonth = getCurrentTimestamp;
      safeSetState(() {});
      _model.currentStreak = _model.calculateStreak!;
      _model.calendarDays = functions
          .generateCurrentMonth(
              _model.streakQuery?.toList(),
              _model.freezePoints,
              _model.restDays.toList(),
              _model.calendarMonth,
              _model.profileCreateQuery?.firstOrNull?.createdAt,
              _model.freezeDays.toList())
          .toList()
          .cast<CalendarDayStruct>();
      _model.selectedCalendarStatus = functions.getCalendarDayStatus(
          _model.streakQuery?.toList(),
          _model.freezePoints,
          _model.restDays.toList(),
          getCurrentTimestamp);
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
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                width: double.infinity,
                height: 54.0,
                decoration: BoxDecoration(),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () async {
                        HapticFeedback.lightImpact();
                        context.safePop();
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
                          Icons.arrow_back,
                          color: FlutterFlowTheme.of(context).primaryText,
                          size: 20.0,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(),
                      ),
                    ),
                    Container(
                      height: 44.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(120.0),
                        border: Border.all(
                          color: Color(0xFF55B4F2),
                          width: 0.5,
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            15.0, 0.0, 15.0, 0.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            FaIcon(
                              FontAwesomeIcons.fire,
                              color: Color(0xFF55B4F2),
                              size: 20.0,
                            ),
                            Text(
                              valueOrDefault<String>(
                                formatNumber(
                                  _model.freezePoints,
                                  formatType: FormatType.custom,
                                  format: '00',
                                  locale: '',
                                ),
                                '00',
                              ),
                              style: FlutterFlowTheme.of(context)
                                  .titleLarge
                                  .override(
                                    font: GoogleFonts.urbanist(
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .titleLarge
                                          .fontStyle,
                                    ),
                                    color: FlutterFlowTheme.of(context)
                                        .primaryText,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .titleLarge
                                        .fontStyle,
                                  ),
                            ),
                          ].divide(SizedBox(width: 10.0)),
                        ),
                      ),
                    ),
                  ]
                      .addToStart(SizedBox(width: 15.0))
                      .addToEnd(SizedBox(width: 15.0)),
                ),
              ),
              Expanded(
                child: Align(
                  alignment: AlignmentDirectional(0.0, 1.0),
                  child: Stack(
                    children: [
                      SingleChildScrollView(
                        controller: _model.columnController,
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  15.0, 0.0, 15.0, 0.0),
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(500.0),
                                    topRight: Radius.circular(500.0),
                                  ),
                                ),
                                child: Stack(
                                  alignment: AlignmentDirectional(0.0, 1.0),
                                  children: [
                                    Stack(
                                      alignment: AlignmentDirectional(0.0, 1.0),
                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 0.0, 0.0, 12.0),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryBackground,
                                              borderRadius:
                                                  BorderRadius.circular(120.0),
                                              border: Border.all(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .alternate,
                                              ),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      24.0, 12.0, 24.0, 12.0),
                                              child: Text(
                                                valueOrDefault<String>(
                                                  formatNumber(
                                                    _model.currentStreak,
                                                    formatType:
                                                        FormatType.custom,
                                                    format: '00',
                                                    locale: '',
                                                  ),
                                                  '00',
                                                ),
                                                style: FlutterFlowTheme.of(
                                                        context)
                                                    .displaySmall
                                                    .override(
                                                      font:
                                                          GoogleFonts.urbanist(
                                                        fontWeight:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .displaySmall
                                                                .fontWeight,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .displaySmall
                                                                .fontStyle,
                                                      ),
                                                      letterSpacing: 0.0,
                                                      fontWeight:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .displaySmall
                                                              .fontWeight,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .displaySmall
                                                              .fontStyle,
                                                    ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            color: FlutterFlowTheme.of(context)
                                                .primaryBackground,
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.all(6.0),
                                            child: Text(
                                              'DAY STREAK',
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .labelLarge
                                                  .override(
                                                    font: GoogleFonts.urbanist(
                                                      fontWeight:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .labelLarge
                                                              .fontWeight,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .labelLarge
                                                              .fontStyle,
                                                    ),
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primaryText,
                                                    letterSpacing: 0.0,
                                                    fontWeight:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .labelLarge
                                                            .fontWeight,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .labelLarge
                                                            .fontStyle,
                                                  ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0.0, 0.0, 0.0, 40.0),
                                      child: Lottie.asset(
                                        'assets/jsons/6rTPNgPEcH.json',
                                        width: 100.0,
                                        height: 100.0,
                                        fit: BoxFit.contain,
                                        animate: true,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 36.0, 0.0, 0.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        15.0, 0.0, 15.0, 0.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        InkWell(
                                          splashColor: Colors.transparent,
                                          focusColor: Colors.transparent,
                                          hoverColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
                                          onTap: () async {
                                            if (functions.isFirstCalendarMonth(
                                                _model.calendarMonth,
                                                _model.profileCreateQuery
                                                    ?.firstOrNull?.createdAt)) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  content: Text(
                                                    'No history exists before your account was created.',
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
                                                              .primaryBackground,
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
                                                  duration: Duration(
                                                      milliseconds: 4000),
                                                  backgroundColor:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .primaryText,
                                                ),
                                              );
                                            } else {
                                              HapticFeedback.selectionClick();
                                              _model.calendarMonth =
                                                  functions.changeCalendarMonth(
                                                      _model.calendarMonth,
                                                      -1,
                                                      _model
                                                          .profileCreateQuery
                                                          ?.firstOrNull
                                                          ?.createdAt);
                                              _model.calendarDays = functions
                                                  .generateCurrentMonth(
                                                      _model.streakQuery
                                                          ?.toList(),
                                                      _model.freezePoints,
                                                      _model.restDays.toList(),
                                                      _model.calendarMonth,
                                                      _model
                                                          .profileCreateQuery
                                                          ?.firstOrNull
                                                          ?.createdAt,
                                                      _model.freezeDays
                                                          .toList())
                                                  .toList()
                                                  .cast<CalendarDayStruct>();
                                              safeSetState(() {});
                                            }
                                          },
                                          child: Container(
                                            width: 32.0,
                                            height: 32.0,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                            ),
                                            child: Icon(
                                              Icons.keyboard_arrow_left,
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                              size: 16.0,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          valueOrDefault<String>(
                                            dateTimeFormat(
                                              "MMMM yyyy",
                                              _model.calendarMonth,
                                              locale:
                                                  FFLocalizations.of(context)
                                                      .languageCode,
                                            ),
                                            'Month',
                                          ),
                                          style: FlutterFlowTheme.of(context)
                                              .titleLarge
                                              .override(
                                                font: GoogleFonts.urbanist(
                                                  fontWeight:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .titleLarge
                                                          .fontWeight,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .titleLarge
                                                          .fontStyle,
                                                ),
                                                letterSpacing: 0.0,
                                                fontWeight:
                                                    FlutterFlowTheme.of(context)
                                                        .titleLarge
                                                        .fontWeight,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .titleLarge
                                                        .fontStyle,
                                              ),
                                        ),
                                        InkWell(
                                          splashColor: Colors.transparent,
                                          focusColor: Colors.transparent,
                                          hoverColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
                                          onTap: () async {
                                            HapticFeedback.selectionClick();
                                            _model.calendarMonth =
                                                functions.changeCalendarMonth(
                                                    _model.calendarMonth,
                                                    1,
                                                    _model
                                                        .profileCreateQuery
                                                        ?.firstOrNull
                                                        ?.createdAt);
                                            _model.calendarDays = functions
                                                .generateCurrentMonth(
                                                    _model.streakQuery
                                                        ?.toList(),
                                                    _model.freezePoints,
                                                    _model.restDays.toList(),
                                                    _model.calendarMonth,
                                                    _model
                                                        .profileCreateQuery
                                                        ?.firstOrNull
                                                        ?.createdAt,
                                                    _model.freezeDays.toList())
                                                .toList()
                                                .cast<CalendarDayStruct>();
                                            safeSetState(() {});
                                          },
                                          child: Container(
                                            width: 32.0,
                                            height: 32.0,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                            ),
                                            child: Icon(
                                              Icons.keyboard_arrow_right,
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                              size: 16.0,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        15.0, 15.0, 15.0, 0.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Container(
                                            decoration: BoxDecoration(),
                                            child: Text(
                                              'Mo',
                                              textAlign: TextAlign.center,
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
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .secondaryText,
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
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
                                            decoration: BoxDecoration(),
                                            child: Text(
                                              'Tu',
                                              textAlign: TextAlign.center,
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
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .secondaryText,
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
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
                                            decoration: BoxDecoration(),
                                            child: Text(
                                              'We',
                                              textAlign: TextAlign.center,
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
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .secondaryText,
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
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
                                            decoration: BoxDecoration(),
                                            child: Text(
                                              'Th',
                                              textAlign: TextAlign.center,
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
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .secondaryText,
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
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
                                            decoration: BoxDecoration(),
                                            child: Text(
                                              'Fr',
                                              textAlign: TextAlign.center,
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
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .secondaryText,
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
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
                                            decoration: BoxDecoration(),
                                            child: Text(
                                              'Sa',
                                              textAlign: TextAlign.center,
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
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .secondaryText,
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
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
                                            decoration: BoxDecoration(),
                                            child: Text(
                                              'Su',
                                              textAlign: TextAlign.center,
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
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .secondaryText,
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
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        15.0, 15.0, 15.0, 0.0),
                                    child: Container(
                                      width: double.infinity,
                                      height: 330.0,
                                      decoration: BoxDecoration(),
                                      child: Builder(
                                        builder: (context) {
                                          final calenderDates = _model
                                              .calendarDays
                                              .map((e) => e)
                                              .toList();

                                          return GridView.builder(
                                            padding: EdgeInsets.zero,
                                            gridDelegate:
                                                SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 7,
                                              crossAxisSpacing: 5.0,
                                              mainAxisSpacing: 5.0,
                                              childAspectRatio: 1.0,
                                            ),
                                            primary: false,
                                            shrinkWrap: true,
                                            scrollDirection: Axis.vertical,
                                            itemCount: calenderDates.length,
                                            itemBuilder:
                                                (context, calenderDatesIndex) {
                                              final calenderDatesItem =
                                                  calenderDates[
                                                      calenderDatesIndex];
                                              return InkWell(
                                                splashColor: Colors.transparent,
                                                focusColor: Colors.transparent,
                                                hoverColor: Colors.transparent,
                                                highlightColor:
                                                    Colors.transparent,
                                                onTap: () async {
                                                  _model.calendarSelectedDate =
                                                      calenderDatesItem.date;
                                                  _model.selectedCalendarStatus =
                                                      calenderDatesItem.status;
                                                  safeSetState(() {});
                                                },
                                                child: DaycellWidget(
                                                  key: Key(
                                                      'Keyw5l_${calenderDatesIndex}_of_${calenderDates.length}'),
                                                  calendarDay:
                                                      CalendarDayStruct(
                                                    dayNumber: calenderDatesItem
                                                        .dayNumber,
                                                    isCurrentMonth: false,
                                                    isToday: calenderDatesItem
                                                        .isToday,
                                                    date:
                                                        calenderDatesItem.date,
                                                    status: calenderDatesItem
                                                        .status,
                                                  ),
                                                  isSelected: !(_model
                                                              .calendarSelectedDate ==
                                                          calenderDatesItem.date
                                                      ? false
                                                      : true),
                                                  onDateSelected: () async {},
                                                ),
                                              );
                                            },
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ].addToEnd(SizedBox(height: 120.0)),
                        ),
                      ),
                      if (_model.selectedCalendarStatus == 'empty')
                        Align(
                          alignment: AlignmentDirectional(0.0, 1.0),
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  FlutterFlowTheme.of(context).accent4,
                                  FlutterFlowTheme.of(context)
                                      .primaryBackground,
                                  FlutterFlowTheme.of(context).primaryBackground
                                ],
                                stops: [0.0, 0.6, 1.0],
                                begin: AlignmentDirectional(0.0, -1.0),
                                end: AlignmentDirectional(0, 1.0),
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  15.0, 36.0, 15.0, 20.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Flexible(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Restore ${dateTimeFormat(
                                            "MMM dd",
                                            _model.calendarSelectedDate,
                                            locale: FFLocalizations.of(context)
                                                .languageCode,
                                          )}?',
                                          style: FlutterFlowTheme.of(context)
                                              .titleLarge
                                              .override(
                                                font: GoogleFonts.urbanist(
                                                  fontWeight:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .titleLarge
                                                          .fontWeight,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .titleLarge
                                                          .fontStyle,
                                                ),
                                                letterSpacing: 0.0,
                                                fontWeight:
                                                    FlutterFlowTheme.of(context)
                                                        .titleLarge
                                                        .fontWeight,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .titleLarge
                                                        .fontStyle,
                                              ),
                                        ),
                                        Text(
                                          'Use 1 Freeze Point to restore your missed day.',
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
                                                    FlutterFlowTheme.of(context)
                                                        .bodyLarge
                                                        .fontWeight,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyLarge
                                                        .fontStyle,
                                              ),
                                        ),
                                      ].divide(SizedBox(height: 5.0)),
                                    ),
                                  ),
                                  FFButtonWidget(
                                    onPressed: (_model.freezePoints == 0)
                                        ? null
                                        : () async {
                                            if (_model.freezePoints == 0) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  content: Text(
                                                    'You don\'t have Freeze points left!',
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
                                                          color: Colors.white,
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
                                                  duration: Duration(
                                                      milliseconds: 4000),
                                                  backgroundColor:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .error,
                                                ),
                                              );
                                            } else {
                                              if (functions.canFreezeToday(
                                                  _model.profileCreateQuery
                                                      ?.firstOrNull?.freezeDays
                                                      .toList(),
                                                  _model.calendarSelectedDate,
                                                  _model
                                                      .selectedCalendarStatus)) {
                                                await ProfilesTable().update(
                                                  data: {
                                                    'freeze_days': supaSerializeList<
                                                            DateTime>(
                                                        functions.addFreezeDay(
                                                            _model
                                                                .profileCreateQuery
                                                                ?.firstOrNull
                                                                ?.freezeDays
                                                                .toList(),
                                                            _model
                                                                .calendarSelectedDate)),
                                                  },
                                                  matchingRows: (rows) =>
                                                      rows.eqOrNull(
                                                    'id',
                                                    currentUserUid,
                                                  ),
                                                );
                                                _model.addToFreezeDays(
                                                    dateTimeFormat(
                                                  "yyyy-MM-dd",
                                                  _model.calendarSelectedDate,
                                                  locale: FFLocalizations.of(
                                                          context)
                                                      .languageCode,
                                                ));
                                                _model.calendarDays = functions
                                                    .generateCurrentMonth(
                                                        _model.streakQuery
                                                            ?.toList(),
                                                        _model.freezePoints,
                                                        _model.restDays
                                                            .toList(),
                                                        getCurrentTimestamp,
                                                        _model
                                                            .profileCreateQuery
                                                            ?.firstOrNull
                                                            ?.createdAt,
                                                        _model.freezeDays
                                                            .toList())
                                                    .toList()
                                                    .cast<CalendarDayStruct>();
                                                safeSetState(() {});
                                                _model.recalculatePoints =
                                                    await CalculateFreezePointsCall
                                                        .call(
                                                  authToken: currentUserUid,
                                                );

                                                _model.freezePoints =
                                                    valueOrDefault<int>(
                                                  CalculateFreezePointsCall
                                                      .availablefreezes(
                                                    (_model.recalculatePoints
                                                            ?.jsonBody ??
                                                        ''),
                                                  ),
                                                  0,
                                                );
                                                safeSetState(() {});
                                                _model.recalculateStreak =
                                                    await actions
                                                        .calculateCurrentStreak(
                                                  _model.streakQuery?.toList(),
                                                  CalculateFreezePointsCall
                                                      .availablefreezes(
                                                    (_model.calculateFreezePoints
                                                            ?.jsonBody ??
                                                        ''),
                                                  ),
                                                  _model.restDays.toList(),
                                                  _model.freezeDays.toList(),
                                                );
                                                _model.currentStreak =
                                                    valueOrDefault<int>(
                                                  _model.recalculateStreak,
                                                  00,
                                                );
                                                _model.calendarSelectedDate =
                                                    functions.getTodayDate(
                                                        getCurrentTimestamp);
                                                _model.selectedCalendarStatus =
                                                    functions
                                                        .getCalendarDayStatus(
                                                            _model.streakQuery
                                                                ?.toList(),
                                                            _model.freezePoints,
                                                            _model.restDays
                                                                .toList(),
                                                            getCurrentTimestamp);
                                                safeSetState(() {});
                                              } else {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  SnackBar(
                                                    content: Text(
                                                      'You\'ve already used a freeze day for today.',
                                                      style: TextStyle(
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primaryText,
                                                      ),
                                                    ),
                                                    duration: Duration(
                                                        milliseconds: 4000),
                                                    backgroundColor:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .secondary,
                                                  ),
                                                );
                                              }
                                            }

                                            safeSetState(() {});
                                          },
                                    text: 'RESTORE',
                                    icon: FaIcon(
                                      FontAwesomeIcons.fire,
                                      size: 15.0,
                                    ),
                                    options: FFButtonOptions(
                                      height: 56.0,
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          20.0, 0.0, 20.0, 0.0),
                                      iconAlignment: IconAlignment.start,
                                      iconPadding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              0.0, 0.0, 0.0, 0.0),
                                      iconColor: Color(0xFF55B4F2),
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      textStyle: FlutterFlowTheme.of(context)
                                          .titleSmall
                                          .override(
                                            font: GoogleFonts.urbanist(
                                              fontWeight: FontWeight.w600,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .titleSmall
                                                      .fontStyle,
                                            ),
                                            color: Color(0xFF55B4F2),
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w600,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .titleSmall
                                                    .fontStyle,
                                          ),
                                      elevation: 0.0,
                                      borderRadius:
                                          BorderRadius.circular(120.0),
                                      disabledColor:
                                          FlutterFlowTheme.of(context)
                                              .secondaryBackground,
                                      disabledTextColor:
                                          FlutterFlowTheme.of(context)
                                              .alternate,
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
