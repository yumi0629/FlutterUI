import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_ui/sharedelement/product_list.dart';

class SliverBoxPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SliverToBoxAdapter'),
      ),
      body: CustomScrollView(
        physics: ScrollPhysics(),
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: _buildHeader(),
          ),
          SliverGrid.count(
            crossAxisCount: 3,
            children: products.map((product) {
              return _buildItemGrid(product);
            }).toList(),
          ),
          SliverToBoxAdapter(
            child: _buildSearch(),
          ),
          SliverFixedExtentList(
            itemExtent: 100.0,
            delegate: SliverChildListDelegate(
              products.map((product) {
                return _buildItemList(product);
              }).toList(),
            ),
          ),
          SliverToBoxAdapter(
            child: _buildFooter(),
          ),
        ],
      ),
    );
  }

  Widget _buildFooter() {
    return Container(
      height: 100.0,
      decoration: BoxDecoration(
          backgroundBlendMode: BlendMode.plus,
          image: DecorationImage(
            image: AssetImage('images/footer.jpeg'),
            fit: BoxFit.cover,
          ),
          color: Colors.white),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20.0, sigmaY: 20.0),
        child: Container(
          child: Center(
            child: Text(
              'This is footer',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.black54,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.all(15.0),
      height: 100.0,
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  '吉原拉面',
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 6.0),
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.favorite_border,
                        color: Colors.black26,
                        size: 12.0,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 4.0),
                        child: Text(
                          'yumi',
                          style: TextStyle(color: Colors.black26),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          ClipRRect(
            child: SizedBox(
              width: 60.0,
              height: 60.0,
              child: Image.asset(
                'images/shop.jpeg',
                fit: BoxFit.cover,
              ),
            ),
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
          )
        ],
      ),
    );
  }

  Widget _buildSearch() {
    return Card(
      margin: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
      elevation: 8.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(50.0)),
      ),
      child: Container(
        padding: EdgeInsets.only(left: 25.0, right: 25.0),
        height: 45.0,
        child: Center(
          child: Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(right: 8.0),
                child: Icon(
                  Icons.search,
                  color: Colors.black26,
                  size: 20.0,
                ),
              ),
              Expanded(
                  child: TextField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Search category',
                    hintStyle: TextStyle(color: Colors.black26)),
                cursorColor: Colors.pink,
              ))
            ],
          ),
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
}
