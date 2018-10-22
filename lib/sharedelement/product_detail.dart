import 'package:flutter/material.dart';
import 'package:flutter_ui/sharedelement/product_list.dart';

class ProductDetailPage extends StatefulWidget {
  final ProductItem product;

  const ProductDetailPage({Key key, this.product}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product.name),
      ),
      body: Column(children: <Widget>[
        _buildProduct(),
      ]),
    );
  }

  Widget _buildProduct() {
    return Hero(
      tag: widget.product.tag,
      child: Container(
          padding: EdgeInsets.only(left: 15.0, right: 15.0),
          height: 120.0,
          child: Row(
            children: <Widget>[
              Card(
                child: ClipRRect(
                  child: SizedBox(
                    width: 60.0,
                    height: 60.0,
                    child: Image.asset(
                      widget.product.asset,
                      fit: BoxFit.cover,
                    ),
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                ),
              ),
              Expanded(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    widget.product.name,
                    style: Theme.of(context).textTheme.title,
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(child: Text(
                        '4 items',
                        style: Theme.of(context).textTheme.body1.copyWith(
                          color: Colors.black26,
                        ),
                      )),
                      Text(
                        '\$${widget.product.price}',
                        style: Theme.of(context).textTheme.title,
                      )
                    ],
                  ),
                ],
              ))
            ],
          )),
    );
  }
}
