import 'dart:ui' as ui;

import 'package:flutter/material.dart';

class CustomSliderThumb extends SliderComponentShape {
  final double min;
  final double max;
  final double thumbRadius;
  final Color color;
  final IconData icon;
  final double fontSizeIcon;
  final Color iconColor;

  const CustomSliderThumb({
    this.min = 0,
    this.max = 10,
    @required this.thumbRadius,
    @required this.icon,
    @required this.iconColor,
    this.fontSizeIcon = 25.0,
    @required this.color,
  });

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size.fromRadius(thumbRadius);
  }

  @override
  paint(
    PaintingContext context,
    Offset center, {
    Animation<double> activationAnimation,
    Animation<double> enableAnimation,
    bool isDiscrete,
    TextPainter labelPainter,
    RenderBox parentBox,
    SliderThemeData sliderTheme,
    TextDirection textDirection,
    double value,
  }) {
    final Canvas canvas = context.canvas;

    // text icon
    ui.ParagraphBuilder builder = ui.ParagraphBuilder(
      ui.ParagraphStyle(
        fontFamily: icon.fontFamily,
        fontSize: fontSizeIcon,
      ),
    );
    builder.pushStyle(
      ui.TextStyle(
        color: iconColor,
      ),
    );
    builder.addText(
      String.fromCharCode(
        icon.codePoint,
      ),
    );
    var iconString = builder.build();
    iconString.layout(
      const ui.ParagraphConstraints(
        width: 60,
      ),
    );
    // end of text icon

    final paint = Paint();
    paint.color = color;
    paint.style = PaintingStyle.fill;

    canvas.drawCircle(center, thumbRadius, paint);

    canvas.drawParagraph(
      iconString,
      Offset(
        center.dx - (fontSizeIcon / 2),
        center.dy - (fontSizeIcon / 2),
      ),
    );
  }

  String getValue(double value) {
    return ((max * value).round()).toString();
  }
}
