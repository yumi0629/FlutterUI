import 'package:flutter/material.dart';

enum CornerPosition {
  Top,
  Bottom,
}

class TrianglePainter extends CustomPainter {
  final Color color;
  final CornerPosition cornerPosition = CornerPosition.Top;
  final double width;
  final double height;

  TrianglePainter({
    this.color = const Color(-0x34000000),
//    this.cornerPosition = CornerPosition.Top,
    this.width = 8.0,
    this.height = 8.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Path path = Path();
    Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    switch (cornerPosition) {
      case CornerPosition.Top:
        path
          ..moveTo(0.0, height)
          ..lineTo(width, height)
          ..lineTo(width / 2, 0.0);
        break;
      case CornerPosition.Bottom:
        path
          ..moveTo(0.0, 0.0)
          ..lineTo(width, 0.0)
          ..lineTo(width / 2, height);
        break;
    }
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
