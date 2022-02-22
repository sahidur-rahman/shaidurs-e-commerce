// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_training_ecommerce/constants.dart';
import 'package:flutter_training_ecommerce/screens/cart_detail.dart';
import 'package:flutter_training_ecommerce/services/firebase_services.dart';

class CustomActionBar extends StatelessWidget {
  CustomActionBar({
    Key? key,
    required this.title,
    required this.hasBackArrow,
    required this.hasTitle,
    this.hasGradient = true,
    this.hasCartBtnClbl = true,
  }) : super(key: key);

  final String title;
  final bool hasBackArrow;
  final bool hasTitle;
  final bool hasGradient;
  final bool hasCartBtnClbl;

  final FirebaseServices _firebaseServices = FirebaseServices();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: hasGradient
            ? LinearGradient(
                colors: [
                  Colors.white,
                  Colors.white.withOpacity(0),
                ],
                begin: Alignment(0, 0),
                end: Alignment(0, 1),
              )
            : null,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 20.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (hasBackArrow)
            GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: Container(
                height: 36.0,
                width: 36.0,
                padding: EdgeInsets.all(2.0),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Image(
                  image: AssetImage('assets/images/left_back.png'),
                  color: Colors.white,
                ),
              ),
            ),
          if (hasTitle)
            Text(
              title,
              style: Constants.boldFontStyle,
            ),
          GestureDetector(
            onTap: () {
              hasCartBtnClbl
                  ? Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => CartDetail(),
                      ),
                    )
                  : null;
            },
            child: Container(
              height: 36.0,
              width: 36.0,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: StreamBuilder<QuerySnapshot>(
                stream: _firebaseServices.usersRef
                    .doc(_firebaseServices.getUserID())
                    .collection('Cart')
                    .snapshots(),
                builder: (context, snapshot) {
                  int _totalItems = 0;

                  if (snapshot.connectionState == ConnectionState.active) {
                    List _documents = snapshot.data?.docs as List;
                    _totalItems = _documents.length;
                  }

                  return Text(
                    '$_totalItems',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
