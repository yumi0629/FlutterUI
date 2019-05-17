import 'dart:ui';

import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:flutter_ui/sharedelement/product_list.dart';

final List<String> titleAssets = [
  'images/food01.jpeg',
  'images/food02.jpeg',
  'images/food03.jpeg',
];

final List<ProductItem> _products = [
  ProductItem(
    name: 'Bueno Chocolate',
    asset: 'images/food01.jpeg',
  ),
  ProductItem(
    name: 'Chocolate with berries',
    asset: 'images/food02.jpeg',
  ),
  ProductItem(
    name: 'Trumoo Candies',
    asset: 'images/food03.jpeg',
  ),
  ProductItem(
    name: 'Choco-coko',
    asset: 'images/food04.jpeg',
  ),
  ProductItem(
    name: 'Chocolate tree',
    asset: 'images/food05.jpeg',
  ),
  ProductItem(
    name: 'Chocolate',
    asset: 'images/food06.jpeg',
  ),
  ProductItem(
    name: 'Bueno Chocolate',
    asset: 'images/food01.jpeg',
  ),
  ProductItem(
    name: 'Choco-coko',
    asset: 'images/food04.jpeg',
  ),
  ProductItem(
    name: 'Chocolate tree',
    asset: 'images/food05.jpeg',
  ),
];

final List<ProductItem> _products2 = []..addAll(_products)..addAll(_products);

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate({
    @required this.minHeight,
    @required this.maxHeight,
    @required this.child,
  });

  final double minHeight;
  final double maxHeight;
  final Widget child;

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => math.max(maxHeight, minHeight);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}

class SliverHeaderPage extends StatefulWidget {
  const SliverHeaderPage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CollapsingState();
}

class _CollapsingState extends State<SliverHeaderPage> {
  bool floating = false;
  bool pinned = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SliverHeader'),
        actions: <Widget>[
          _buildAction(),
        ],
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          _buildHeader(0),
          SliverGrid.count(
            crossAxisCount: 3,
            children: _products.map((product) {
              return _buildItemGrid(product);
            }).toList(),
          ),
          _buildHeader(1),
          SliverFixedExtentList(
            itemExtent: 100.0,
            delegate: SliverChildListDelegate(
              products.map((product) {
                return _buildItemList(product);
              }).toList(),
            ),
          ),
          _buildHeader(2),
          SliverGrid(
            gridDelegate: new SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200.0,
              mainAxisSpacing: 10.0,
              crossAxisSpacing: 10.0,
              childAspectRatio: 3.0,
            ),
            delegate: new SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return _buildItemGrid2(_products2[index]);
              },
              childCount: _products2.length,
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
              child: Text('floating'),
            ),
            const PopupMenuItem<int>(
              value: 2,
              child: Text('pinned'),
            ),
          ],
      onSelected: (value) {
        switch (value) {
          case 0:
            setState(() {
              floating = false;
              pinned = false;
            });
            break;
          case 1:
            setState(() {
              floating = true;
              pinned = false;
            });
            break;
          case 2:
            setState(() {
              floating = false;
              pinned = true;
            });
            break;
        }
      },
    );
  }

  SliverPersistentHeader _buildHeader(int index) {
    String asset = titleAssets[index];
    return SliverPersistentHeader(
      pinned: pinned,
      floating: floating,
      delegate: _SliverAppBarDelegate(
        minHeight: 60.0,
        maxHeight: 180.0,
        child: Container(
          decoration: BoxDecoration(
              backgroundBlendMode: BlendMode.plus,
              image: DecorationImage(
                image: AssetImage(asset),
                fit: BoxFit.fill,
              ),
              color: Colors.white),
          child: ClipRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
              child: Container(
                height: 60.0,
                child: Center(
                  child: Text(
                    'This is header ${index + 1}',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Color(0xE5FFFFFF),
                    ),
                  ),
                ),
              ),
            ),
          )
        ),
      ),
    );
  }

  Widget _buildItemGrid(ProductItem product) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ClipRRect(
                child: SizedBox(
                  width: 65.0,
                  height: 65.0,
                  child: Image.asset(
                    product.asset,
                    fit: BoxFit.cover,
                  ),
                ),
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(top: 6.0),
                  child: Text(
                    product.name,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildItemList(ProductItem product) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 20.0),
                child: ClipRRect(
                  child: SizedBox(
                    width: 65.0,
                    height: 65.0,
                    child: Image.asset(
                      product.asset,
                      fit: BoxFit.cover,
                    ),
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 15.0),
                  child: Text(
                    product.name,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildItemGrid2(ProductItem product) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: ClipRRect(
                  child: SizedBox(
                    width: 20.0,
                    height: 20.0,
                    child: Image.asset(
                      product.asset,
                      fit: BoxFit.cover,
                    ),
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 6.0),
                  child: Text(
                    product.name,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
