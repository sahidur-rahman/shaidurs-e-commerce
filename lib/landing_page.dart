import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_training_ecommerce/screens/splash.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  double turns = 0;

  Future<void> roated() async {
    int i = 0;
    while (i < 500) {
      i++;
      await Future.delayed(Duration(microseconds: 1));
      setState(() {
        turns += 1.0 / 500.0;
      });
    }
  }

  @override
  void initState() {
    roated();
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
            SizedBox(
              height: 150.0,
              width: 150.0,
              child: AnimatedRotation(
                turns: turns,
                duration: Duration(milliseconds: 1000),
                child: Image.asset('assets/images/running-shoe.png'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
