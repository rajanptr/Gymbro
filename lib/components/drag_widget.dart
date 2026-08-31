import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'drag_model.dart';
export 'drag_model.dart';

class DragWidget extends StatefulWidget {
  const DragWidget({super.key});

  @override
  State<DragWidget> createState() => _DragWidgetState();
}

class _DragWidgetState extends State<DragWidget> {
  late DragModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => DragModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 20.0, 10.0),
          child: Container(
            width: 36.0,
            height: 36.0,
            decoration: BoxDecoration(),
            child: Icon(
              Icons.drag_handle_outlined,
              color: FlutterFlowTheme.of(context).secondaryText,
              size: 20.0,
            ),
          ),
        ),
      ],
    );
  }
}
