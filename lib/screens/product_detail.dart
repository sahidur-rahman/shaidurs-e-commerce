// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_training_ecommerce/constants.dart';
import 'package:flutter_training_ecommerce/screens/widgets/custom_action_bar.dart';
import 'package:flutter_training_ecommerce/screens/widgets/custom_btn.dart';
import 'package:flutter_training_ecommerce/screens/widgets/custom_image_swap.dart';
import 'package:flutter_training_ecommerce/screens/widgets/product_sizes.dart';
import 'package:flutter_training_ecommerce/services/firebase_services.dart';

class ProductDetail extends StatefulWidget {
  ProductDetail({Key? key, required this.productId}) : super(key: key);
  final String productId;

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  final FirebaseServices _firebaseServices = FirebaseServices();

  String _selectedSize = '0';
  String _prPrice = '0';

  //Default Product page loading
  final bool _productPageLoading = false;

  //Show or Hide loading circle
  /* void _showLoading(bool doLoading) {
    setState(() {
      _productPageLoading = doLoading;
    });
  } */

  _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      duration: Duration(seconds: 2),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            FutureBuilder<DocumentSnapshot>(
              future: _firebaseServices.productsRef.doc(widget.productId).get(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Material(
                    child: Center(
                      child: Text('Error: ${snapshot.error}'),
                    ),
                  );
                }

                if (snapshot.connectionState == ConnectionState.done) {
                  //Collecting single data in map
                  Map<String, dynamic> data =
                      snapshot.data!.data() as Map<String, dynamic>;
                  _prPrice = data['price'];
                  return ListView(
                    padding: EdgeInsets.only(
                      left: 8.0,
                      right: 8.0,
                    ),
                    children: [
                      CustomImageSwap(imagesLink: data['images']),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 8.0,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  data['name'],
                                  style: Constants.regularFontStyle,
                                ),
                              ],
                            ),
                            Text(
                              '\$${data['price']}',
                              style: Constants.regularBoldFontRed,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 8.0,
                        ),
                        child: Text(
                          data['desc'],
                          style: TextStyle(
                            fontSize: 16.0,
                          ),
                          textAlign: TextAlign.justify,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 8.0,
                        ),
                        child: Text(
                          'Select size',
                          style: Constants.regularFontStyle,
                        ),
                      ),
                      ProductSizes(
                        sizes: data['sizes'],
                        onSelect: (size) {
                          _selectedSize = size;
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 8.0,
                          top: 12.0,
                        ),
                        child: Row(
                          children: [
                            //Item save button
                            GestureDetector(
                              onTap: () async {
                                String message =
                                    await _firebaseServices.addToSaved(
                                  widget.productId,
                                  _selectedSize,
                                );
                                _showSnackBar(message);
                              },
                              child: Container(
                                width: 60.0,
                                height: 60.0,
                                padding: EdgeInsets.symmetric(
                                  horizontal: 16.0,
                                  vertical: 12.0,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                child: Image.asset('assets/images/save.png'),
                              ),
                            ),

                            //Add to cart button
                            Expanded(
                              child: CustomBtn(
                                  text: 'Add to cart',
                                  onPressed: () async {
                                    String message =
                                        await _firebaseServices.addToCart(
                                      widget.productId,
                                      _selectedSize,
                                      _prPrice,
                                    );
                                    _showSnackBar(message);
                                  },
                                  //Show page loading
                                  /*  _showLoading(true);
                                    Timer(Duration(milliseconds: 1000), () {
                                      _showLoading(false);
                                    }); */
                                  isOutlined: false),
                            ),
                          ],
                        ),
                      ),
                    ],
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
            CustomActionBar(
              title: 'Product',
              hasBackArrow: true,
              hasTitle: false,
              hasGradient: false,
            ),
            Visibility(
              visible: _productPageLoading,
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
