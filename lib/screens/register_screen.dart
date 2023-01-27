import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:provider/provider.dart';
import 'package:bakul_app/providers/auth_provider.dart';
import 'package:bakul_app/screens/main_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);
  static const String id = 'register-screen';

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _emailTextEditingController = TextEditingController();
  final _firstNameTextEditingController = TextEditingController();
  final _lastNameTextEditingController = TextEditingController();
  final _passwordTextEditingController = TextEditingController();
  final _confirmPasswordTextEditingController = TextEditingController();
  final _phoneNumberTextEditingController = TextEditingController();
  bool _obsecure1 = true;
  bool _obsecure2 = true;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final _auth = Provider.of<AuthProvider>(context);
    return Scaffold(
      backgroundColor: Color.fromRGBO(
        244,
        180,
        26,
        1,
      ),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 20, 61, 89),
        title: const Text(
          'Register',
          style: TextStyle(color: Color.fromRGBO(244, 180, 26, 1)),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(50.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Register',
                        style: TextStyle(
                          fontSize: 50,
                          color: Color.fromARGB(255, 20, 61, 89),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Image.asset('images/bakullogo2.png', height: 80),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.name,
                    controller: _emailTextEditingController,
                    decoration: InputDecoration(
                      helperStyle: const TextStyle(color: Colors.red),
                      prefixIcon: const Icon(
                        Icons.email,
                      ),
                      labelText: "Email",
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: const BorderSide(),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter Rmail';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    keyboardType: TextInputType.name,
                    controller: _firstNameTextEditingController,
                    decoration: InputDecoration(
                      helperStyle: const TextStyle(color: Colors.red),
                      prefixIcon: const Icon(Icons.person),
                      labelText: "First Name",
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: const BorderSide(),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter First Name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    keyboardType: TextInputType.name,
                    controller: _lastNameTextEditingController,
                    decoration: InputDecoration(
                      helperStyle: const TextStyle(color: Colors.red),
                      prefixIcon: const Icon(Icons.person),
                      labelText: "Last Name",
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: const BorderSide(),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter Last Name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    controller: _phoneNumberTextEditingController,
                    decoration: InputDecoration(
                      helperStyle: const TextStyle(color: Colors.red),
                      prefixIcon: const Icon(Icons.person),
                      labelText: "Phone Number",
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: const BorderSide(),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter Phone Number';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    obscureText: _obsecure1,
                    keyboardType: TextInputType.name,
                    controller: _passwordTextEditingController,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        icon: _obsecure1
                            ? const Icon(Icons.visibility)
                            : const Icon(Icons.visibility_off),
                        onPressed: () {
                          setState(() {
                            _obsecure1 = !_obsecure1;
                          });
                        },
                      ),
                      prefixIcon: const Icon(Icons.vpn_key),
                      labelText: "Password",
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: const BorderSide(),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter Password';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    obscureText: _obsecure2,
                    keyboardType: TextInputType.name,
                    controller: _confirmPasswordTextEditingController,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        icon: _obsecure2
                            ? const Icon(Icons.visibility)
                            : const Icon(Icons.visibility_off),
                        onPressed: () {
                          setState(() {
                            _obsecure2 = !_obsecure2;
                          });
                        },
                      ),
                      prefixIcon: const Icon(Icons.vpn_key),
                      labelText: "Confirm Password",
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: const BorderSide(),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter Password';
                      } else if (value != _passwordTextEditingController.text) {
                        return 'The password is not same';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 30),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: const Color.fromARGB(255, 20, 61, 89),
                          ),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              EasyLoading.show(status: 'loading...');

                              _auth
                                  .signInWithEmail(
                                      email: _emailTextEditingController.text,
                                      password:
                                          _passwordTextEditingController.text,
                                      firstName:
                                          _firstNameTextEditingController.text,
                                      lastName:
                                          _lastNameTextEditingController.text,
                                      number: _phoneNumberTextEditingController
                                          .text)
                                  .then((value) {
                                if (value == null) {
                                  _showMyDialog(
                                      message: _auth.error, tittle: 'ERROR');
                                } else {
                                  _auth.createUser(
                                      id: value.user!.uid,
                                      number: _phoneNumberTextEditingController
                                          .text,
                                      firstName:
                                          _firstNameTextEditingController.text,
                                      lastName:
                                          _lastNameTextEditingController.text,
                                      email: _emailTextEditingController.text);

                                  Navigator.pushNamedAndRemoveUntil(
                                      context, MainScreen.id, (route) => false);
                                }

                                EasyLoading.dismiss();
                              });
                            }
                          },
                          child: const Text(
                            'Register',
                            style: TextStyle(
                                color: Color.fromRGBO(244, 180, 26, 1)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _showMyDialog(
      {required String message, required String tittle}) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(tittle),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(message),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
