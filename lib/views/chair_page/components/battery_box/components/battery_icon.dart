import 'package:flutter/material.dart';

class BatteryIcon extends StatelessWidget {
  final int progress;
  final bool active;
  BatteryIcon({this.progress, this.active});

  Color getLineColor() {
    if (!active) return Colors.grey;
    if (progress <= 10)
      return Colors.red;
    else if (progress <= 20)
      return Colors.orange;
    else
      return Colors.white;
  }
  Color getCellColor() {
    if (!active) return Colors.grey[600];
    if (progress <= 10)
      return Colors.red;
    else if (progress <= 20)
      return Colors.orange;
    else
      return Colors.green;
  }

  Widget drawCell() {
    return Stack(
      children: <Widget>[
        Container(
          width: 102 * progress / 100,
          height: 50,
          decoration: BoxDecoration(
            color: getCellColor(),
            borderRadius: BorderRadius.circular(2),
            border: Border.all(width: 1, color: getLineColor()),
          ),
        ),
        Container(
          width: 102,
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2),
            border: Border.all(width: 1, color: getLineColor()),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Container(
          width: 110,
          height: 56,
          child: CustomPaint(
            painter: BatteryPinter(color: getLineColor()),
          ),
        ),
        drawCell(),
      ],
    );
  }
}

class BatteryPinter extends CustomPainter {
  final double width = 110;
  final double height = 56;
  final double halfCapHeight = 16;
  final double halfCapSmallHeight = 8;
  final double r = 4;
  final Color color;
  BatteryPinter({this.color});
  @override
  void paint(Canvas canvas, Size size) {
    Path path = new Path();
    Offset currentPoint = Offset(0, 0);
    void moveTo(Offset offset) {
      path.moveTo(offset.dx, offset.dy);
      currentPoint = offset;
    }

    void drawLine(Offset direction) {
      Offset newPoint = currentPoint + direction;
      path.lineTo(newPoint.dx, newPoint.dy);
      currentPoint = newPoint;
    }

    void drawCorner(Offset direction) {
      Offset newPoint = currentPoint + direction;
      currentPoint = newPoint;
      path.arcToPoint(newPoint, radius: Radius.circular(r));
    }

    void drawBody() {
      moveTo(Offset(r, 0));
      drawLine(Offset(width - r - r, 0));
      drawCorner(Offset(r, r));
      drawLine(Offset(0, (height / 2) - halfCapHeight - r));
      moveTo(Offset(width, (height / 2) + halfCapHeight));
      drawLine(Offset(0, (height / 2) - halfCapHeight - r));
      drawCorner(Offset(-r, r));
      drawLine(Offset(-(width - r - r), 0));
      drawCorner(Offset(-r, -r));
      drawLine(Offset(0, -(height - r - r)));
      drawCorner(Offset(r, -r));
      drawLine(Offset(width - r - r, 0));
      moveTo(Offset(0, 0));
    }

    void drawHead() {
      moveTo(Offset(width, (height / 2) - halfCapHeight));
      drawLine(Offset(4 - 2.0, 0));
      drawCorner(Offset(2, 2));
      drawLine(Offset(0, halfCapHeight - halfCapSmallHeight - 2));
      drawLine(Offset(2, 0));
      drawLine(Offset(0, 2 * halfCapSmallHeight));
      drawLine(Offset(-2, 0));
      drawLine(Offset(0, halfCapHeight - halfCapSmallHeight - 2));
      drawCorner(Offset(-2, 2));
      drawLine(Offset(-(4 - 2.0), 0));
      moveTo(Offset(0, 0));
    }

    drawBody();
    drawHead();

    final pathPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1
      ..color = color;

    canvas.drawPath(path, pathPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
