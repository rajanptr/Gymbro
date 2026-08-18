import '/auth/supabase_auth/auth_util.dart';
import '/backend/supabase/supabase.dart';
import '/components/set_water_goal_sheet_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'habit_page_model.dart';
export 'habit_page_model.dart';

class HabitPageWidget extends StatefulWidget {
  const HabitPageWidget({super.key});

  static String routeName = 'habitPage';
  static String routePath = 'habitPage';

  @override
  State<HabitPageWidget> createState() => _HabitPageWidgetState();
}

class _HabitPageWidgetState extends State<HabitPageWidget> {
  late HabitPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HabitPageModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.currenUser = await ProfilesTable().queryRows(
        queryFn: (q) => q.eqOrNull(
          'id',
          currentUserUid,
        ),
      );
      if (_model.currenUser != null && (_model.currenUser)!.isNotEmpty) {
        await showModalBottomSheet(
          isScrollControlled: true,
          backgroundColor: Color(0x98000000),
          isDismissible: false,
          enableDrag: false,
          useSafeArea: true,
          context: context,
          builder: (context) {
            return GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
                FocusManager.instance.primaryFocus?.unfocus();
              },
              child: Padding(
                padding: MediaQuery.viewInsetsOf(context),
                child: Container(
                  height: MediaQuery.sizeOf(context).height * 0.6,
                  child: SetWaterGoalSheetWidget(),
                ),
              ),
            );
          },
        ).then((value) => safeSetState(() {}));

        _model.recheck = await ProfilesTable().queryRows(
          queryFn: (q) => q.eqOrNull(
            'id',
            currentUserUid,
          ),
        );

        context.goNamed(
          HomePageWidget.routeName,
          extra: <String, dynamic>{
            '__transition_info__': TransitionInfo(
              hasTransition: true,
              transitionType: PageTransitionType.bottomToTop,
              duration: Duration(milliseconds: 300),
            ),
          },
        );
      }
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
        body: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Stack(
              alignment: AlignmentDirectional(0.0, 1.0),
              children: [
                Opacity(
                  opacity: 0.4,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(0.0),
                    child: Image.asset(
                      'assets/images/anastase-maragos-9dzWZQWZMdE-unsplash.jpg',
                      width: double.infinity,
                      height: 260.0,
                      fit: BoxFit.cover,
                      alignment: Alignment(0.0, 0.0),
                    ),
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional(0.0, 1.0),
                  child: Container(
                    width: double.infinity,
                    height: 60.0,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          FlutterFlowTheme.of(context).accent4,
                          FlutterFlowTheme.of(context).primaryBackground
                        ],
                        stops: [0.0, 1.0],
                        begin: AlignmentDirectional(0.0, -1.0),
                        end: AlignmentDirectional(0, 1.0),
                      ),
                    ),
                    alignment: AlignmentDirectional(0.0, 1.0),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 36.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(0.0),
                    child: Image.asset(
                      Theme.of(context).brightness == Brightness.dark
                          ? 'assets/images/gymBro.png'
                          : 'assets/images/gymBrologo.png',
                      width: 150.0,
                      height: 150.0,
                      fit: BoxFit.cover,
                      alignment: Alignment(0.0, 1.0),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
