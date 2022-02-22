// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace

import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_training_ecommerce/screens/widgets/custom_btn.dart';
import 'package:flutter_training_ecommerce/screens/widgets/custom_input.dart';
import 'package:flutter_training_ecommerce/services/firebase_services.dart';

import '../../constants.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final FirebaseServices _firebaseServices = FirebaseServices();

//Default register page loading
  bool _registerPageLoading = false;

  String _registerEmail = '';
  String _registerPassword = '';
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
      _registerPageLoading = doLoading;
    });
  }

  void _submitForm() async {
    _showLoading(true);
    String userRegistrationFeedBack = await _firebaseServices.userRegistration(
      _registerEmail,
      _registerPassword,
    );
    _showLoading(false);

    //If user registration success then head to the login page
    if (userRegistrationFeedBack == 'registration-success') {
      await _alertDialogBuilder('User registration successful');

      //After user register back to login state
      FirebaseAuth.instance.signOut();
      Navigator.pop(context);
    } else {
      _alertDialogBuilder(userRegistrationFeedBack);
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
        //This stack used for showing circular progress indicator on pressed in register button
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: double.infinity,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.only(
                        top: 24.00,
                      ),
                      child: Text(
                        'Create account',
                        style: Constants.boldFontStyle,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(
                      height: 50.0,
                    ),
                    Column(
                      children: [
                        CustomInput(
                          hintText: 'Name',
                          isSecured: false,
                        ),
                        CustomInput(
                          hintText: 'Email',
                          isSecured: false,
                          onChanged: (value) {
                            _registerEmail = value;
                          },
                          onSubmitted: (value) {
                            _passwordFocusNode!.requestFocus();
                          },
                          textInputAction: TextInputAction.next,
                        ),
                        CustomInput(
                          hintText: '+880',
                          isSecured: false,
                        ),
                        CustomInput(
                          hintText: 'Password',
                          isSecured: true,
                          focusNode: _passwordFocusNode,
                          onChanged: (value) {
                            _registerPassword = value;
                          },
                        ),
                        CustomInput(
                          hintText: 'Confirm password',
                          isSecured: true,
                        ),
                        CustomBtn(
                          text: 'Register',
                          isOutlined: false,
                          onPressed: () {
                            _submitForm();
                          },
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 130.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: CustomBtn(
                        text: 'Cancel',
                        isOutlined: true,
                        onPressed: () {
                          Navigator.pop(context);
                          // ignore: avoid_print
                          print('Cancel button pressed');
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Visibility(
              visible: _registerPageLoading,
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
