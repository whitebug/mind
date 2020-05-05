import 'dart:math';

import 'package:flutter/material.dart';

class PlayerCircle extends CustomPainter {
  final Color mainColor;
  final Color progressColor;
  final double width;
  final double progress;

  PlayerCircle({
    @required this.mainColor,
    @required this.progressColor,
    @required this.width,
    @required this.progress,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint circle = Paint()
      ..color = mainColor
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = width;
    // draw progress
    Paint progressArk = Paint()
      ..color = progressColor
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = width;

    Offset center  = Offset(size.width/2, size.height/2);
    double radius  = min(size.width/2,size.height/2);
    canvas.drawCircle(
        center,
        radius,
        circle
    );
    double arcAngle = 2 * pi * (progress / 100);
    canvas.drawArc(
        Rect.fromCircle(center: center,radius: radius),
        -pi/2,
        arcAngle,
        false,
        progressArk
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
