import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bakul_app/providers/store_provider.dart';
import 'package:bakul_app/widgets/products/product_filter_widget.dart';
import 'package:bakul_app/widgets/products/product_list.dart';

class ProductListScreen extends StatelessWidget {
  const ProductListScreen({Key? key}) : super(key: key);
  static const String id = 'product-list-screen';

  @override
  Widget build(BuildContext context) {
    final _storeProvider = Provider.of<StoreProvider>(context);
    return Scaffold(
      backgroundColor: Color(0xFFF4B41A),
      body: NestedScrollView(
        headerSliverBuilder: (context, bool innerBoxIsScrolled) {
          return [
            SliverAppBar(
              backgroundColor: Color.fromARGB(255, 20, 61, 89),
              floating: true,
              snap: true,
              title: Text(
                _storeProvider.selectedCategory!,
                style: const TextStyle(
                  color: Color(0xFFF4B41A),
                ),
              ),
              iconTheme: const IconThemeData(
                color: Color(0xFFF4B41A),
              ),
              expandedHeight: 110,
              flexibleSpace: Padding(
                padding: const EdgeInsets.only(top: 88),
                child: Container(
                  height: 56,
                  color: Color(0xFFF4B41A),
                  child: const ProductFilterWidget(),
                ),
              ),
            )
          ];
        },
        body: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            children: const [ProductListWidget()]),
      ),
    );
  }
}
