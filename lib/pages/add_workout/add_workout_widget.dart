import '/components/bottom_nav_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
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
