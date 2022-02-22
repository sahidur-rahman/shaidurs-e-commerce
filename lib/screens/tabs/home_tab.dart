// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_training_ecommerce/screens/product_detail.dart';
import 'package:flutter_training_ecommerce/screens/widgets/custom_action_bar.dart';
import 'package:flutter_training_ecommerce/screens/widgets/custom_card.dart';
import 'package:flutter_training_ecommerce/services/firebase_services.dart';

class HomeTab extends StatelessWidget {
  HomeTab({Key? key}) : super(key: key);

  final FirebaseServices _firebaseServices = FirebaseServices();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          FutureBuilder<QuerySnapshot>(
            future: _firebaseServices.productsRef.get(),
            builder: (context, snapshot) {
              //If stream snapshot is error then show the error in the page
              if (snapshot.hasError) {
                return Material(
                  child: Center(
                    child: Text('Error: ${snapshot.error}'),
                  ),
                );
              }

              //If connection state done means we got the data
              if (snapshot.connectionState == ConnectionState.done) {
                return ListView(
                  padding: EdgeInsets.only(top: 56.0),
                  children: snapshot.data!.docs.map((document) {
                    //Collecting single data in map
                    Map<String, dynamic> data =
                        document.data() as Map<String, dynamic>;

                    //Creating view for every data
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) =>
                                ProductDetail(productId: document.id),
                          ),
                        );
                      },
                      child: CustomCard(
                        productName: data['name'],
                        productPrice: '${data['price']}',
                        imageUrl: data['images'][0],
                      ),
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
          CustomActionBar(
            title: 'Home',
            hasBackArrow: false,
            hasTitle: true,
          ),
        ],
      ),
    );
  }
}
