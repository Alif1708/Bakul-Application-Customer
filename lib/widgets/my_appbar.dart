import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:search_page/search_page.dart';
import 'package:bakul_app/models/product_model.dart';
import 'package:bakul_app/screens/product_details_screen.dart';

class MyAppBar extends StatefulWidget {
  const MyAppBar({Key? key}) : super(key: key);

  @override
  State<MyAppBar> createState() => _MyAppBarState();
}

class _MyAppBarState extends State<MyAppBar> {
  static List<Product> product = [];

  @override
  void initState() {
    FirebaseFirestore.instance
        .collection('products')
        .where('published', isEqualTo: true)
        .get()
        .then((value) {
      for (var element in value.docs) {
        print(element['productName']);
        setState(() {
          product.add(Product(
            productName: element['productName'],
            category: element['category']['mainCategory'],
            image: element['productImage'],
            shopName: element['seller']['shopName'],
            price: element['price'],
            document: element,
          ));
        });
      }
      print(product.length);
    });

    super.initState();
  }

  @override
  void dispose() {
    product.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Color(0xFF143D59),
      iconTheme: const IconThemeData(
        color: Color(0xFFF4B41A),
      ),
      automaticallyImplyLeading: false,
      elevation: 0.0,
      floating: true,
      snap: true,
      centerTitle: true,
      actions: [
        IconButton(
            onPressed: () {
              showSearch(
                context: context,
                delegate: SearchPage<Product>(
                  barTheme: ThemeData(
                    textTheme: TextTheme(
                        headline6: TextStyle(color: Color(0xFFF4B41A))),
                    hintColor: Color(0xFFF4B41A),
                    scaffoldBackgroundColor: Color(0xFFF4B41A),
                    appBarTheme: AppBarTheme(
                      backgroundColor: Color(0xFF143D59),
                      iconTheme: const IconThemeData(
                        color: Color(0xFFF4B41A),
                      ),
                      actionsIconTheme: const IconThemeData(
                        color: Color(0xFFF4B41A),
                      ),
                    ),
                  ),
                  onQueryUpdate: (s) => print(s),
                  items: product,
                  searchLabel: 'Search',
                  suggestion: const Center(
                    child: Text('Filter products by name, category or price'),
                  ),
                  failure: const Center(
                    child: Text('No products found :('),
                  ),
                  filter: (product) => [
                    product.productName,
                    product.category,
                    product.price,
                  ],
                  builder: (product) => Container(
                    decoration: const BoxDecoration(
                        color: Color(0xFFF4B41A),
                        border: Border(
                            bottom: BorderSide(
                          width: 1,
                          color: Color(0xFFF4B41A),
                        ))),
                    height: 160,
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 8, bottom: 8, left: 10, right: 10),
                      child: Row(
                        children: [
                          Material(
                            color: Color(0xFF143D59),
                            elevation: 5,
                            borderRadius: BorderRadius.circular(10),
                            child: InkWell(
                              onTap: () {
                                pushNewScreenWithRouteSettings(
                                  context,
                                  settings: const RouteSettings(
                                      name: ProductDetailsScreen.id),
                                  screen: ProductDetailsScreen(
                                    documentSnapshot: product.document,
                                  ),
                                  withNavBar: false,
                                  pageTransitionAnimation:
                                      PageTransitionAnimation.cupertino,
                                );
                              },
                              child: SizedBox(
                                height: 140,
                                width: 130,
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Hero(
                                        tag:
                                            'product${product.document!['productName']}',
                                        child: Image.network(product
                                            .document!['productImage']))),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0, top: 5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      height: 6,
                                    ),
                                    Text(
                                      product.document!['productName'],
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(
                                      height: 6,
                                    ),
                                    Text(
                                      'RM${product.document!['price']}',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
            icon: const Icon(
              CupertinoIcons.search,
              color: Color(0xFFF4B41A),
            ))
      ],
    );
  }
}
