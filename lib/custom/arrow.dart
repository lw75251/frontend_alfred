import 'dart:math';

import 'package:arrow_path/arrow_path.dart';
import 'package:flutter/material.dart';

class ArrowPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    TextSpan textSpan;
    TextPainter textPainter;
    Path path;

    // The arrows usually looks better with rounded caps.
    Paint paint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..strokeWidth = 2.0;

    double startX = 0;
    double startY = 0;

    /// Draw a single arrow.
    path = Path();
    path.moveTo(size.width*.9, size.height*0.95);
    path.relativeCubicTo(0, 0, size.width * .08, -size.height*.1, -size.width*.05, -size.height*.15);
    path = ArrowPath.make(
      tipAngle: pi * .25,
      tipLength: 8,
      path: path
    );
    canvas.drawPath(path, paint..color = Colors.white);

    textSpan = TextSpan(
      text: 'Tap me to start',
      style: TextStyle(color: Colors.white),
    );
      
    canvas.rotate(-pi/75);

    textPainter = TextPainter(
      text: textSpan,
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout(minWidth: size.width);
    textPainter.paint(canvas, Offset(size.width*.35, size.height*1.02));
  }

  @override
  bool shouldRepaint(ArrowPainter oldDelegate) => true;
}