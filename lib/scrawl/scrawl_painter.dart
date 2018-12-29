import 'dart:ui';

import 'package:flutter/material.dart';

class Point {
  Color color;
  List<Offset> points;
  double strokeWidth = 5.0;

  Point(this.color, this.strokeWidth, this.points);
}

class ScrawlPainter extends CustomPainter {
  final double strokeWidth;
  final Color strokeColor;
  Paint _linePaint;
  final bool isClear;
  final List<Point> points;

  ScrawlPainter({
    @required this.points,
    @required this.strokeColor,
    @required this.strokeWidth,
    this.isClear = true,
  }) {
    _linePaint = Paint()
      ..color = strokeColor
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;
  }

  void paint(Canvas canvas, Size size) {
    if (isClear || points == null || points.length == 0) {
      return;
    }
    for (int i = 0; i < points.length; i++) {
      _linePaint..color = points[i].color;
      _linePaint..strokeWidth = points[i].strokeWidth;
      List<Offset> curPoints = points[i].points;
      if (curPoints == null || curPoints.length == 0) {
        break;
      }
      for (int i = 0; i < curPoints.length - 1; i++) {
        if (curPoints[i] != null && curPoints[i + 1] != null)
          canvas.drawLine(curPoints[i], curPoints[i + 1], _linePaint);
//      canvas.drawPoints(PointMode.polygon, curPoints, _linePaint);
      }
    }
  }

  bool shouldRepaint(ScrawlPainter other) => true;
}
