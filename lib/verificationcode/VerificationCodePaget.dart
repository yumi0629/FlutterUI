import 'package:flutter/material.dart';
import 'package:flutter_ui/verificationcode/verification_code_view.dart';
import 'dart:ui' as ui;

class VerificationCodePage extends StatelessWidget {
  double calcTrueTextSize(double textSize) {
    // 测量单个数字实际长度
    var paragraph = ui.ParagraphBuilder(ui.ParagraphStyle(fontSize: textSize))
      ..addText("0");
    var p = paragraph.build()
      ..layout(ui.ParagraphConstraints(width: double.infinity));
    return p.minIntrinsicWidth;
  }

  double getStartOffset(double letterSpace) {
    return letterSpace * 0.5;
  }

  @override
  Widget build(BuildContext context) {
    var underLineBorder = CustomUnderlineInputBorder(
        startOffset: getStartOffset(30.0),
        spaceWidth: 30.0,
        textWidth: calcTrueTextSize(50.0),
        textLength: 4,
        borderSide: BorderSide(color: Colors.black26, width: 2.0));

    var rectBorder = CustomRectInputBorder(
        startOffset: getStartOffset(30.0),
        spaceWidth: 30.0,
        textWidth: calcTrueTextSize(50.0),
        textLength: 4,
        borderSide:
            BorderSide(color: Colors.blue.withOpacity(0.6), width: 2.0));

    var t = 25.0;
    var space = 60.0;

    var heartBorder = CustomHeartInputBorder(
        startOffset: getStartOffset(space),
        spaceWidth: space,
        textWidth: calcTrueTextSize(t),
        textLength: 4,
        borderSide: BorderSide(color: Color(0xFFFFC0CB), width: 2.0));

    return Scaffold(
      appBar: AppBar(
        title: Text('VerificationCode'),
      ),
      body: ListView(
        children: <Widget>[
          VerificationCodeInput(
            textSize: 50.0,
            letterSpace: 30.0,
            inputBorder: underLineBorder,
          ),
          VerificationCodeInput(
            textSize: 50.0,
            letterSpace: 30.0,
            inputBorder: rectBorder,
          ),
          VerificationCodeInput(
            textSize: t,
            letterSpace: space,
            inputBorder: heartBorder,
          ),
        ],
      ),
    );
  }
}
