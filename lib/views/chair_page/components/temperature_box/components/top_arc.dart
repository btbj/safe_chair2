import 'package:flutter/material.dart';
import 'dart:math';

class TopArc extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: CustomPaint(
        painter: TopArcPinter(),
      ),
    );
  }
}

class TopArcPinter extends CustomPainter {
  num degToRad(num deg) => deg * (pi / 180.0);
  num radToDeg(num rad) => rad * (180.0 / pi);

  @override
  void paint(Canvas canvas, Size size) {
    final double r = 150;
    final offsetCenter = Offset(0, r);
    final Rect arcRect = Rect.fromCircle(center: offsetCenter, radius: r);
    final double startAngle =degToRad(220);
    final double endAngle =degToRad(320);

    final Gradient gradient = new SweepGradient(
      startAngle: startAngle,
      endAngle: endAngle,
      colors: [
        Colors.black,
        Colors.blue,
        Colors.black,
      ],
      tileMode: TileMode.clamp,
    );

    final progressPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..shader = gradient.createShader(arcRect);
    canvas.drawArc(arcRect, startAngle, endAngle - startAngle, false, progressPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
