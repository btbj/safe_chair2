import 'package:flutter/material.dart';
import 'dart:math';

class ProgressArc extends StatelessWidget {
  final int progress;
  ProgressArc({this.progress});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: progress == null
          ? <Widget>[
              CustomPaint(
                painter: ProgressArcPinter(),
              ),
            ]
          : <Widget>[
              CustomPaint(
                painter: ProgressArcPinter(),
              ),
              CustomPaint(
                painter: ProgressDotPinter(progress),
              ),
            ],
    );
  }
}

class ProgressDotPinter extends CustomPainter {
  final int progress;
  ProgressDotPinter(this.progress);

  num degToRad(num deg) => deg * (pi / 180.0);
  num radToDeg(num rad) => rad * (180.0 / pi);

  @override
  void paint(Canvas canvas, Size size) {
    double deg = 120 * progress / 100 + 30;
    final double r = 150;
    final double dx = r * cos(degToRad(deg + 180));
    final double dy = r + r * sin(degToRad(deg + 180));

    final dotPaint = Paint()
      ..color = Colors.white
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(Offset(dx, dy), 4, dotPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class ProgressArcPinter extends CustomPainter {
  num degToRad(num deg) => deg * (pi / 180.0);
  num radToDeg(num rad) => rad * (180.0 / pi);

  @override
  void paint(Canvas canvas, Size size) {
    final double r = 150;
    final offsetCenter = Offset(0, r);
    final Rect arcRect = Rect.fromCircle(center: offsetCenter, radius: r);
    final double startAngle = degToRad(200);
    final double endAngle = degToRad(340);

    final Gradient gradient = new SweepGradient(
      startAngle: startAngle,
      endAngle: endAngle,
      colors: [
        Colors.black,
        Colors.green,
        Colors.red,
        Colors.black,
      ],
      tileMode: TileMode.clamp,
    );

    final progressPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..shader = gradient.createShader(arcRect);
    canvas.drawArc(
        arcRect, startAngle, endAngle - startAngle, false, progressPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
