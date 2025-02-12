import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter_mvvm_architecture/res/styles/color_palette.dart';

class DottedPainter extends CustomPainter {
  final double? strokeWidth;
  final List<double>? dashPattern;
  final Color? color;
  final double? radius;

  DottedPainter({
    this.strokeWidth,
    this.color,
    this.dashPattern,
    this.radius,
  }) {
    assert(_isValidDashPattern(dashPattern), 'Invalid dash pattern');
  }

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color ?? ColorPalette.primaryColor
      ..strokeCap = StrokeCap.square
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth ?? 1;

    /// Actual path need to be border painted
    Path path = Path()
      ..addRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(
            0,
            0,
            size.width,
            size.height,
          ),
          Radius.circular(radius ?? 6),
        ),
      );

    /// Dashed border shape path
    final dashedPath = dashPath(
      path,
      dashArray: CircularIntervalList(dashPattern ?? [2, 4]),
    );

    canvas.drawPath(dashedPath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;

  /// Compute if [dashPattern] is valid. The following conditions need to be met
  /// * Cannot be null or empty
  /// * If [dashPattern] has only 1 element, it cannot be 0
  bool _isValidDashPattern(List<double>? dashPattern) {
    Set<double>? dashSet = dashPattern?.toSet();
    if (dashSet == null) return false;
    if (dashSet.length == 1 && dashSet.elementAt(0) == 0.0) return false;
    if (dashSet.isEmpty) return false;
    return true;
  }
}

Path dashPath(
  Path source, {
  required CircularIntervalList<double> dashArray,
  DashOffset? dashOffset,
}) {
  dashOffset = dashOffset ?? const DashOffset.absolute(0.0);

  final Path dest = Path();
  for (final PathMetric metric in source.computeMetrics()) {
    double distance = dashOffset._calculate(metric.length);
    bool draw = true;
    while (distance < metric.length) {
      final double len = dashArray.next;
      if (draw) {
        dest.addPath(metric.extractPath(distance, distance + len), Offset.zero);
      }
      distance += len;
      draw = !draw;
    }
  }

  return dest;
}

enum _DashOffsetType { absolute, percentage }

/// Specifies the starting position of a dash array on a path, either as a
/// percentage or absolute value.
///
/// The internal value will be guaranteed to not be null.
class DashOffset {
  /// Create a DashOffset that will be measured as a percentage of the length
  /// of the segment being dashed.
  ///
  /// `percentage` will be clamped between 0.0 and 1.0.
  DashOffset.percentage(double percentage)
      : _rawVal = percentage.clamp(0.0, 1.0),
        _dashOffsetType = _DashOffsetType.percentage;

  /// Create a DashOffset that will be measured in terms of absolute pixels
  /// along the length of a [Path] segment.
  const DashOffset.absolute(double start)
      : _rawVal = start,
        _dashOffsetType = _DashOffsetType.absolute;

  final double _rawVal;
  final _DashOffsetType _dashOffsetType;

  double _calculate(double length) {
    return _dashOffsetType == _DashOffsetType.absolute
        ? _rawVal
        : length * _rawVal;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }

    return other is DashOffset &&
        other._rawVal == _rawVal &&
        other._dashOffsetType == _dashOffsetType;
  }

  @override
  int get hashCode => Object.hash(_rawVal, _dashOffsetType);
}

/// A circular array of dash offsets and lengths.
///
/// For example, the array `[5, 10]` would result in dashes 5 pixels long
/// followed by blank spaces 10 pixels long.  The array `[5, 10, 5]` would
/// result in a 5 pixel dash, a 10 pixel gap, a 5 pixel dash, a 5 pixel gap,
/// a 10 pixel dash, etc.
///
/// Note that this does not quite conform to an [Iterable<T>], because it does
/// not have a moveNext.
class CircularIntervalList<T> {
  CircularIntervalList(this._vals);

  final List<T> _vals;
  int _idx = 0;

  T get next {
    if (_idx >= _vals.length) {
      _idx = 0;
    }
    return _vals[_idx++];
  }
}
