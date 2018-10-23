import 'package:flutter/material.dart';
import 'package:flutter_ui/sharedelement/product_list.dart';

class ExpandedAppBarPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ExpandedAppBarState();
}

class _ExpandedAppBarState extends State<ExpandedAppBarPage> {
  bool floating = false;
  bool snap = false;
  bool pinned = false;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            actions: <Widget>[
              _buildAction(),
            ],
            title: Text('SliverAppBar'),
            backgroundColor: Theme.of(context).accentColor,
            expandedHeight: 200.0,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.asset('images/food01.jpeg', fit: BoxFit.cover),
            ),
            floating: floating,
            snap: snap,
            pinned: pinned,
          ),
          SliverFixedExtentList(
            itemExtent: 120.0,
            delegate: SliverChildListDelegate(
              products.map((product) {
                return _buildItem(product);
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAction() {
    return PopupMenuButton(
      itemBuilder: (context) => [
            const PopupMenuItem<int>(
              value: 0,
              child: Text('reset'),
            ),
            const PopupMenuItem<int>(
              value: 1,
              child: Text('floating = true'),
            ),
            const PopupMenuItem<int>(
              value: 2,
              child: Text('floating = true , snap = true'),
            ),
            const PopupMenuItem<int>(
              value: 3,
              child: Text('pinned = true'),
            ),
          ],
      onSelected: (value) {
        switch (value) {
          case 1:
            setState(() {
              floating = false;
              snap = false;
              pinned = false;
            });
            break;
          case 1:
            setState(() {
              floating = true;
              snap = false;
              pinned = false;
            });
            break;
          case 2:
            setState(() {
              floating = true;
              snap = true;
              pinned = false;
            });
            break;
          case 3:
            setState(() {
              floating = false;
              snap = false;
              pinned = true;
            });
            break;
        }
      },
    );
  }

  Widget _buildItem(ProductItem product) {
    return Container(
      margin: EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 5.0),
      child: Stack(
        alignment: AlignmentDirectional.centerStart,
        children: <Widget>[
          Positioned(
              left: 30.0,
              child: Card(
                child: Container(
                  margin: EdgeInsets.only(left: 50.0),
                  child: Text(
                    product.name,
                    style: Theme.of(context).textTheme.title,
                  ),
                ),
              )),
          ClipRRect(
            child: SizedBox(
              width: 70.0,
              height: 70.0,
              child: Image.asset(
                product.asset,
                fit: BoxFit.cover,
              ),
            ),
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
          ),
        ],
      ),
    );
  }
}
