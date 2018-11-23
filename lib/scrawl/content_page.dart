import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_ui/scrawl/scrawl_page.dart';
import 'package:flutter_ui/scrawl/watermark_page.dart';
import 'package:oktoast/oktoast.dart';
import 'file_utils.dart';

class ContentPage extends StatelessWidget {
  final GlobalKey _repaintKey = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('scrawl and watermark'),
      ),
      body: RepaintBoundary(
        key: _repaintKey,
        child: Container(
          color: Colors.white,
          child: CustomScrollView(
            slivers: <Widget>[
              SliverToBoxAdapter(
                child: GestureDetector(
                  child: Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Image.asset(
                      'images/food01.jpeg',
                      fit: BoxFit.cover,
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) {
                        return WatermarkPage();
                      }),
                    );
                  },
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    '(Click image above to add watermark ↑↑↑)',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                  padding: EdgeInsets.all(12.0),
                  child: Text(
                    '    Paint your app to life in milliseconds with stateful Hot Reload. Use a rich set of fully-customizable widgets to build native interfaces in minutes.\n'
                        '    Quickly ship features with a focus on native end-user experiences. Layered architecture allows for full customization, which results in incredibly fast rendering and expressive and flexible designs.\n'
                        '    Flutter’s widgets incorporate all critical platform differences such as scrolling, navigation, icons and fonts to provide full native performance on both iOS and Android.',
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 20.0,
                      height: 1.2,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _saveScreenShot(context);
        },
        icon: Icon(Icons.add),
        label: Text('去涂鸦'),
        backgroundColor:
            Color.alphaBlend(Colors.pinkAccent.withOpacity(0.8), Colors.white),
      ),
    );
  }

  void _saveScreenShot(BuildContext context) {
    RenderRepaintBoundary boundary =
        _repaintKey.currentContext.findRenderObject();
    saveScreenShot(boundary, success: () {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) {
          return ScrawlPage();
        }),
      );
    }, fail: () {
      showToast('save current screen fail!');
    });
  }
}
