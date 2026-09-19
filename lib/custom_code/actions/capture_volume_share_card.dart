// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/actions/index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';

Future<String> captureVolumeShareCard(
  BuildContext context,
) async {
  const String targetKey = 'gymbro_volume_share_card';

  // Render the existing FlutterFlow UI at high resolution.
  const double pixelRatio = 6.0;

  try {
    // Wait until the current frame is completely rendered.
    await WidgetsBinding.instance.endOfFrame;

    // ------------------------------------------------------------
    // FIND ROOT
    // ------------------------------------------------------------

    final Element? root = WidgetsBinding.instance.rootElement;

    if (root == null) {
      debugPrint(
        'GYMBRO CAPTURE: Root element is null.',
      );
      return '';
    }

    // ------------------------------------------------------------
    // FIND EXISTING VOLUME CONTAINER
    // ------------------------------------------------------------

    Element? targetElement;

    void findTarget(Element element) {
      if (targetElement != null) {
        return;
      }

      final Key? key = element.widget.key;

      if (key is ValueKey && key.value.toString() == targetKey) {
        targetElement = element;
        return;
      }

      element.visitChildElements(
        (Element child) {
          findTarget(child);
        },
      );
    }

    findTarget(root);

    if (targetElement == null) {
      debugPrint(
        'GYMBRO CAPTURE: Volume Container not found.',
      );
      return '';
    }

    debugPrint(
      'GYMBRO CAPTURE: Volume Container found.',
    );

    // ------------------------------------------------------------
    // GET TARGET RENDER OBJECT
    // ------------------------------------------------------------

    final RenderObject? renderObject = targetElement!.renderObject;

    if (renderObject == null) {
      debugPrint(
        'GYMBRO CAPTURE: RenderObject is null.',
      );
      return '';
    }

    if (!renderObject.attached) {
      debugPrint(
        'GYMBRO CAPTURE: RenderObject is not attached.',
      );
      return '';
    }

    if (renderObject is! RenderBox) {
      debugPrint(
        'GYMBRO CAPTURE: Target is not a RenderBox.',
      );
      return '';
    }

    final RenderBox targetBox = renderObject;

    final Size targetSize = targetBox.size;

    if (targetSize.width <= 0 || targetSize.height <= 0) {
      debugPrint(
        'GYMBRO CAPTURE: Invalid target size: $targetSize',
      );
      return '';
    }

    debugPrint(
      'GYMBRO CAPTURE: Target size: $targetSize',
    );

    // ------------------------------------------------------------
    // FIND THE OFFSET LAYER
    // ------------------------------------------------------------

    OffsetLayer? offsetLayer;
    RenderBox? layerOwner;

    RenderObject? current = targetBox;

    while (current != null) {
      final ContainerLayer? layer = current.debugLayer;

      if (layer is OffsetLayer && current is RenderBox) {
        offsetLayer = layer;
        layerOwner = current;
        break;
      }

      current = current.parent;
    }

    if (offsetLayer == null || layerOwner == null) {
      debugPrint(
        'GYMBRO CAPTURE: No suitable OffsetLayer found.',
      );
      return '';
    }

    debugPrint(
      'GYMBRO CAPTURE: OffsetLayer found.',
    );

    // ------------------------------------------------------------
    // CONVERT TARGET POSITION
    // ------------------------------------------------------------
    //
    // IMPORTANT:
    // Do NOT subtract offsetLayer.offset.
    //
    // Convert the target's global position into the coordinate
    // system of the RenderBox that owns the OffsetLayer.
    //

    final Offset targetGlobal = targetBox.localToGlobal(
      Offset.zero,
    );

    final Offset layerLocal = layerOwner.globalToLocal(
      targetGlobal,
    );

    debugPrint(
      'GYMBRO CAPTURE: Target global position: '
      '$targetGlobal',
    );

    debugPrint(
      'GYMBRO CAPTURE: Target layer position: '
      '$layerLocal',
    );

    // ------------------------------------------------------------
    // EXACT TARGET BOUNDS
    // ------------------------------------------------------------

    final Rect captureBounds = Rect.fromLTWH(
      layerLocal.dx,
      layerLocal.dy,
      targetSize.width,
      targetSize.height,
    );

    debugPrint(
      'GYMBRO CAPTURE: Capture bounds: '
      '$captureBounds',
    );

    // ------------------------------------------------------------
    // HIGH-RES FLUTTER RENDER
    // ------------------------------------------------------------
    //
    // This renders the EXISTING FlutterFlow Container directly.
    //
    // No Canvas recreation.
    // No image resizing.
    // No manual text.
    // No additional UI.
    //
    // 323 x 370 at 6x ≈ 1938 x 2220.
    //

    final ui.Image image = await offsetLayer.toImage(
      captureBounds,
      pixelRatio: pixelRatio,
    );

    debugPrint(
      'GYMBRO CAPTURE: Output resolution: '
      '${image.width} x ${image.height}',
    );

    // ------------------------------------------------------------
    // PNG ENCODE
    // ------------------------------------------------------------

    final ByteData? byteData = await image.toByteData(
      format: ui.ImageByteFormat.png,
    );

    image.dispose();

    if (byteData == null) {
      debugPrint(
        'GYMBRO CAPTURE: PNG conversion failed.',
      );
      return '';
    }

    final Uint8List pngBytes = byteData.buffer.asUint8List();

    debugPrint(
      'GYMBRO CAPTURE: PNG bytes: '
      '${pngBytes.length}',
    );

    // ------------------------------------------------------------
    // SAVE TEMP FILE
    // ------------------------------------------------------------

    final Directory tempDirectory = await getTemporaryDirectory();

    final String filePath =
        '${tempDirectory.path}/gymbro_volume_share_card_highres.png';

    final File file = File(filePath);

    await file.writeAsBytes(
      pngBytes,
      flush: true,
    );

    if (!await file.exists()) {
      debugPrint(
        'GYMBRO CAPTURE: PNG file was not created.',
      );
      return '';
    }

    debugPrint(
      'GYMBRO CAPTURE: FULL CARD SAVED.',
    );

    debugPrint(
      'GYMBRO CAPTURE: File: $filePath',
    );

    debugPrint(
      'GYMBRO CAPTURE: File size: '
      '${await file.length()} bytes',
    );

    return filePath;
  } catch (e, stackTrace) {
    debugPrint(
      'GYMBRO CAPTURE ERROR: $e',
    );

    debugPrint(
      '$stackTrace',
    );

    return '';
  }
}
// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the `</>` button on the right!
