import 'dart:math' as math;

import 'package:flutter/material.dart';

/// The line style of a [FlutterFlowStyledBorder].
enum FlutterFlowDashStyle { solid, dashed, dotted, dashDotted }

/// Geometry of one border side: its straight segment, the corner arcs at
/// either end (shared with the adjacent sides), the angle at which its
/// lead-out corner arc begins, and its outward normal.
typedef _SideGeometry = ({
  bool visible,
  Offset lineStart,
  Offset lineEnd,
  Rect startCorner,
  Rect endCorner,
  double baseAngle,
  Offset outwardNormal,
});

/// A [Border] that draws its sides as a solid stroke, dashes, dots, or
/// alternating dash-dots.
///
/// Also used for solid partial-side borders with a border radius: Flutter's
/// native non-uniform border painting (drawDRRect) can anti-alias the
/// coincident corner arcs of hidden sides, leaking faint slivers of border
/// color around those corners (depends on device pixel ratio and rendering
/// backend; does not reproduce at 1x headless). Solid partial borders are
/// rendered as one filled path per run of connected sides, tapering to a
/// point over the terminal corner arcs like the native ring fill.
///
/// Supports a configurable dash length, gap, and per-side visibility. Plugs
/// into [BoxDecoration.border] like a regular [Border].
class FlutterFlowStyledBorder extends Border {
  const FlutterFlowStyledBorder({
    required BorderSide side,
    this.style = FlutterFlowDashStyle.dashed,
    this.dashLength = 6.0,
    this.dashGap = 4.0,
    bool showTop = true,
    bool showRight = true,
    bool showBottom = true,
    bool showLeft = true,
  }) : super(
          top: showTop ? side : BorderSide.none,
          right: showRight ? side : BorderSide.none,
          bottom: showBottom ? side : BorderSide.none,
          left: showLeft ? side : BorderSide.none,
        );

  /// The line style: solid, dashed, dotted, or dash-dotted.
  final FlutterFlowDashStyle style;

  /// The length of each dash (unused for [FlutterFlowDashStyle.dotted]).
  final double dashLength;

  /// The gap between consecutive dashes/dots.
  final double dashGap;

  BorderSide get _side => [top, right, bottom, left]
      .firstWhere((s) => s != BorderSide.none, orElse: () => BorderSide.none);

  bool get _allSidesVisible =>
      top != BorderSide.none &&
      right != BorderSide.none &&
      bottom != BorderSide.none &&
      left != BorderSide.none;

  @override
  void paint(
    Canvas canvas,
    Rect rect, {
    TextDirection? textDirection,
    BoxShape shape = BoxShape.rectangle,
    BorderRadius? borderRadius,
  }) {
    var side = _side;
    if (side == BorderSide.none || side.width <= 0) {
      return;
    }
    // Widths beyond half the shortest dimension would collapse the
    // centerline geometry (hidden sides still shrink it); clamp so extreme
    // values degrade gracefully.
    if (side.width > rect.shortestSide / 2) {
      side = side.copyWith(width: rect.shortestSide / 2);
    }
    if (style == FlutterFlowDashStyle.solid) {
      if (shape == BoxShape.circle || _allSidesVisible) {
        canvas.drawPath(
          _borderPath(rect, shape, borderRadius, side.width),
          Paint()
            ..color = side.color
            ..strokeWidth = side.width
            ..style = PaintingStyle.stroke,
        );
      } else {
        _paintSolidSides(canvas, rect, borderRadius, side);
      }
      return;
    }
    final path = _borderPath(rect, shape, borderRadius, side.width);
    _drawStyledPath(canvas, path, side);
  }

  /// The RRect along the middle of the border stroke.
  RRect _centerlineRRect(
    Rect rect,
    BorderRadius? borderRadius,
    double strokeWidth,
  ) {
    final radius = borderRadius ?? BorderRadius.zero;
    // scaleRadii normalizes oversized corner radii to fit the rect (as the
    // engine does when painting a full RRect); without it, partial-side
    // corner arcs are built from the raw radii and can extend far outside
    // small containers.
    return radius.toRRect(rect).deflate(strokeWidth / 2).scaleRadii();
  }

  /// Geometry of the four sides of [rrect] in cyclic order (top, right,
  /// bottom, left).
  List<_SideGeometry> _sides(RRect rrect) {
    Rect cornerRect(Offset center, Radius radius) => Rect.fromCenter(
          center: center,
          width: radius.x * 2,
          height: radius.y * 2,
        );

    final tl = cornerRect(
      Offset(rrect.left + rrect.tlRadiusX, rrect.top + rrect.tlRadiusY),
      rrect.tlRadius,
    );
    final tr = cornerRect(
      Offset(rrect.right - rrect.trRadiusX, rrect.top + rrect.trRadiusY),
      rrect.trRadius,
    );
    final br = cornerRect(
      Offset(rrect.right - rrect.brRadiusX, rrect.bottom - rrect.brRadiusY),
      rrect.brRadius,
    );
    final bl = cornerRect(
      Offset(rrect.left + rrect.blRadiusX, rrect.bottom - rrect.blRadiusY),
      rrect.blRadius,
    );

    return [
      (
        visible: top != BorderSide.none,
        lineStart: Offset(rrect.left + rrect.tlRadiusX, rrect.top),
        lineEnd: Offset(rrect.right - rrect.trRadiusX, rrect.top),
        startCorner: tl,
        endCorner: tr,
        baseAngle: -math.pi / 2,
        outwardNormal: const Offset(0, -1),
      ),
      (
        visible: right != BorderSide.none,
        lineStart: Offset(rrect.right, rrect.top + rrect.trRadiusY),
        lineEnd: Offset(rrect.right, rrect.bottom - rrect.brRadiusY),
        startCorner: tr,
        endCorner: br,
        baseAngle: 0.0,
        outwardNormal: const Offset(1, 0),
      ),
      (
        visible: bottom != BorderSide.none,
        lineStart: Offset(rrect.right - rrect.brRadiusX, rrect.bottom),
        lineEnd: Offset(rrect.left + rrect.blRadiusX, rrect.bottom),
        startCorner: br,
        endCorner: bl,
        baseAngle: math.pi / 2,
        outwardNormal: const Offset(0, 1),
      ),
      (
        visible: left != BorderSide.none,
        lineStart: Offset(rrect.left, rrect.bottom - rrect.blRadiusY),
        lineEnd: Offset(rrect.left, rrect.top + rrect.tlRadiusY),
        startCorner: bl,
        endCorner: tl,
        baseAngle: math.pi,
        outwardNormal: const Offset(-1, 0),
      ),
    ];
  }

  /// Index of a visible side whose predecessor is hidden — the start of a
  /// run of connected visible sides. Assumes not all sides are visible.
  int _runStart(List<_SideGeometry> sides) {
    for (var i = 0; i < sides.length; i++) {
      if (sides[i].visible && !sides[(i + 3) % sides.length].visible) {
        return i;
      }
    }
    return 0;
  }

  /// Paints solid partial-side borders: each run of connected visible sides
  /// becomes a single filled path — a tapered lead-in corner, the straight
  /// edges joined by full corner arcs, and a tapered lead-out corner — so
  /// translucent colors render without overlap or seams.
  void _paintSolidSides(
    Canvas canvas,
    Rect rect,
    BorderRadius? borderRadius,
    BorderSide side,
  ) {
    final width = side.width;
    final paint = Paint()
      ..color = side.color
      ..style = PaintingStyle.fill;
    final sides = _sides(_centerlineRRect(rect, borderRadius, width));
    final visibleCount = sides.where((s) => s.visible).length;
    var index = _runStart(sides);
    var processed = 0;
    while (processed < visibleCount) {
      final outer = <Offset>[];
      final inner = <Offset>[];
      var current = sides[index];
      // Lead-in: the adjacent side is hidden, so the taper owns the full
      // corner arc, thinning to a point where the hidden side's edge would
      // begin.
      if (current.startCorner.isEmpty) {
        outer.add(current.lineStart + current.outwardNormal * (width / 2));
        inner.add(current.lineStart - current.outwardNormal * (width / 2));
      } else {
        _addArcPoints(
          outer: outer,
          inner: inner,
          corner: current.startCorner,
          startAngle: current.baseAngle - math.pi / 2,
          width: width,
          widthAt: (t) => width * math.sin(t * math.pi / 2),
        );
      }
      while (true) {
        processed++;
        final next = sides[(index + 1) % sides.length];
        if (next.visible && processed < visibleCount) {
          // Full corner arc connecting two visible sides.
          if (current.endCorner.isEmpty) {
            // Square miter joint.
            final miter =
                (current.outwardNormal + next.outwardNormal) * (width / 2);
            outer.add(current.lineEnd + miter);
            inner.add(current.lineEnd - miter);
          } else {
            _addArcPoints(
              outer: outer,
              inner: inner,
              corner: current.endCorner,
              startAngle: current.baseAngle,
              width: width,
              widthAt: (_) => width,
            );
          }
          index = (index + 1) % sides.length;
          current = next;
        } else {
          // Lead-out taper over the full corner arc.
          if (current.endCorner.isEmpty) {
            outer.add(current.lineEnd + current.outwardNormal * (width / 2));
            inner.add(current.lineEnd - current.outwardNormal * (width / 2));
          } else {
            _addArcPoints(
              outer: outer,
              inner: inner,
              corner: current.endCorner,
              startAngle: current.baseAngle,
              width: width,
              widthAt: (t) => width * math.cos(t * math.pi / 2),
            );
          }
          break;
        }
      }
      canvas.drawPath(
        Path()..addPolygon([...outer, ...inner.reversed], true),
        paint,
      );
      // Advance to the start of the next run of visible sides.
      index = (index + 1) % sides.length;
      while (processed < visibleCount && !sides[index].visible) {
        index = (index + 1) % sides.length;
      }
    }
  }

  /// Samples a corner arc, appending its outer boundary (pinned half a
  /// stroke width outside the centerline) and inner boundary (inset by the
  /// border width given by [widthAt], sinusoidal for tapers) to [outer] and
  /// [inner].
  void _addArcPoints({
    required List<Offset> outer,
    required List<Offset> inner,
    required Rect corner,
    required double startAngle,
    required double width,
    required double Function(double t) widthAt,
  }) {
    const sweep = math.pi / 2;
    const steps = 24;
    final rx = corner.width / 2;
    final ry = corner.height / 2;
    final center = corner.center;
    for (var i = 0; i <= steps; i++) {
      final t = i / steps;
      final angle = startAngle + sweep * t;
      final point = Offset(
        center.dx + rx * math.cos(angle),
        center.dy + ry * math.sin(angle),
      );
      // Ellipse normal direction at this angle.
      var normal = Offset(math.cos(angle) * ry, math.sin(angle) * rx);
      final length = normal.distance;
      if (length == 0) {
        continue;
      }
      normal = normal / length;
      outer.add(point + normal * (width / 2));
      // Reaching inward past the corner's center folds the polygon over
      // itself (visible as blobs when the border width approaches the
      // corner radius); clamp so inner points stop at the center.
      inner.add(
        point + normal * math.max(width / 2 - widthAt(t), -math.min(rx, ry)),
      );
    }
  }

  /// Builds the path along the middle of the border stroke, including only
  /// the visible sides. A corner between two visible sides is traversed as
  /// part of the same contour; a corner adjacent to a hidden side terminates
  /// halfway around the arc.
  Path _borderPath(
    Rect rect,
    BoxShape shape,
    BorderRadius? borderRadius,
    double strokeWidth,
  ) {
    final inner = rect.deflate(strokeWidth / 2);
    if (shape == BoxShape.circle) {
      return Path()..addOval(inner);
    }
    final rrect = _centerlineRRect(rect, borderRadius, strokeWidth);
    if (_allSidesVisible) {
      return Path()..addRRect(rrect);
    }

    // Sides in cyclic order. Each contiguous run of visible sides becomes a
    // single continuous contour — lead-in half arc, then lines connected by
    // full corner arcs, then lead-out half arc — so the dash pattern flows
    // through corners instead of restarting on each tiny arc segment.
    final path = Path();
    final sides = _sides(rrect);
    final visibleCount = sides.where((side) => side.visible).length;
    var index = _runStart(sides);
    var processed = 0;
    while (processed < visibleCount) {
      var side = sides[index];
      // Lead-in half arc.
      if (side.startCorner.isEmpty) {
        path.moveTo(side.lineStart.dx, side.lineStart.dy);
      } else {
        path.arcTo(
          side.startCorner,
          side.baseAngle - math.pi / 4,
          math.pi / 4,
          true,
        );
      }
      while (true) {
        path.lineTo(side.lineEnd.dx, side.lineEnd.dy);
        processed++;
        final next = sides[(index + 1) % sides.length];
        if (next.visible && processed < visibleCount) {
          // Full corner arc connecting two visible sides.
          if (!side.endCorner.isEmpty) {
            path.arcTo(side.endCorner, side.baseAngle, math.pi / 2, false);
          }
          index = (index + 1) % sides.length;
          side = next;
        } else {
          // Lead-out half arc.
          if (!side.endCorner.isEmpty) {
            path.arcTo(side.endCorner, side.baseAngle, math.pi / 4, false);
          }
          break;
        }
      }
      // Advance to the start of the next run of visible sides.
      index = (index + 1) % sides.length;
      while (processed < visibleCount && !sides[index].visible) {
        index = (index + 1) % sides.length;
      }
    }
    return path;
  }

  void _drawStyledPath(Canvas canvas, Path path, BorderSide side) {
    final strokePaint = Paint()
      ..color = side.color
      ..strokeWidth = side.width
      ..style = PaintingStyle.stroke;
    final dash = math.max(dashLength, 0.1);
    final requestedGap = math.max(dashGap, 0.1);
    // Segment lengths of one pattern repetition; 0 marks a dot, which is
    // drawn as a filled circle of the stroke width and occupies its
    // diameter along the path. Each segment is followed by a gap.
    final pattern = switch (style) {
      FlutterFlowDashStyle.solid || FlutterFlowDashStyle.dashed => [dash],
      FlutterFlowDashStyle.dotted => [0.0],
      FlutterFlowDashStyle.dashDotted => [dash, 0.0],
    };
    final patternDrawLength = pattern.fold(
      0.0,
      (sum, segment) => sum + (segment == 0.0 ? side.width : segment),
    );
    final dotPaint = Paint()
      ..color = side.color
      ..style = PaintingStyle.fill;
    for (final metric in path.computeMetrics()) {
      // Fit a whole number of pattern repetitions into the contour and
      // stretch the gap so the pattern tiles it exactly, avoiding a partial
      // dash or uneven gap at the seam. Closed contours end with a gap
      // (n segments, n gaps); open ones end with a dash/dot (n segments,
      // n - 1 gaps) so both endpoints are drawn.
      final count = math.max(
        1,
        ((metric.length + (metric.isClosed ? 0 : requestedGap)) /
                (patternDrawLength + pattern.length * requestedGap))
            .round(),
      );
      final totalSegments = count * pattern.length;
      final gapCount = metric.isClosed ? totalSegments : totalSegments - 1;
      final gap = gapCount == 0
          ? 0.0
          : math.max(
              (metric.length - count * patternDrawLength) / gapCount,
              0.0,
            );
      var distance = 0.0;
      var segmentIndex = 0;
      while (segmentIndex < totalSegments && distance < metric.length) {
        final segment = pattern[segmentIndex % pattern.length];
        if (segment == 0.0) {
          final tangent = metric.getTangentForOffset(distance + side.width / 2);
          if (tangent == null) {
            break;
          }
          canvas.drawCircle(tangent.position, side.width / 2, dotPaint);
          distance += side.width + gap;
        } else {
          final length = math.min(segment, metric.length - distance);
          canvas.drawPath(
            metric.extractPath(distance, distance + length),
            strokePaint,
          );
          distance += segment + gap;
        }
        segmentIndex++;
      }
    }
  }

  @override
  Border scale(double t) => FlutterFlowStyledBorder(
        side: _side.scale(t),
        style: style,
        dashLength: dashLength * t,
        dashGap: dashGap * t,
        showTop: top != BorderSide.none,
        showRight: right != BorderSide.none,
        showBottom: bottom != BorderSide.none,
        showLeft: left != BorderSide.none,
      );

  /// Linearly interpolates borders where at least one operand is a
  /// [FlutterFlowStyledBorder], preserving the line style mid-animation.
  ///
  /// [Border.lerp] (which [BoxBorder.lerp] and [BoxDecoration.lerp] dispatch
  /// to statically) rebuilds a plain [Border] from the four sides, dropping
  /// the dash pattern. Continuous values (side, dash geometry) interpolate;
  /// discrete ones (line style, per-side visibility) snap at t = 0.5, the
  /// same convention [BoxDecoration.lerp] uses for [BoxShape].
  static BoxBorder? lerp(BoxBorder? a, BoxBorder? b, double t) {
    if (a is! FlutterFlowStyledBorder && b is! FlutterFlowStyledBorder) {
      return BoxBorder.lerp(a, b, t);
    }
    if (identical(a, b)) {
      return a;
    }
    if (a == null) {
      return (b as FlutterFlowStyledBorder).scale(t);
    }
    if (b == null) {
      return (a as FlutterFlowStyledBorder).scale(1.0 - t);
    }
    if (a is! Border || b is! Border) {
      // Mixing with BorderDirectional is not supported; snap.
      return t < 0.5 ? a : b;
    }
    final sideA = _uniformSide(a);
    final sideB = _uniformSide(b);
    if (sideA == null || sideB == null) {
      // A border whose visible sides differ from each other cannot be
      // represented as a styled border; snap.
      return t < 0.5 ? a : b;
    }
    final styledA = a is FlutterFlowStyledBorder ? a : null;
    final styledB = b is FlutterFlowStyledBorder ? b : null;
    final visibility = t < 0.5 ? a : b;
    double lerpDouble(double x, double y) => x + (y - x) * t;
    return FlutterFlowStyledBorder(
      side: BorderSide.lerp(sideA, sideB, t),
      style: (t < 0.5 ? styledA : styledB)?.style ?? FlutterFlowDashStyle.solid,
      dashLength: lerpDouble(
        (styledA ?? styledB)!.dashLength,
        (styledB ?? styledA)!.dashLength,
      ),
      dashGap: lerpDouble(
        (styledA ?? styledB)!.dashGap,
        (styledB ?? styledA)!.dashGap,
      ),
      showTop: visibility.top != BorderSide.none,
      showRight: visibility.right != BorderSide.none,
      showBottom: visibility.bottom != BorderSide.none,
      showLeft: visibility.left != BorderSide.none,
    );
  }

  /// The [BorderSide] shared by every visible side of [border], or null if
  /// the visible sides differ from each other. [BorderSide.none] when all
  /// sides are hidden.
  static BorderSide? _uniformSide(Border border) {
    BorderSide? result;
    for (final side in [border.top, border.right, border.bottom, border.left]) {
      if (side == BorderSide.none) {
        continue;
      }
      if (result == null) {
        result = side;
      } else if (side != result) {
        return null;
      }
    }
    return result ?? BorderSide.none;
  }

  @override
  ShapeBorder? lerpFrom(ShapeBorder? a, double t) => a == null || a is BoxBorder
      ? lerp(a as BoxBorder?, this, t)
      : super.lerpFrom(a, t);

  @override
  ShapeBorder? lerpTo(ShapeBorder? b, double t) => b == null || b is BoxBorder
      ? lerp(this, b as BoxBorder?, t)
      : super.lerpTo(b, t);

  @override
  bool operator ==(Object other) =>
      super == other &&
      other is FlutterFlowStyledBorder &&
      other.style == style &&
      other.dashLength == dashLength &&
      other.dashGap == dashGap;

  @override
  int get hashCode => Object.hash(super.hashCode, style, dashLength, dashGap);
}

/// A [BoxDecoration] that keeps a [FlutterFlowStyledBorder] styled while
/// animating.
///
/// [AnimatedContainer] interpolates decorations through
/// [Decoration.lerpFrom]/[Decoration.lerpTo], and the base
/// [BoxDecoration.lerp] rebuilds the border with the static [BoxBorder.lerp],
/// which reduces any [Border] subclass to a plain [Border] and drops the
/// line style mid-animation. These overrides re-apply
/// [FlutterFlowStyledBorder.lerp] to the interpolated border.
class FlutterFlowStyledBoxDecoration extends BoxDecoration {
  const FlutterFlowStyledBoxDecoration({
    super.color,
    super.image,
    super.border,
    super.borderRadius,
    super.boxShadow,
    super.gradient,
    super.backgroundBlendMode,
    super.shape,
  });

  static BoxDecoration? _lerp(BoxDecoration? a, BoxDecoration? b, double t) {
    final result = BoxDecoration.lerp(a, b, t);
    if (result == null || a == null || b == null || t == 0.0 || t == 1.0) {
      // In these cases BoxDecoration.lerp scales or returns an operand,
      // which already preserves the border type.
      return result;
    }
    final border = FlutterFlowStyledBorder.lerp(a.border, b.border, t);
    if (border == null || identical(border, result.border)) {
      return result;
    }
    return result.copyWith(border: border);
  }

  @override
  BoxDecoration? lerpFrom(Decoration? a, double t) =>
      a == null || a is BoxDecoration
          ? _lerp(a as BoxDecoration?, this, t)
          : super.lerpFrom(a, t);

  @override
  BoxDecoration? lerpTo(Decoration? b, double t) =>
      b == null || b is BoxDecoration
          ? _lerp(this, b as BoxDecoration?, t)
          : super.lerpTo(b, t);
}
