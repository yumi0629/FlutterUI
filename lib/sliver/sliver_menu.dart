import 'package:flutter/material.dart';
import 'package:flutter_ui/sliver/sliver_expanded_appbar.dart';
import 'package:flutter_ui/sliver/sliver_box.dart';
import 'package:flutter_ui/sliver/sliver_grid.dart';
import 'package:flutter_ui/sliver/sliver_header.dart';
import 'package:flutter_ui/sliver/sliver_list.dart';

class _MenuData {
  const _MenuData({
    this.title,
  });

  final String title;
}

final List<_MenuData> menus = [
  const _MenuData(
    title: 'SliverAppBar',
  ),
  const _MenuData(
    title: 'SliverList',
  ),
  const _MenuData(
    title: 'SliverGrid',
  ),
  const _MenuData(
    title: 'SliverPersistentHeader',
  ),
  const _MenuData(
    title: 'SliverToBoxAdapter',
  ),
];

class _MenuDataItem extends StatelessWidget {
  const _MenuDataItem(this.data);

  final _MenuData data;

  void _pushRoute(BuildContext context, String title) {
    switch (title) {
      case 'SliverAppBar':
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return ExpandedAppBarPage();
        }));
        break;
      case 'SliverList':
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return SliverListPage();
        }));
        break;
      case 'SliverGrid':
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return SliverGridPage();
        }));
        break;
      case 'SliverPersistentHeader':
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return SliverHeaderPage();
        }));
        break;
      case 'SliverToBoxAdapter':
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return SliverBoxPage();
        }));
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        _pushRoute(context, data.title);
      },
      child: Container(
        height: 80.0,
        margin: EdgeInsets.fromLTRB(10.0, 4.0, 10.0, 4.0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Text(
                data.title,
                style: Theme.of(context).textTheme.subhead,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SliverPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text('Slivers'),
        ),
        body: new SafeArea(
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
