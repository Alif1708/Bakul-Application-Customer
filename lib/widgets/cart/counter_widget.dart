import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:bakul_app/services/cart_services.dart';
import 'package:bakul_app/widgets/products/add_to_cart_widget.dart';

class CounterWidget extends StatefulWidget {
  const CounterWidget(
      {Key? key,
      required this.documentSnapshot,
      required this.qty,
      required this.docId})
      : super(key: key);
  final DocumentSnapshot documentSnapshot;
  final String docId;

  final int qty;

  @override
  _CounterWidgetState createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  final CartServices _cartServices = CartServices();
  int _qty = 1;
  bool _updating = false;
  bool _exist = true;

  @override
  Widget build(BuildContext context) {
    setState(() {
      _qty = widget.qty;
    });
    return _exist
        ? Container(
            margin: const EdgeInsets.only(left: 20, right: 20),
            height: 56,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: FittedBox(
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {
                          if (_qty == 1) {
                            _cartServices
                                .removeFromCart(widget.docId)
                                .then((value) {
                              setState(() {
                                _updating = false;
                                _exist = false;
                              });
                              _cartServices.checkData();
                            });
                          }
                          if (_qty > 1) {
                            setState(() {
                              _updating = true;
                            });
                            setState(() {
                              _qty--;
                            });
                          }
                          var total = _qty *
                              double.parse(widget.documentSnapshot['price']);
                          _cartServices
                              .updateCartQty(widget.docId, _qty, total)
                              .then((value) {
                            _updating = false;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.red),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              _qty == 1 ? Icons.delete_outline : Icons.remove,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, top: 8, bottom: 8),
                        child: _updating
                            ? const SizedBox(
                                height: 24,
                                width: 24,
                                child: CircularProgressIndicator())
                            : Text(
                                _qty.toString(),
                                style: const TextStyle(color: Colors.red),
                              ),
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            _qty++;
                            _updating = true;
                          });
                          var total = _qty *
                              double.parse(widget.documentSnapshot['price']);
                          _cartServices
                              .updateCartQty(widget.docId, _qty, total)
                              .then((value) {
                            _updating = false;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.red),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.add,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        : AddToCartWidget(documentSnapshot: widget.documentSnapshot);
  }
}
