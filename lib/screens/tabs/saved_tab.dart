// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_training_ecommerce/screens/widgets/custom_action_bar.dart';
import 'package:flutter_training_ecommerce/screens/widgets/custom_cart_saved.dart';
import 'package:flutter_training_ecommerce/services/firebase_services.dart';

class SavedTab extends StatefulWidget {
  const SavedTab({Key? key}) : super(key: key);

  @override
  State<SavedTab> createState() => _SavedTabState();
}

class _SavedTabState extends State<SavedTab> {
  final FirebaseServices _firebaseServices = FirebaseServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            FutureBuilder<QuerySnapshot>(
              future: _firebaseServices.usersRef
                  .doc(_firebaseServices.getUserID())
                  .collection('Saved')
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
                              size: dataItem['size'],
                              docId: document.id,
                              onDelete: (docId) {
                                setState(() {
                                  _firebaseServices.removeFromSaved(docId);
                                });
                              },
                            );
                            /*  return Container(
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                color: Colors.black12,
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              margin: EdgeInsets.only(
                                bottom: 12.0,
                                left: 8.0,
                                right: 8.0,
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: 120.0,
                                    height: 120.0,
                                    margin: EdgeInsets.only(right: 8.0),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(12.0),
                                      child: Image.network(
                                        data['images'][0],
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                      child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        data['name'],
                                        style: Constants.regularFontStyle,
                                      ),
                                      Text(
                                        '\$${data['price']}',
                                        style:
                                            Constants.semiRegularRedFontStyle,
                                      ),
                                      Text(
                                        'Size: ${dataItem['size']}',
                                        style: Constants.semiRegularFontStyle,
                                      ),
                                    ],
                                  )),
                                ],
                              ),
                            ); */
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
            CustomActionBar(
              title: 'Saved',
              hasBackArrow: false,
              hasTitle: true,
            ),
          ],
        ),
      ),
    );
  }
}
