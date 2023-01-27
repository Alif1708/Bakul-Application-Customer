import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import 'package:bakul_app/providers/cart_provider.dart';
import 'package:bakul_app/screens/cart_screen.dart';
import 'package:bakul_app/services/cart_services.dart';

class CartNotification extends StatefulWidget {
  const CartNotification({Key? key}) : super(key: key);

  @override
  _CartNotificationState createState() => _CartNotificationState();
}

class _CartNotificationState extends State<CartNotification> {
  final CartServices _cartServices = CartServices();
  DocumentSnapshot? document;
  @override
  Widget build(BuildContext context) {
    final _cartProvider = Provider.of<CartProvider>(context);
    _cartProvider.getCartTotal();
    _cartServices.getShopName().then((value) {
      setState(() {
        document = value;
      });
    });

    return Visibility(
      visible: _cartProvider.cartQty > 0 ? true : false,
      child: Container(
        height: 45,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
            color: Colors.orange,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(12), topLeft: Radius.circular(12))),
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          '${_cartProvider.cartQty} ${_cartProvider.cartQty == 1 ? 'Item' : 'Items'}',
                          style: const TextStyle(
                              color: Color(0xFF143D59),
                              fontWeight: FontWeight.bold),
                        ),
                        const Text(
                          ' | ',
                          style: TextStyle(color: Color(0xFF143D59)),
                        ),
                        Text(
                          'RM${_cartProvider.subTotal.toStringAsFixed(0)}',
                          style: const TextStyle(
                              color: Color(0xFF143D59),
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    if (document != null)
                      if (document!.exists)
                        Text(
                          'From ${document!['shopName']}',
                          style: const TextStyle(
                              color: Color(0xFF143D59), fontSize: 10),
                        ),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  pushNewScreenWithRouteSettings(
                    context,
                    settings: const RouteSettings(name: CartScreen.id),
                    screen: CartScreen(
                      document: document,
                    ),
                    withNavBar: false,
                    pageTransitionAnimation: PageTransitionAnimation.cupertino,
                  );
                },
                child: Row(
                  children: const [
                    Text(
                      'View Cart',
                      style: TextStyle(
                          color: Color(0xFF143D59),
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Icon(
                      Icons.shopping_bag_outlined,
                      color: Color(0xFF143D59),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
