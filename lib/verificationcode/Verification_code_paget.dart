import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ui/verificationcode/verification_code_view.dart';
import 'dart:ui' as ui;

class VerificationCodePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => VerificationCodeState();
}

class VerificationCodeState extends State<VerificationCodePage> {
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
    super.initState();
    future = _loadImage(ExactAssetImage("images/border.png"));
  }

  @override
  Widget build(BuildContext context) {
    var underLineBorder = CustomUnderlineInputBorder(
        letterSpace: 30.0,
        textSize: 50.0,
        textLength: 4,
        borderSide: BorderSide(color: Colors.black26, width: 2.0));

    var rectBorder = CustomRectInputBorder(
        letterSpace: 30.0,
        textSize: 50.0,
        textLength: 4,
        borderSide:
            BorderSide(color: Colors.blue.withOpacity(0.6), width: 2.0));

    var heartBorder = CustomHeartInputBorder(
        letterSpace: 60.0,
        textSize: 20.0,
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
                  letterSpace: 60.0,
                  textSize: 50.0,
                  textLength: 3,
                  image: image,
                );
                switch (snapshot.connectionState) {
                  case ConnectionState.done:
                    if (snapshot.hasError) return Container();
                    return VerificationCodeInput(
                      codeLength: 3,
                      textSize: 50.0,
                      letterSpace: 60.0,
                      inputBorder: imageBorder,
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
            textSize: 20.0,
            letterSpace: 60.0,
            inputBorder: heartBorder,
          ),
        ],
      ),
    );
  }
}
