import 'package:flutter/material.dart';
import 'package:flutter_ui/liquidcheck/liquid_button.dart';

class Progress {
  final double start;
  final double end;

  Progress(this.start, this.end);
}

class LiquidCheckPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LiquidCheckState();
}

class LiquidCheckState extends State<LiquidCheckPage>
    with TickerProviderStateMixin {
  GlobalKey<LiquidButtonState> globalKey = GlobalKey();
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = new AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 6000),
    )..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('LiquidCheck'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Center(
                  child: LiquidButton(
                    key: globalKey,
                    progress: _controller.value,
                    size: Size(200.0, 200.0),
                    onDownLoadStart: () {
                      _controller.reset();
                      _controller.forward();
                    },
                  ),
                ),
                Container(
                  width: 40.0,
                  height: 10.0,
                  child: Text('${(_controller.value * 100).round()} %'),
                )
              ],
            ),
          ),
          FlatButton(
            color: Colors.pinkAccent,
            onPressed: () {
              globalKey.currentState.resetStatus();
            },
            child: Text(
              'reset',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
