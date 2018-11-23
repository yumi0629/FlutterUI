import 'package:flutter/material.dart';
import 'package:flutter_ui/tipmenu/triangle_painter.dart';
import 'tip_menu.dart';
import 'model.dart';
import 'package:oktoast/oktoast.dart';

class TipMenuPage extends StatelessWidget {

  final List<MyMenu> menus = [
    MyMenu(index: 0, description: 'copy'),
    MyMenu(index: 1, description: 'paste'),
    MyMenu(index: 2, description: 'share'),
  ];

  OverlayEntry _overlayEntry;
  final GlobalKey anchorKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    Widget body = Scaffold(
      appBar: AppBar(
        title: Text('TipMenu'),
      ),
      body: Container(
        margin: EdgeInsets.all(12.0),
        child: Builder(
          builder: (ctx) => GestureDetector(
                behavior: HitTestBehavior.translucent,
                child: StatefulBuilder(
                  key: anchorKey,
                  builder: (context, state) {
                    return Text(
                      'click me',
                      style: TextStyle(
                        fontSize: 20.0,
                        background: Paint()..color = Colors.yellow,
                      ),
                    );
                  },
                ),
                onTap: () {
                  _showTipMenu(ctx);
                },
              ),
        ),
      ),
    );
    var overlay = Overlay(
      initialEntries: [
        OverlayEntry(builder: (_) => body),
      ],
    );
    return overlay;
  }

  void _showTipMenu(BuildContext context) {
    this._overlayEntry = this._createOverlayEntry(context);
    Overlay.of(context).insert(this._overlayEntry);
  }

  OverlayEntry _createOverlayEntry(BuildContext context) {
    RenderBox renderBox = context.findRenderObject();
    var offset = renderBox.localToGlobal(Offset(0.0, renderBox.size.height));

    return OverlayEntry(builder: (context) {
      return GestureDetector(
        behavior: HitTestBehavior.translucent,
        child: Container(
          margin: EdgeInsets.only(
            top: offset.dy + 5.0,
            left: offset.dx,
          ),
          child: Stack(
            children: <Widget>[
              Positioned(
                left: 15.0,
                child: CustomPaint(
                  painter: TrianglePainter(),
                ),
              ),
              Positioned(
                child: Material(
                  child: TipMenu(
                    menus: menus,
                    onMenuSelected: (menu) {
                      _overlayEntry.remove();
                      showToast(
                        menu.getMenuValue(),
                      );
                    },
                  ),
                ),
                top: 8.0,
              )
            ],
          ),
        ),
        onTap: () {
          _overlayEntry.remove();
        },
      );
    });
  }
}

class MyMenu extends IMenu {
  final int index;
  final String description;

  MyMenu({
    this.index,
    this.description,
  });

  @override
  String getMenuValue() {
    return description;
  }
}
