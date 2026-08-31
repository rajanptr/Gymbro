import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'icon_model.dart';
export 'icon_model.dart';

class IconWidget extends StatefulWidget {
  const IconWidget({
    super.key,
    required this.iconName,
    required this.iconAsset,
    required this.isSelected,
  });

  final String? iconName;
  final String? iconAsset;
  final bool? isSelected;

  @override
  State<IconWidget> createState() => _IconWidgetState();
}

class _IconWidgetState extends State<IconWidget> {
  late IconModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => IconModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: FFAppState().selectedAppIcon == widget.iconName
                  ? FlutterFlowTheme.of(context).success
                  : FlutterFlowTheme.of(context).accent3,
              borderRadius: BorderRadius.circular(22.16),
            ),
            child: Padding(
              padding: EdgeInsets.all(3.0),
              child: Container(
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).primaryText,
                  borderRadius: BorderRadius.circular(19.16),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(19.16),
                  child: Image.network(
                    widget.iconAsset!,
                    width: 200.0,
                    height: 200.0,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
