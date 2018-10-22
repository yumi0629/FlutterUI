import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:flutter_ui/commonwidget/custom_flow_delegate.dart';

class _MenuData {
  const _MenuData({
    this.width,
    this.height,
    this.title,
    this.icon,
    this.flutterLogo,
  });

  final double width;
  final double height;
  final String title;
  final IconData icon;
  final FlutterLogo flutterLogo;
}

final List<_MenuData> menus = [
  const _MenuData(
    width: 100.0,
    height: 100.0,
    title: 'Music',
    icon: Icons.audiotrack,
  ),
  const _MenuData(
    width: 120.0,
    height: 150.0,
    title: 'Transition',
    icon: Icons.transform,
    flutterLogo: FlutterLogo(
      colors: Colors.cyan,
      size: 60.0,
    ),
  ),
  const _MenuData(
    width: 120.0,
    height: 150.0,
    title: 'Photo',
    icon: Icons.photo,
    flutterLogo: FlutterLogo(
      colors: Colors.orange,
      size: 60.0,
    ),
  ),
  const _MenuData(
    width: 100.0,
    height: 100.0,
    title: 'Alarm',
    icon: Icons.access_alarm,
  ),
  const _MenuData(
    width: 100.0,
    height: 100.0,
    title: 'Access',
    icon: Icons.beach_access,
  ),
  const _MenuData(
    width: 120.0,
    height: 150.0,
    title: 'Call',
    icon: Icons.call,
    flutterLogo: FlutterLogo(
      colors: Colors.lightGreen,
      size: 60.0,
    ),
  ),
];

class _MenuDataItem extends StatelessWidget {
  const _MenuDataItem(this.data);

  final _MenuData data;

  @override
  Widget build(BuildContext context) {
    print('width:${data.width}');
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (_) {
          return ElementDetailPage(
            data: data,
          );
        }));
      },
      child: Container(
        width: data.width,
        height: data.height,
        margin: EdgeInsets.fromLTRB(10.0, 4.0, 10.0, 4.0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Hero(
                    createRectTween: (Rect begin, Rect end) {
                      return RectTween(
                        begin: Rect.fromLTRB(
                            begin.left, begin.top, begin.right, begin.bottom),
                        end: Rect.fromLTRB(end.left, end.top, end.right, end.bottom),
                      );
                    },
                    tag: data.title,
                    child: Padding(
                      padding: EdgeInsets.only(right: 10.0),
                      child: data.flutterLogo == null
                          ? Icon(
                              data.icon,
                              color: Theme.of(context).accentColor,
                            )
                          : data.flutterLogo,
                    )),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(top: 10.0),
                    child: Text(
                      data.title,
                      style: Theme.of(context).textTheme.body1,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ElementDetailPage extends StatelessWidget {

  final _MenuData data;

  ElementDetailPage({Key key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        children: <Widget>[
          Expanded(
              child: Hero(
            createRectTween: (Rect begin, Rect end) {
              return RectTween(
                begin: Rect.fromLTRB(
                    begin.left, begin.top, begin.right, begin.bottom),
                end: Rect.fromLTRB(end.left, end.top, end.right, end.bottom),
              );
            },
            tag: data.title,
            child: data.flutterLogo == null
                ? Icon(
                    data.icon,
                    color: Theme.of(context).accentColor,
                    size: 100.0,
                  )
                : FlutterLogo(
                    size: 200.0,
                    colors: data.flutterLogo.colors,
                  ),
          )),
          Padding(
            padding: EdgeInsets.only(bottom: 40.0),
            child: Text(
              'This is icon ${data.title}',
              style: Theme.of(context).textTheme.title,
            ),
          ),
        ],
      ),
    );
  }
}

class SharedElementPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SharedElementTransition'),
      ),
      body: Flow(
        delegate: CustomFlowDelegate(
            margin: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0)),
        children: menus.map((menu) {
          return _MenuDataItem(menu);
        }).toList(),
      ),
    );
  }
}
