// ignore_for_file: prefer_const_constructors, duplicate_ignore, sized_box_for_whitespace

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_training_ecommerce/screens/auth/register.dart';
import 'package:flutter_training_ecommerce/screens/widgets/custom_btn.dart';
import 'package:flutter_training_ecommerce/screens/widgets/custom_input.dart';
import 'package:flutter_training_ecommerce/services/firebase_services.dart';

import '../../constants.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseServices _firebaseServices = FirebaseServices();

//Default register page loading
  bool _loginPageLoading = false;

  String _loginEmail = '';
  String _loginPassword = '';
  FocusNode? _passwordFocusNode;

  Future<void> _alertDialogBuilder(String msg) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(msg),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  //Show or Hide loading circle
  void _showLoading(bool doLoading) {
    setState(() {
      _loginPageLoading = doLoading;
    });
  }

  void _submitForm() async {
    _showLoading(true);
    String userLoginFeedBack =
        await _firebaseServices.userLogin(_loginEmail, _loginPassword);
    _showLoading(false);

    //Check user login state and firebase auth automatically get head to homepage if user login succes
    if (userLoginFeedBack != 'login-success') {
      _alertDialogBuilder(userLoginFeedBack);
    }
  }

  @override
  void initState() {
    _passwordFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _passwordFocusNode!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  // ignore: prefer_const_constructors
                  Container(
                    padding: EdgeInsets.only(
                      top: 24.00,
                    ),
                    child: Text(
                      'Welcome user,\nLogin to your account',
                      style: Constants.boldFontStyle,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Column(
                    children: [
                      CustomInput(
                        hintText: 'Email',
                        isSecured: false,
                        onChanged: (value) {
                          _loginEmail = value;
                        },
                        onSubmitted: (value) {
                          _passwordFocusNode!.requestFocus();
                        },
                        textInputAction: TextInputAction.next,
                      ),
                      CustomInput(
                        hintText: 'Password',
                        isSecured: true,
                        focusNode: _passwordFocusNode,
                        onChanged: (value) {
                          _loginPassword = value;
                        },
                      ),
                      CustomBtn(
                        text: 'Login',
                        isOutlined: false,
                        onPressed: () {
                          _submitForm();
                        },
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: CustomBtn(
                      text: 'Create new account',
                      isOutlined: true,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RegisterPage(),
                          ),
                        );
                        // ignore: avoid_print
                        print('Create new account button pressed');
                      },
                    ),
                  ),
                ],
              ),
            ),
            Visibility(
              visible: _loginPageLoading,
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                color: Colors.black45,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
