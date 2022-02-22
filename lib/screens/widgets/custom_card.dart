// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_training_ecommerce/constants.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({
    Key? key,
    required this.productName,
    required this.productPrice,
    required this.imageUrl,
  }) : super(key: key);

  final String productName;
  final String productPrice;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350.0,
      padding: EdgeInsets.symmetric(
        horizontal: 12.0,
        vertical: 12.0,
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Card(
            color: Colors.transparent,
            elevation: 10.0,
            shadowColor: Colors.black,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              margin: EdgeInsets.all(4.0),
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  12.0,
                ),
                gradient: LinearGradient(
                  colors: [
                    Colors.white.withOpacity(0),
                    Colors.white,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    productName,
                    style: Constants.regularFontStyle,
                  ),
                  Text(
                    '\$$productPrice',
                    style: Constants.regularBoldFontRed,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
