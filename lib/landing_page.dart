import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_training_ecommerce/screens/splash.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  void initState() {
    Timer(Duration(milliseconds: 3000), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => SplashScreen(),
        ),
      );
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/welcome-to.png'),
            Image.asset('assets/images/e-shoes.png'),
            Image.asset('assets/images/running-shoe.png'),
          ],
        ),
      ),
    );
  }
}
