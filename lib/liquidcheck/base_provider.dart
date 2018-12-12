import 'dart:ui';
import 'package:flutter/material.dart';

import 'package:flutter_ui/liquidcheck/bubble.dart';

class Point {
  double x;
  double y;

  Point(this.x, this.y);
}

class BasePourProvider extends BaseProvider {
  Point pourBottom = Point(0.0, 0.0), pourTop = Point(0.0, 0.0);
  final Paint liquidPaint = new Paint()..color = Colors.green;
  final Paint bubblePaint = new Paint();
  final Paint iconPaint = new Paint();
  double frameTop;
  double bottom;
  double top;
  double pourStrokeWidth;
  final List<Bubble> bubbles = [];

  bool get hasBubble => (bubbles != null && bubbles.length != 0);

  BasePourProvider.size(Size size) : super.size(size) {
    frameTop = centerY - 3 * radius;
    bottom = centerY + radius;
    top = centerY + radius;
    pourStrokeWidth = radius / 6;
    iconPaint
      ..color = Colors.white
      ..strokeWidth = radius * 0.15
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
  }

  @override
  draw(Canvas canvas, double progress) {
    if (hasBubble) {
      for (int i = 0; i < bubbles.length; i++) {
        bubbles[i].draw(canvas, bubblePaint, progress);
      }
    }
  }

  clearBubbles() {
    bubbles.clear();
  }

  generateBubble(double x, double y) {
    BubbleGenerator generator = new BubbleGenerator(x, y)
      ..generateBubbleX(x, radius * 0.5, pourStrokeWidth * 0.5)
      ..generateBubbleY(y, radius)
      ..generateRadius(radius * 0.2)
      ..generateDuration(1500, 500);

    Bubble bubble = Bubble.generate(generator);

    bubbles.add(bubble);
  }
}

abstract class BaseProvider {
  double centerX;
  double centerY;
  double radius;

  BaseProvider.size(Size size) {
    centerX = size.width / 2;
    centerY = size.height / 2;
    radius = size.width / 4;
  }

  draw(Canvas canvas, double progress);
}
