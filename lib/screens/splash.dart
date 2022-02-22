// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_training_ecommerce/constants.dart';
import 'package:flutter_training_ecommerce/screens/auth/login.dart';
import 'package:flutter_training_ecommerce/screens/home.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        //If initialization has any error
        if (snapshot.hasError) {
          return Material(
            child: Center(
              child: Text('Error: ${snapshot.error}'),
            ),
          );
        }

        //Connection done
        if (snapshot.connectionState == ConnectionState.done) {
          //StreamBuilder can check login state live, so we don't need to check login again and again
          return StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, streamSnapshot) {
              //If stream snapshot is error
              if (streamSnapshot.hasError) {
                return Material(
                  child: Center(
                    child: Text('Error: ${streamSnapshot.error}'),
                  ),
                );
              }

              // If the connection state alive then check user authentication
              if (streamSnapshot.connectionState == ConnectionState.active) {
                //If user is null then user is not logged in
                Object? _user = streamSnapshot.data;
                if (_user == null) {
                  return LoginPage();
                } else {
                  //The user is logged in, head to the home page
                  return HomePage();
                }
              }

              //Loading for checking connection state
              return const Material(
                child: Center(
                  child: Text(
                    'Checking connection state....',
                    style: Constants.regularFontStyle,
                  ),
                ),
              );
            },
          );
        }

        //Waiting for connection state
        return const Material(
          child: Center(
            child: Text('Initializing app....'),
          ),
        );
      },
    );
  }
}
