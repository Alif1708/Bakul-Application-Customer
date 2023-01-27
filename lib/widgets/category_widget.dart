import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import 'package:bakul_app/providers/store_provider.dart';
import 'package:bakul_app/screens/product_list_screen.dart';

import 'package:bakul_app/services/product_services.dart';

class VendorCategories extends StatefulWidget {
  const VendorCategories({Key? key}) : super(key: key);

  @override
  _VendorCategoriesState createState() => _VendorCategoriesState();
}

class _VendorCategoriesState extends State<VendorCategories> {
  final ProductServices _productServices = ProductServices();
  final List _catList = [];

  @override
  void didChangeDependencies() {
    var _store = Provider.of<StoreProvider>(context);

    FirebaseFirestore.instance
        .collection('products')
        .where('seller.sellerUid', isEqualTo: _store.storeDetails!['uid'])
        .get()
        .then((querySnapshot) {
      for (var element in querySnapshot.docs) {
        setState(() {
          _catList.add(element['category']['mainCategory']);
        });
      }
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final _storeProvider = Provider.of<StoreProvider>(context);

    return FutureBuilder(
      future: _productServices.category.get(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Center(
            child: Text('Something went wrong...'),
          );
        }
        if (_catList.isEmpty) {
          return Container();
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (!snapshot.hasData) {
          return Container();
        }
        return SingleChildScrollView(
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: Material(
                elevation: 4,
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  height: 60,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 20, 61, 89),
                      borderRadius: BorderRadius.circular(4)),
                  child: const Center(
                    child: Text(
                      'Choose by Category',
                      style: TextStyle(
                          shadows: <Shadow>[
                            Shadow(
                                offset: Offset(2.0, 2.0),
                                blurRadius: 3.0,
                                color: Colors.black)
                          ],
                          color: Color(0xFFF4B41A),
                          fontWeight: FontWeight.bold,
                          fontSize: 30),
                    ),
                  ),
                ),
              ),
            ),
            Wrap(
              direction: Axis.horizontal,
              children: snapshot.data!.docs.map((document) {
                return _catList.contains(document['categoryName'])
                    ? InkWell(
                        onTap: () {
                          _storeProvider
                              .setSelectedCategory(document['categoryName']);
                          _storeProvider.setSelectedSubCategory(null);
                          pushNewScreenWithRouteSettings(
                            context,
                            settings:
                                const RouteSettings(name: ProductListScreen.id),
                            screen: const ProductListScreen(),
                            withNavBar: true,
                            pageTransitionAnimation:
                                PageTransitionAnimation.cupertino,
                          );
                        },
                        child: SizedBox(
                          width: 120,
                          height: 110,
                          child: Container(
                            decoration: BoxDecoration(
                                color: Color(0xFF143D59),
                                border:
                                    Border.all(color: Colors.grey, width: 0.5)),
                            child: Column(
                              children: [
                                Center(
                                  child: Image.network(
                                    document['image'],
                                    fit: BoxFit.cover,
                                    height: 90,
                                    width: 110,
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 8, right: 8),
                                  child: Text(
                                    document['categoryName'],
                                    textAlign: TextAlign.center,
                                    style: TextStyle(color: Color(0xFFF4B41A)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    : const Text('');
              }).toList(),
            ),
          ]),
        );
      },
    );
  }
}
