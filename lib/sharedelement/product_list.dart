import 'package:flutter/material.dart';
import 'package:flutter_ui/sharedelement/product_detail.dart';

class ProductItem {
  final String name;
  final String tag;
  final String asset;
  final int stock;
  final double price;

  ProductItem({
    this.name,
    this.tag,
    this.asset,
    this.stock,
    this.price,
  });
}

final List<ProductItem> products = [
  ProductItem(
      name: 'Bueno Chocolate',
      tag: '1',
      asset: 'images/food01.jpeg',
      stock: 1,
      price: 71.0),
  ProductItem(
      name: 'Chocolate with berries',
      tag: '2',
      asset: 'images/food02.jpeg',
      stock: 1,
      price: 71.0),
  ProductItem(
      name: 'Trumoo Candies',
      tag: '3',
      asset: 'images/food03.jpeg',
      stock: 1,
      price: 71.0),
  ProductItem(
      name: 'Choco-coko',
      tag: '4',
      asset: 'images/food04.jpeg',
      stock: 1,
      price: 71.0),
  ProductItem(
      name: 'Chocolate tree',
      tag: '5',
      asset: 'images/food05.jpeg',
      stock: 1,
      price: 71.0),
  ProductItem(
      name: 'Chocolate',
      tag: '6',
      asset: 'images/food06.jpeg',
      stock: 1,
      price: 71.0),
];

class ProductListPage extends StatefulWidget {
  final String title;

  const ProductListPage({Key key, this.title}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ProductListState();
}

class _ProductListState extends State<ProductListPage> {
  Widget _buildSearch() {
    return Hero(
        tag: 'search',
        child: Card(
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
                    cursorColor: Theme.of(this.context).accentColor,
                  ))
                ],
              ),
            ),
          ),
        ));
  }

  Widget _buildProduct(ProductItem product) {
    var width = MediaQuery.of(context).size.width;
    return Hero(
      tag: product.tag,
      child: Container(
        height: 120.0,
        margin: EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 5.0),
        child: Stack(
          alignment: AlignmentDirectional.centerStart,
          children: <Widget>[
            Positioned(
                left: 20.0,
                child: Card(
                  child: Container(
                    width: width - 15.0 * 2 - 20.0 - 50.0,
                    margin: EdgeInsets.only(left: 50.0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                product.name,
                                style: Theme.of(context).textTheme.title,
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 8.0),
                                child: Text(
                                  '${product.stock} Unit',
                                  style: TextStyle(color: Colors.black26),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 60.0,
                          width: 1.0,
                          color: Colors.black12,
                        ),
                        Expanded(
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(top: 8.0),
                                child: Text(
                                  '\$${product.price}',
                                  style: TextStyle(fontSize: 25.0),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 8.0),
                                child: Text(
                                  'PRICE',
                                  style: TextStyle(color: Colors.black26),
                                ),
                              ),
                              MaterialButton(
                                height: 30.0,
                                child: Text('BUY'),
                                onPressed: () {
                                  Navigator.of(context).push(
                                    PageRouteBuilder(
                                        pageBuilder: (context, _, __) {
                                          return ProductDetailPage(
                                            product: product,
                                          );
                                        },
                                        transitionDuration:
                                            const Duration(milliseconds: 500),
                                        transitionsBuilder:
                                            (_, animation, __, child) {
                                          return FadeTransition(
                                            opacity: animation,
                                            child: FadeTransition(
                                              opacity:
                                                  Tween(begin: 0.5, end: 1.0)
                                                      .animate(animation),
                                              child: child,
                                            ),
                                          );
                                        }),
                                  );
                                },
                                color: Colors.deepPurpleAccent,
                                textColor: Colors.white,
                              )
                            ],
                          ),
                        ),
                      ],
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
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[
          _buildSearch(),
          Expanded(
            child: ListView.builder(
                itemCount: products.length,
                itemBuilder: (BuildContext context, int index) {
                  return _buildProduct(products[index]);
                }),
          )
        ],
      ),
    );
  }
}
