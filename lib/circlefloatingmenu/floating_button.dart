import 'package:flutter/material.dart';

class FloatingButton extends StatelessWidget {
  final IconData icon;
  final Color color;
  final double size;
  final double elevation;

  const FloatingButton(
      {Key key,
      this.icon,
      this.color = Colors.pinkAccent,
      this.size,
      this.elevation = 2.0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Container(
      padding: EdgeInsets.all(8.0),
      child: Icon(
        icon,
        color: Colors.white,
        size: size ?? 24.0,
      ),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
        boxShadow: [
          BoxShadow(
              color: Colors.grey,
              blurRadius: elevation,
              offset: Offset(elevation, elevation),
              spreadRadius: elevation)
        ],
      ),
    );
  }
}
