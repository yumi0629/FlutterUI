import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ui/verificationcode/verification_code_view.dart';
import 'dart:ui' as ui;

class VerificationCodePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => VerificationCodeState();
}

class VerificationCodeState extends State<VerificationCodePage> {
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

  Future<void> _loadImage(ExactAssetImage image) async {
    AssetBundleImageKey key = await image.obtainKey(ImageConfiguration());
    final ByteData data = await key.bundle.load(key.name);
    if (data == null) throw 'Unable to read data';
    var codec = await ui.instantiateImageCodec(data.buffer.asUint8List());
    // add additional checking for number of frames etc here
    var frame = await codec.getNextFrame();
    this.image = frame.image;
  }

  ui.Image image;

  Future future;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    future = _loadImage(ExactAssetImage("images/border.png"));
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
          FutureBuilder(
              future: future,
              builder: (context, snapshot) {
                var imageBorder = CustomImageInputBorder(
                  startOffset: getStartOffset(space),
                  spaceWidth: space,
                  textWidth: calcTrueTextSize(50.0),
                  textLength: 3,
                  image: image,
                );
                switch (snapshot.connectionState) {
                  case ConnectionState.done:
                    if (snapshot.hasError) return Container();
                    return TextField(
                      maxLength: 3,
                      keyboardType: TextInputType.number,
                      style: TextStyle(
                          fontSize: 50.0,
                          color: Colors.black87,
                          letterSpacing: space),
                      decoration: InputDecoration(
                          enabledBorder: imageBorder,
                          focusedBorder: imageBorder),
                    );
                    break;
                  default:
                    return Container();
                    break;
                }
              }),
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
