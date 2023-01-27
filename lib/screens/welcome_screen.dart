import 'package:flutter/material.dart';

import 'package:bakul_app/screens/login_screen.dart';
import 'package:bakul_app/screens/onboard_screen.dart';
import 'package:bakul_app/screens/register_screen.dart';

class WelcomeScreen extends StatelessWidget {
  static const String id = 'welcome-screen';
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var loginTextButton = TextButton(
      child: RichText(
        text: const TextSpan(
          text: 'Already a Buyer ? ',
          style: TextStyle(color: Color.fromARGB(255, 20, 61, 89)),
          children: [
            TextSpan(
              text: 'LOGIN',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 20, 61, 89)),
            ),
          ],
        ),
      ),
      onPressed: () {
        Navigator.pushNamed(context, LoginScreen.id);
      },
    );

    var elvtBtnSetDeliveryLocation = ElevatedButton(
      child: const Text(
        'CLICK HERE TO REGISTER',
        style: TextStyle(color: Color(0xFFF4B41A)),
      ),
      style: TextButton.styleFrom(
          primary: Colors.black,
          elevation: 0,
          backgroundColor: Color.fromARGB(255, 20, 61, 89)),
      onPressed: () {
        Navigator.pushNamed(context, RegisterScreen.id);
      },
    );

    var text1 = const Text(
      'Do not have an account yet?',
      style: TextStyle(color: Color(0xFF143D59)),
    );

    return Scaffold(
      backgroundColor: Color(0xFFF4B41A),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Expanded(child: OnBoardScreen()),
                text1,
                const SizedBox(height: 10),
                elvtBtnSetDeliveryLocation,
                const SizedBox(height: 20),
                loginTextButton
              ],
            ),
          ],
        ),
      ),
    );
  }
}
