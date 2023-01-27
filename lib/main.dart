import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:bakul_app/providers/auth_provider.dart';
import 'package:bakul_app/providers/cart_provider.dart';
import 'package:bakul_app/providers/order_provider.dart';
import 'package:bakul_app/providers/store_provider.dart';
import 'package:bakul_app/screens/home_screen.dart';
import 'package:bakul_app/screens/login_screen.dart';
import 'package:bakul_app/screens/main_screen.dart';
import 'package:bakul_app/screens/my_orders_screen.dart';
import 'package:bakul_app/screens/my_rating_screen.dart';
import 'package:bakul_app/screens/payment/create_new_card_screen.dart';
import 'package:bakul_app/screens/payment/credit_card_ilst.dart';
import 'package:bakul_app/screens/payment/stripe/existing-cards.dart';
import 'package:bakul_app/screens/payment/stripe/home.dart';
import 'package:bakul_app/screens/product_details_screen.dart';
import 'package:bakul_app/screens/product_list_screen.dart';
import 'package:bakul_app/screens/profile_screen.dart';
import 'package:bakul_app/screens/profile_update_screen.dart';
import 'package:bakul_app/screens/rating_screen.dart';
import 'package:bakul_app/screens/register_screen.dart';
import 'package:bakul_app/screens/splash_screen.dart';
import 'package:bakul_app/screens/vendor_home_screen.dart';
import 'package:bakul_app/screens/welcome_screen.dart';

Future<void> main() async {
  // Initialize Firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthProvider()),
        ChangeNotifierProvider(create: (context) => StoreProvider()),
        ChangeNotifierProvider(create: (context) => CartProvider()),
        ChangeNotifierProvider(create: (context) => OrderProvider()),
      ],
      child: MaterialApp(
        theme: ThemeData(
          scaffoldBackgroundColor: Color(0xFFF4B41A),
        ),
        initialRoute: SplashScreen.id,
        routes: {
          SplashScreen.id: (context) => const SplashScreen(),
          HomeScreen.id: (context) => const HomeScreen(),
          WelcomeScreen.id: (context) => const WelcomeScreen(),
          MainScreen.id: (context) => MainScreen(),
          RegisterScreen.id: (context) => const RegisterScreen(),
          VendorHomeScreen.id: (context) => const VendorHomeScreen(),
          ProductListScreen.id: (context) => const ProductListScreen(),
          ProductDetailsScreen.id: (context) => const ProductDetailsScreen(),
          ProfileScreen.id: (context) => const ProfileScreen(),
          UpdateProfile.id: (context) => const UpdateProfile(),
          ExistingCardsPage.id: (context) => const ExistingCardsPage(),
          StripeHomePage.id: (context) => const StripeHomePage(),
          MyOrders.id: (context) => const MyOrders(),
          CreditCardList.id: (context) => const CreditCardList(),
          CreateNewCreditCard.id: (context) => const CreateNewCreditCard(),
          RatingScreen.id: (context) => RatingScreen(),
          MyRatingScreen.id: (context) => MyRatingScreen(),
          LoginScreen.id: (context) => const LoginScreen(),
        },
        builder: EasyLoading.init(),
      ),
    );
  }
}
