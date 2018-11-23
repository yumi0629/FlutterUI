import 'package:flutter/material.dart';
import 'package:flutter_ui/sharedelement/product_list.dart';

class _CategoryItem {
  final String category;
  final String tag;
  final String asset;

  _CategoryItem({this.category, this.tag, this.asset});
}

final List<_CategoryItem> categories = [
  _CategoryItem(category: 'Pasta', tag: 'pasta', asset: 'images/food01.jpeg'),
  _CategoryItem(category: 'Fruits', tag: 'fruits', asset: 'images/food02.jpeg'),
  _CategoryItem(category: 'Sweets', tag: 'sweets', asset: 'images/food03.jpeg'),
  _CategoryItem(
      category: 'Seafood', tag: 'seafood', asset: 'images/food04.jpeg'),
  _CategoryItem(category: 'Nuts', tag: 'nuts', asset: 'images/food05.jpeg'),
  _CategoryItem(
      category: 'Vegetables', tag: 'vegetables', asset: 'images/food06.jpeg'),
];

class ShopPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ShopState();
}

class _ShopState extends State<ShopPage> {
  List<_CategoryItem> showCategories = categories;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SharedElementTransition'),
      ),
      body: CustomScrollView(
        physics: ScrollPhysics(),
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: Column(
              children: <Widget>[
                _buildHeader(),
                _buildSearch(),
                _buildCategoryTitle(),
              ],
            ),
          ),
          _buildCategory(),
        ],
      ),
    );
  }

  Widget _buildCategory() {
    return SliverGrid.count(
      crossAxisCount: 2,
      mainAxisSpacing: 4.0,
      crossAxisSpacing: 4.0,
      childAspectRatio: 1.0,
      children: showCategories.map((category) {
        return GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            Navigator.of(context).push(
              PageRouteBuilder(
                  pageBuilder: (context, _, __) {
                    return ProductListPage(
                      title: category.category,
                    );
                  },
                  transitionDuration: const Duration(milliseconds: 500),
                  transitionsBuilder: (_, animation, __, child) {
                    return FadeTransition(
                      opacity: animation,
                      child: FadeTransition(
                        opacity: Tween(begin: 0.5, end: 1.0).animate(animation),
                        child: child,
                      ),
                    );
                  }),
            );
          },
          child: Card(
            child: Container(
              height: 120.0,
              padding: EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ClipRRect(
                    child: SizedBox(
                      width: 100.0,
                      height: 100.0,
                      child: Image.asset(
                        category.asset,
                        fit: BoxFit.cover,
                      ),
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 8.0),
                    child: Text(category.category),
                  ),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  void _doSearch(String search) {
    showCategories = categories
        .where((_CategoryItem category) =>
            category.category.toLowerCase().contains(search.toLowerCase()))
        .toList();
    setState(() {});
  }

  Widget _buildCategoryTitle() {
    return Padding(
      padding: EdgeInsets.all(15.0),
      child: Row(
        children: <Widget>[
          Expanded(
              child: Text(
            'Categories',
            style: Theme.of(context).textTheme.title,
          )),
          Text('${categories.length}'),
        ],
      ),
    );
  }

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
                    onChanged: (value) {
                      _doSearch(value);
                    },
                  ))
                ],
              ),
            ),
          ),
        ));
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
                  'Yumi Store',
                  style: Theme.of(this.context).textTheme.title,
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
                          '0 items',
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
}
