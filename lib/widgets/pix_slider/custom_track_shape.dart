import 'package:flutter/material.dart';

class CustomTrackShape extends SliderTrackShape {
  final double max;
  final double min;
  final double currentPosition;
  final double borderRadius;
  double trackWidth;
  final double thumbHeight;

  CustomTrackShape({
    @required this.max,
    @required this.min,
    @required this.currentPosition,
    this.thumbHeight = 20.0,
    this.borderRadius = 8.0,
  });

  @override
  Rect getPreferredRect(
      {RenderBox parentBox,
      Offset offset = Offset.zero,
      SliderThemeData sliderTheme,
      bool isEnabled,
      bool isDiscrete}) {
    final double thumbWidth = sliderTheme.thumbShape
        .getPreferredSize(
          isEnabled,
          isDiscrete,
        )
        .width;
    final double trackHeight = sliderTheme.trackHeight;
    assert(thumbWidth >= 0);
    assert(trackHeight >= 0);
    assert(parentBox.size.width >= thumbWidth);
    assert(parentBox.size.height >= trackHeight);

    final double trackTop =
        offset.dy + (parentBox.size.height - trackHeight) / 2;
    final double trackLeft = offset.dx + thumbWidth / 2;
    trackWidth = parentBox.size.width - thumbWidth;

    return Rect.fromLTWH(
      trackLeft,
      trackTop,
      trackWidth,
      trackHeight,
    );
  }

  @override
  void paint(PaintingContext context, Offset offset,
      {RenderBox parentBox,
      SliderThemeData sliderTheme,
      Animation<double> enableAnimation,
      Offset thumbCenter,
      bool isEnabled,
      bool isDiscrete,
      TextDirection textDirection}) {
    if (sliderTheme.trackHeight == 0) return;
    final Rect trackRect = getPreferredRect(
      parentBox: parentBox,
      offset: offset,
      sliderTheme: sliderTheme,
      isEnabled: isEnabled,
      isDiscrete: isDiscrete,
    );
    /*double currentTrackPosition =
        (currentPosition - min) * (trackWidth / (max - min));*/
    double currentTrackPosition =
        currentPosition;
    final Paint defaultPathPaint = Paint()
      ..color = sliderTheme.activeTrackColor
      ..style = PaintingStyle.fill;
    final defaultPathSegment = Path();
    defaultPathSegment.addRect(
      Rect.fromPoints(
        Offset(
          trackRect.left - (thumbHeight / 2),
          trackRect.top + (thumbHeight / 2) - 1,
        ),
        Offset(
          trackRect.left + currentTrackPosition,
          trackRect.bottom - (thumbHeight / 2) + 1,
        ),
      ),
    );

    context.canvas.drawPath(defaultPathSegment, defaultPathPaint);

    final unselectedPathPaint = Paint()
      ..style = PaintingStyle.fill
      ..color = sliderTheme.inactiveTrackColor;

    final unselectedPathSegment = Path();
    unselectedPathSegment.addRect(
      Rect.fromPoints(
        Offset(
          trackRect.right + (thumbHeight / 2),
          trackRect.top + (thumbHeight / 2) - 1,
        ),
        Offset(
          trackRect.left + currentTrackPosition,
          trackRect.bottom - (thumbHeight / 2) + 1,
        ),
      ),
    );

    context.canvas.drawPath(unselectedPathSegment, unselectedPathPaint);
  }
}
