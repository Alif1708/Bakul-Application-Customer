// ignore_for_file: unnecessary_const

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expandable_text/expandable_text.dart';

import 'package:flutter/material.dart';
import 'package:bakul_app/widgets/bottom_sheet_container.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({Key? key, this.documentSnapshot})
      : super(key: key);
  static const String id = 'product-details-screen';
  final DocumentSnapshot? documentSnapshot;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(244, 180, 26, 1),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 20, 61, 89),
        iconTheme: const IconThemeData(
          color: Color.fromRGBO(244, 180, 26, 1),
        ),
        title: const Text(
          'Product Detail',
          style: TextStyle(
            color: Color(0xFFF4B41A),
          ),
        ),
        centerTitle: true,
      ),
      bottomSheet: BotttomSheetContainer(
        documentSnapshot: documentSnapshot!,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                const Icon(Icons.inventory),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  documentSnapshot!['productName'],
                  style: const TextStyle(fontSize: 22),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                const SizedBox(
                  width: 35,
                ),
                Text(
                  'RM${documentSnapshot!['price']}',
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Hero(
                  tag: 'product${documentSnapshot!['productName']}',
                  child: Image.network(documentSnapshot!['productImage'])),
            ),
            Divider(
              color: Colors.black,
              thickness: 6,
            ),
            Padding(
                padding: const EdgeInsets.only(top: 8, bottom: 8),
                child: Row(
                  children: const [
                    Icon(Icons.description),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Product Description',
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                )),
            Divider(
              color: Colors.black,
            ),
            Padding(
              padding:
                  const EdgeInsets.only(top: 8, bottom: 8, left: 10, right: 10),
              child: ExpandableText(
                documentSnapshot!['description'],
                expandText: 'View more',
                collapseText: 'View less',
                maxLines: 2,
                style: const TextStyle(color: Color.fromARGB(255, 20, 61, 89)),
              ),
            ),
            Divider(
              color: Colors.black,
            ),
            Padding(
                padding: const EdgeInsets.only(top: 8, bottom: 8),
                child: Row(
                  children: const [
                    Icon(Icons.info),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Product Seller',
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                )),
            Divider(
              color: Colors.black,
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 10, right: 10, top: 8, bottom: 8),
              child: Text(
                'Seller : ${documentSnapshot!['seller']['shopName']}',
                style: const TextStyle(color: Color.fromARGB(255, 20, 61, 89)),
              ),
            ),
            const SizedBox(
              height: 60,
            )
          ],
        ),
      ),
    );
  }
}
