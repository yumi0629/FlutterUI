import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:oktoast/oktoast.dart';

import 'file_utils.dart';

class WatermarkPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => WatermarkState();
}

class WatermarkState extends State<WatermarkPage> {
  static final List<Icon> icons = [
    Icon(
      Icons.map,
      size: 40.0,
      color: Colors.pinkAccent,
    ),
    Icon(
      Icons.storage,
      size: 40.0,
      color: Colors.pinkAccent,
    ),
    Icon(
      Icons.format_paint,
      size: 40.0,
      color: Colors.pinkAccent,
    ),
    Icon(
      Icons.home,
      size: 40.0,
      color: Colors.pinkAccent,
    ),
    Icon(
      Icons.restore,
      size: 40.0,
      color: Colors.pinkAccent,
    ),
    Icon(
      Icons.translate,
      size: 40.0,
      color: Colors.pinkAccent,
    ),
  ];

  Icon selected = icons[0];

  final GlobalKey _repaintKey = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: <Widget>[
            Expanded(
              child: Center(
                child: RepaintBoundary(
                  key: _repaintKey,
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: <Widget>[
                      Image.asset(
                        'images/food01.jpeg',
                        fit: BoxFit.cover,
                      ),
                      selected,
                    ],
                  ),
                ),
              ),
            ),
            FlatButton(
              color: Colors.pinkAccent.withOpacity(0.1),
              onPressed: () {
                RenderRepaintBoundary boundary =
                    _repaintKey.currentContext.findRenderObject();
                saveScreenShot2SDCard(boundary, success: () {
                  showToast('save success!');
                }, fail: () {
                  showToast('save fail!');
                });
              },
              child: Text('save'),
            ),
            Container(
              height: 60.0,
              child: ListView.builder(
                itemCount: icons.length,
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  Icon icon = icons[index];
                  return Container(
                    width: 80.0,
                    height: 60.0,
//                  alignment: Alignment.center,
                    child: GestureDetector(
                        child: icon,
                        onTap: () {
                          setState(() {
                            selected = icon;
                          });
                        }),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
