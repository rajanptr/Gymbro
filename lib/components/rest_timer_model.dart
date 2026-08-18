import '/flutter_flow/flutter_flow_timer.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'rest_timer_widget.dart' show RestTimerWidget;
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class RestTimerModel extends FlutterFlowModel<RestTimerWidget> {
  ///  Local state fields for this component.

  int remaining = 0;

  bool isRunning = true;

  ///  State fields for stateful widgets in this component.

  // State field(s) for BottomTimer widget.
  final bottomTimerInitialTimeMs = 0;
  int bottomTimerMilliseconds = 0;
  String bottomTimerValue = StopWatchTimer.getDisplayTime(
    0,
    hours: false,
    milliSecond: false,
  );
  FlutterFlowTimerController bottomTimerController =
      FlutterFlowTimerController(StopWatchTimer(mode: StopWatchMode.countDown));

  AudioPlayer? soundPlayer;
  // State field(s) for Checkbox widget.
  bool? checkboxValue;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    bottomTimerController.dispose();
  }
}
