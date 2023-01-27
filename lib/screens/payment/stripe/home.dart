import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:bakul_app/providers/order_provider.dart';
import 'package:bakul_app/screens/payment/create_new_card_screen.dart';
import 'package:bakul_app/screens/payment/stripe/existing-cards.dart';

import 'package:bakul_app/services/payment-service.dart';

class StripeHomePage extends StatefulWidget {
  const StripeHomePage({Key? key}) : super(key: key);
  static const String id = 'stripe-home-page';

  @override
  StripeHomePageState createState() => StripeHomePageState();
}

class StripeHomePageState extends State<StripeHomePage> {
  onItemPress(BuildContext context, int index, amount, orderProvider) async {
    switch (index) {
      case 0:
        Navigator.pushNamed(context, CreateNewCreditCard.id);
        break;
      case 1:
        payViaNewCard(context, amount, orderProvider);
        break;
      case 2:
        Navigator.pushNamed(context, ExistingCardsPage.id);
        break;
    }
  }

  payViaNewCard(
      BuildContext context, amount, OrderProvider orderProvider) async {
    await EasyLoading.show(status: 'Please Wait...');
    var response = await StripeService.payWithNewCard(
        amount: '${amount.toString()}00', currency: 'MYR');
    if (response!.success) {
      orderProvider.success = response.success;
    }
    await EasyLoading.dismiss();
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(
          content: Text(response.message),
          duration: Duration(milliseconds: 5000),
        ))
        .closed
        .then((_) {
      Navigator.pop(context);
      Navigator.pop(context);
    });
  }

  @override
  void initState() {
    super.initState();
    StripeService.init();
  }

  @override
  Widget build(BuildContext context) {
    final orderProvider = Provider.of<OrderProvider>(context);
    ThemeData theme = Theme.of(context);
    return Scaffold(
      backgroundColor: Color(0xFFF4B41A),
      appBar: AppBar(
        backgroundColor: Color(0xFF143D59),
        iconTheme: const IconThemeData(
          color: Color(0xFFF4B41A),
        ),
        title: const Text(
          'Home',
          style: TextStyle(color: Color(0xFFF4B41A)),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: ListView.separated(
            shrinkWrap: true,
            itemBuilder: (context, index) {
              Icon? icon;
              Text? text;

              switch (index) {
                case 0:
                  icon = Icon(Icons.add_circle, color: Color(0xFF143D59));
                  text = const Text('Add Cards');
                  break;
                case 1:
                  icon = Icon(Icons.credit_card_outlined,
                      color: Color(0xFF143D59));
                  text = const Text('Pay via new card');
                  break;
                case 2:
                  icon = Icon(Icons.credit_card, color: Color(0xFF143D59));
                  text = const Text('Pay via existing card');
                  break;
              }

              return InkWell(
                onTap: () {
                  onItemPress(
                      context, index, orderProvider.amount, orderProvider);
                },
                child: ListTile(
                  title: text,
                  leading: icon,
                ),
              );
            },
            separatorBuilder: (context, index) => Divider(
                  color: Color(0xFF143D59),
                ),
            itemCount: 3),
      ),
    );
  }
}
