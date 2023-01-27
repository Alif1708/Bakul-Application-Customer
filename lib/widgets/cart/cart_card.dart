import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:bakul_app/widgets/cart/counter.dart';

class CartCard extends StatelessWidget {
  const CartCard({Key? key, required this.document}) : super(key: key);
  final DocumentSnapshot document;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Color(0xFFF4B41A),
          border: Border(
              bottom: BorderSide(
            color: Color(0xFF143D59),
          ))),
      height: 120,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(children: [
          Positioned(
              right: 0.0,
              bottom: 0.0,
              child: CounterForCard(
                documentSnapshot: document,
              )),
          Row(
            children: [
              SizedBox(
                height: 120,
                width: 120,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.network(document['productImage']),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(document['productName']),
                  const SizedBox(
                    height: 30,
                  ),
                  Text(
                    'RM${document['price']}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              )
            ],
          ),
        ]),
      ),
    );
  }
}
