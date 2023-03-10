import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bakul_app/providers/store_provider.dart';
import 'package:bakul_app/services/product_services.dart';
import 'package:bakul_app/widgets/products/product_card.widget.dart';

class RecentlyAdded extends StatelessWidget {
  const RecentlyAdded({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ProductServices _productServices = ProductServices();
    final _storeProvider = Provider.of<StoreProvider>(context);
    return FutureBuilder<QuerySnapshot>(
      future: _productServices.products
          .where('published', isEqualTo: true)
          .where('collection', isEqualTo: 'Recently Added')
          .orderBy('productName')
          .where('seller.sellerUid',
              isEqualTo: _storeProvider.storeDetails!['uid'])
          .limitToLast(10)
          .get(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong...');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.data!.docs.isEmpty) {
          return Container();
        }
        if (!snapshot.hasData) {
          return Container();
        }
        return Column(children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Material(
              elevation: 4,
              borderRadius: BorderRadius.circular(4),
              child: Container(
                height: 56,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 20, 61, 89),
                    borderRadius: BorderRadius.circular(4)),
                child: const Center(
                  child: Text(
                    'Recently Added',
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
          ListView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: snapshot.data!.docs.map((document) {
              return ProductCard(document: document);
            }).toList(),
          ),
        ]);
      },
    );
  }
}
