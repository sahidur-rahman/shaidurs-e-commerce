// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import '../../constants.dart';
import '../product_detail.dart';

class CustomCartSaved extends StatelessWidget {
  const CustomCartSaved(
      {Key? key,
      required this.data,
      required this.size,
      required this.docId,
      required this.onDelete})
      : super(key: key);
  final Map<String, dynamic> data;
  final String docId;
  final String size;
  final Function(String) onDelete;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ProductDetail(productId: docId),
          ),
        );
      },
      child: Stack(
        children: [
          Container(
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      data['name'],
                      style: Constants.regularFontStyle,
                    ),
                    Text(
                      '\$${data['price']}',
                      style: Constants.semiRegularRedFontStyle,
                    ),
                    Text(
                      'Size: $size',
                      style: Constants.semiRegularFontStyle,
                    ),
                  ],
                )),
              ],
            ),
          ),
          Positioned(
            bottom: 24.0,
            right: 16.0,
            child: GestureDetector(
              onLongPress: () => onDelete(docId),
              child: SizedBox(
                height: 32.0,
                width: 32.0,
                child: Image.asset('assets/images/delete.png'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
