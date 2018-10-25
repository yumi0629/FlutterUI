import 'package:flutter/material.dart';
import 'package:flutter_ui/draglike/drag_like.dart';
import 'package:flutter_ui/route.dart';
import 'package:flutter_ui/sharedelement/shared_element_shop.dart';
import 'package:flutter_ui/sharedelement/shared_element_transition.dart';
import 'package:flutter_ui/slidedrawer/slide_drawer_page.dart';
import 'package:flutter_ui/sliver/sliver_menu.dart';
import 'package:oktoast/oktoast.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OKToast(
        textStyle: TextStyle(fontSize: 18.0, color: Colors.white),
        backgroundColor: Colors.grey..withAlpha(200),
        radius: 8.0,
        child: MaterialApp(
          title: 'Flutter UI',
          theme: ThemeData(
            primarySwatch: Colors.pink,
          ),
          home: MyHomePage(title: 'Flutter UI'),
          routes: {
            UIRoute.slideDrawer: (_) => SlideDrawerPage(),
//        UIRoute.sharedElement: (_) => SharedElementPage(),
            UIRoute.sharedElement: (_) => ShopPage(),
            UIRoute.sliver: (_) => SliverPage(),
            UIRoute.dragLike: (_) => DragLikePage(),
          },
        ));
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: SafeArea(
          top: false,
          bottom: false,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.white,
                  Colors.pinkAccent,
                ],
              ),
            ),
            child: ListView.builder(
              itemBuilder: (context, index) {
                return _MenuDataItem(menus[index]);
              },
              itemCount: menus.length,
            ),
          ),
        ));
  }
}

class _MenuDataItem extends StatelessWidget {
  const _MenuDataItem(this.data);

  final _MenuData data;

  final double height = 80.0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        Navigator.of(context).pushNamed(data.routeName);
      },
      child: Container(
        height: height,
        margin: EdgeInsets.fromLTRB(10.0, 4.0, 10.0, 4.0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(right: 10.0),
                  child: Icon(
                    data.icon,
                    color: Theme.of(context).accentColor,
                  ),
                ),
                Center(
                  child: Text(
                    data.title,
                    style: Theme.of(context).textTheme.subhead,
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

class _MenuData {
  const _MenuData({
    this.title,
    this.icon,
    this.routeName,
  });

  final String title;
  final IconData icon;
  final String routeName;
}

final List<_MenuData> menus = [
  const _MenuData(
    title: '仿QQ侧滑菜单',
    icon: Icons.audiotrack,
    routeName: UIRoute.slideDrawer,
  ),
  const _MenuData(
    title: '共享元素动画',
    icon: Icons.transform,
    routeName: UIRoute.sharedElement,
  ),
  const _MenuData(
    title: 'Slivers',
    icon: Icons.favorite,
    routeName: UIRoute.sliver,
  ),
  const _MenuData(
    title: 'Drag to choose like or dislike',
    icon: Icons.insert_photo,
    routeName: UIRoute.dragLike,
  ),
];
