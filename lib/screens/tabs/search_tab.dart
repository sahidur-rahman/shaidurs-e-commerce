// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_training_ecommerce/screens/widgets/custom_card.dart';
import 'package:flutter_training_ecommerce/screens/widgets/custom_input.dart';
import 'package:flutter_training_ecommerce/services/firebase_services.dart';

import '../../constants.dart';
import '../product_detail.dart';

class SearchTab extends StatefulWidget {
  SearchTab({Key? key}) : super(key: key);

  @override
  State<SearchTab> createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  final FirebaseServices _firebaseServices = FirebaseServices();
  String _searchKey = '_';

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          FutureBuilder<QuerySnapshot>(
            future: _firebaseServices.productsRef
                .orderBy('name')
                .startAt([_searchKey]).endAt(['$_searchKey\uf8ff']).get(),
            /* endAt(['\uf8ff$_searchKey\uf8ff']).get(), */
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
                  padding: EdgeInsets.only(top: 100.0),
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
          Container(
            height: 125.0,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.white,
                  Colors.white.withOpacity(0.8),
                  Colors.white.withOpacity(0.7),
                  Colors.white.withOpacity(0.6),
                  Colors.white.withOpacity(0),
                ],
                begin: Alignment(0, 0),
                end: Alignment(0, 1),
              ),
            ),
            child: Column(
              children: [
                CustomInput(
                  hintText: 'Search here...',
                  isSecured: false,
                  onChanged: (value) {
                    setState(() {
                      _searchKey = value;
                    });
                  },
                ),
                Container(
                  height: 32.0,
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.center,
                  child: Text(
                    'Search result',
                    style: Constants.semiRegularFontStyle,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
