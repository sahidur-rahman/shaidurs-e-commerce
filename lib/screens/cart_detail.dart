// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_training_ecommerce/screens/widgets/custom_action_bar.dart';
import 'package:flutter_training_ecommerce/screens/widgets/custom_cart_checkout.dart';
import 'package:flutter_training_ecommerce/screens/widgets/custom_cart_saved.dart';
import 'package:flutter_training_ecommerce/services/firebase_services.dart';

class CartDetail extends StatefulWidget {
  CartDetail({
    Key? key,
  }) : super(key: key);
  //final String productId;

  @override
  State<CartDetail> createState() => _CartDetailState();
}

class _CartDetailState extends State<CartDetail> {
  final FirebaseServices _firebaseServices = FirebaseServices();

  void reLoadState() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            FutureBuilder<QuerySnapshot>(
              future: _firebaseServices.usersRef
                  .doc(_firebaseServices.getUserID())
                  .collection('Cart')
                  .get(),
              builder: (context, snapshot) {
                //If stream snapshot is error then show the error in the page
                if (snapshot.hasError) {
                  return Material(
                    child: Center(
                      child: Text('Error: ${snapshot.error}'),
                    ),
                  );
                }

                ///If connection state done means we got the data
                if (snapshot.connectionState == ConnectionState.done) {
                  //_totalCartPrice = Stream.value(_totalPrice);
                  return ListView(
                    padding: EdgeInsets.only(top: 64.0),
                    children: snapshot.data!.docs.map((document) {
                      //Collecting single data in map
                      Map<String, dynamic> dataItem =
                          document.data() as Map<String, dynamic>;

                      //Creating view for every data

                      return FutureBuilder<DocumentSnapshot>(
                        future: _firebaseServices.productsRef
                            .doc(document.id)
                            .get(),
                        builder: (context, productSnapshot) {
                          //If stream snapshot is error then show the error in the page
                          if (productSnapshot.hasError) {
                            return Material(
                              child: Center(
                                child: Text('Error: ${productSnapshot.error}'),
                              ),
                            );
                          }

                          if (productSnapshot.connectionState ==
                              ConnectionState.done) {
                            Map<String, dynamic> data = productSnapshot.data!
                                .data() as Map<String, dynamic>;

                            return CustomCartSaved(
                              data: data,
                              size: '${dataItem['size']}',
                              docId: document.id,
                              onDelete: (docId) {
                                _firebaseServices.removeFromCart(docId);
                                reLoadState();
                              },
                            );
                          }

                          //Showing loading for getting data
                          return Material(
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        },
                      );
                    }).toList(),
                  );
                }

                //Showing loading for getting data
                return Material(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              },
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomActionBar(
                  title: 'Cart',
                  hasBackArrow: true,
                  hasTitle: true,
                  hasCartBtnClbl: false,
                ),
                CustomCartCheckout(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
