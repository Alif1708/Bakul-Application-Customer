import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:bakul_app/providers/store_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class VendorAppBar extends StatefulWidget {
  const VendorAppBar({Key? key}) : super(key: key);

  @override
  State<VendorAppBar> createState() => _VendorAppBarState();
}

class _VendorAppBarState extends State<VendorAppBar> {
  double _rating = 0;
  double totalRating = 0;
  String about = 'about';
  String location = 'location';

  CollectionReference ratings =
      FirebaseFirestore.instance.collection('ratings');

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      var _store = Provider.of<StoreProvider>(context, listen: false);
      ratings
          .where('sellerId', isEqualTo: _store.selectedStoreId)
          .get()
          .then((doc) {
        for (var element in doc.docs) {
          totalRating += element['rating'];
        }
        _rating = totalRating / doc.size;
        print(_rating);
        setState(() {});
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var _store = Provider.of<StoreProvider>(context);

    return SliverAppBar(
      backgroundColor: Color.fromARGB(255, 20, 61, 89),
      floating: true,
      snap: true,
      expandedHeight: 200,
      iconTheme: const IconThemeData(color: Color.fromRGBO(244, 180, 26, 1)),
      flexibleSpace: SizedBox(
        child: Padding(
          padding: const EdgeInsets.only(top: 80),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(3.0),
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(_store.storeDetails!['imageUrl']))),
                child: Container(
                  color: Color.fromARGB(255, 20, 61, 89).withOpacity(0.7),
                  child: ListView(
                    padding: const EdgeInsets.all(10.0),
                    children: [
                      Text(
                        '${_store.storeDetails!['about']}',
                        style: const TextStyle(
                            color: Color(0xFFF4B41A),
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      ),
                      Text(
                        '${_store.storeDetails!['location']}',
                        style: const TextStyle(
                          color: Color.fromRGBO(244, 180, 26, 1),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          RatingBar.builder(
                            initialRating: _rating.isNaN ? 0 : _rating,
                            minRating: 1,
                            ignoreGestures: true,
                            itemSize: 25,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemPadding:
                                const EdgeInsets.symmetric(horizontal: 4.0),
                            itemBuilder: (context, _) => const Icon(
                              Icons.star,
                              color: Color(0xFFF4B41A),
                            ),
                            onRatingUpdate: (rating) {},
                          ),
                          Text(
                            '(${_rating.isNaN ? 0 : _rating.toStringAsFixed(1)})',
                            style: const TextStyle(color: Color(0xFFF4B41A)),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          CircleAvatar(
                              backgroundColor: Color(0xFFF4B41A),
                              child: IconButton(
                                icon: const Icon(Icons.phone),
                                color: Color.fromARGB(255, 20, 61, 89),
                                onPressed: () {
                                  _makePhoneCall(
                                      _store.storeDetails!['mobile']);
                                },
                              )),
                          const SizedBox(
                            width: 3,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      title: Text(
        _store.storeDetails!['shopName'],
        style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Color.fromRGBO(244, 180, 26, 1)),
      ),
    );
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    // Use `Uri` to ensure that `phoneNumber` is properly URL-encoded.
    // Just using 'tel:$phoneNumber' would create invalid URLs in some cases,
    // such as spaces in the input, which would cause `launch` to fail on some
    // platforms.
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launch(launchUri.toString());
  }
}
