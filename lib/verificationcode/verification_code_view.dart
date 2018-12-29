import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import 'package:flutter_ui/utils/dash_path.dart' as dashPath;

import 'dart:math';

num degToRad(num deg) => deg * (pi / 180.0);

num radToDeg(num rad) => rad * (180.0 / pi);

class VerificationCodeInput extends StatefulWidget {
  final double letterSpace;
  final double textSize;
  final int codeLength;
  final InputBorder inputBorder;

  const VerificationCodeInput({
    Key key,
    this.letterSpace = 20.0,
    this.textSize = 20.0,
    this.codeLength = 4,
    this.inputBorder,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => VerificationCodeInputState();
}

class VerificationCodeInputState extends State<VerificationCodeInput> {
  double textTrueWidth;

  void calcTrueTextSize() {
    // 测量单个数字实际长度
    var paragraph =
        ui.ParagraphBuilder(ui.ParagraphStyle(fontSize: widget.textSize))
          ..addText("0");
    var p = paragraph.build()
      ..layout(ui.ParagraphConstraints(width: double.infinity));
    textTrueWidth = p.minIntrinsicWidth;
  }

  double get startOffset => widget.letterSpace * 0.5;

  @override
  Widget build(BuildContext context) {
    calcTrueTextSize();

    return TextField(
      maxLength: widget.codeLength,
      keyboardType: TextInputType.number,
      style: TextStyle(
          fontSize: widget.textSize,
          color: Colors.black87,
          letterSpacing: widget.letterSpace),
      decoration: InputDecoration(
          hintText: '    Please input verification code',
          hintStyle: TextStyle(fontSize: 14.0, letterSpacing: 0.0),
          enabledBorder: widget.inputBorder,
          focusedBorder: widget.inputBorder),
    );
  }
}

class CustomRectInputBorder extends UnderlineInputBorder {
  final double spaceWidth;
  final double textWidth;
  final int textLength;
  final double startOffset;

  const CustomRectInputBorder({
    this.startOffset = 0.0,
    this.spaceWidth,
    this.textWidth,
    this.textLength,
    BorderSide borderSide = const BorderSide(),
  }) : super(borderSide: borderSide);

  double get offsetX => textWidth * 0.3;

  double get offsetY => textWidth * 0.3;

  @override
  void paint(
    Canvas canvas,
    Rect rect, {
    double gapStart,
    double gapExtent = 0.0,
    double gapPercentage = 0.0,
    TextDirection textDirection,
  }) {
    double curStartX = rect.left + startOffset - offsetX;
    for (int i = 0; i < textLength; i++) {
      Rect r = Rect.fromLTWH(curStartX, rect.top + offsetY,
          textWidth + offsetX * 2, rect.height - offsetY * 2);
      canvas.drawRect(r, borderSide.toPaint());
      curStartX += (textWidth + spaceWidth);
    }
  }
}

class CustomHeartInputBorder extends UnderlineInputBorder {
  final double spaceWidth;
  final double textWidth;
  final int textLength;
  final double startOffset;

  const CustomHeartInputBorder({
    this.startOffset = 0.0,
    this.spaceWidth,
    this.textWidth,
    this.textLength,
    BorderSide borderSide = const BorderSide(),
  }) : super(borderSide: borderSide);

  double get offsetX => textWidth * 0.3;

  // angleOffset should be range 0 to 90.
  double get angleOffset => 40.0;

  @override
  void paint(
    Canvas canvas,
    Rect rect, {
    double gapStart,
    double gapExtent = 0.0,
    double gapPercentage = 0.0,
    TextDirection textDirection,
  }) {
    double width = rect.height - offsetX;
    double radius = width * 0.25;
    // 1:editable.dart _kCaretGap
    double curStartX = startOffset - radius - offsetX - 1;
    print(
        'rect.height:${rect.height},curStartX:$curStartX,offsetX:$offsetX,startOffset:$startOffset');
    if (curStartX < 0) {
      throw ArgumentError(
          'No enough space to paint border! LetterSpace is too small.');
    }
    double top = rect.center.dy - radius * 2;
    double bottom = rect.center.dy + radius * 2;
    Path path = Path();
    for (int i = 0; i < textLength; i++) {
      path.moveTo(curStartX + radius * 2, top + radius);
      path.arcTo(
          Rect.fromCircle(
              center: Offset(curStartX + radius, top + radius), radius: radius),
          degToRad(180.0 - angleOffset),
          degToRad(180.0 + angleOffset),
          true);
      double sinLength = radius * sin(degToRad(angleOffset));
      double cosLength = radius * cos(degToRad(angleOffset));
      path.moveTo(curStartX + radius - cosLength, top + radius + sinLength);
      path.lineTo(curStartX + radius * 2, bottom);
      path.lineTo(curStartX + radius * 3 + cosLength, top + radius + sinLength);
      path.arcTo(
          Rect.fromCircle(
              center: Offset(curStartX + radius * 3, top + radius),
              radius: radius),
          degToRad(angleOffset),
          degToRad(-180.0 - angleOffset),
          true);
      curStartX += (textWidth + spaceWidth);
    }
    canvas.drawPath(path, borderSide.toPaint());
  }
}

class CustomUnderlineInputBorder extends UnderlineInputBorder {
  final double spaceWidth;
  final double textWidth;
  final int textLength;
  final double startOffset;

  const CustomUnderlineInputBorder({
    this.startOffset = 0.0,
    this.spaceWidth,
    this.textWidth,
    this.textLength,
    BorderSide borderSide = const BorderSide(),
  }) : super(borderSide: borderSide);

  @override
  void paint(
    Canvas canvas,
    Rect rect, {
    double gapStart,
    double gapExtent = 0.0,
    double gapPercentage = 0.0,
    TextDirection textDirection,
  }) {
//    if (borderRadius.bottomLeft != Radius.zero ||
//        borderRadius.bottomRight != Radius.zero)
//      canvas.clipPath(getOuterPath(rect, textDirection: textDirection));
    Path path = Path();
    path.moveTo(rect.bottomLeft.dx + startOffset, rect.bottomLeft.dy);
    path.lineTo(rect.bottomLeft.dx + (textWidth + spaceWidth) * textLength,
        rect.bottomRight.dy);
    path = dashPath.dashPath(path,
        dashArray: dashPath.CircularIntervalList<double>([
          textWidth,
          spaceWidth,
        ]));
    canvas.drawPath(path, borderSide.toPaint());
  }
}
