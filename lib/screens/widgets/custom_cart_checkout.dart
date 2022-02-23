import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_training_ecommerce/screens/widgets/custom_btn.dart';

import '../../constants.dart';
import '../../services/firebase_services.dart';

class CustomCartCheckout extends StatefulWidget {
  const CustomCartCheckout({Key? key}) : super(key: key);

  @override
  _CustomCartCheckoutState createState() => _CustomCartCheckoutState();
}

class _CustomCartCheckoutState extends State<CustomCartCheckout> {
  final FirebaseServices _firebaseServices = FirebaseServices();

  @override
  Widget build(BuildContext context) {
    int _tPrice = 0;

    return StreamBuilder<QuerySnapshot>(
      stream: _firebaseServices.usersRef
          .doc(_firebaseServices.getUserID())
          .collection('Cart')
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          List<QueryDocumentSnapshot<Object?>>? _documents =
              snapshot.data?.docs;

          _tPrice = 0;
          for (var snapshot in _documents!) {
            Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
            _tPrice += int.parse(data['price']);
          }
        }

        return Container(
          child: Row(
            children: [
              Container(
                width: MediaQuery.of(context).size.width / 2,
                alignment: Alignment.center,
                child: Text(
                  'Total price : \$$_tPrice',
                  style: Constants.regularBoldFontRed,
                ),
              ),
              Expanded(
                child: CustomBtn(
                  text: 'Checkout',
                  onPressed: () {},
                  isOutlined: false,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
