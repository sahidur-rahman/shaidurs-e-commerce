// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class ProductSizes extends StatefulWidget {
  const ProductSizes({Key? key, required this.sizes, required this.onSelect})
      : super(key: key);
  final List sizes;
  final Function(String) onSelect;

  @override
  _ProductSizesState createState() => _ProductSizesState();
}

class _ProductSizesState extends State<ProductSizes> {
  int _selectedIndex = 0;

  @override
  void initState() {
    widget.onSelect('${widget.sizes[_selectedIndex]}');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (int i = 0; i < widget.sizes.length; i++)
          GestureDetector(
            onTap: () {
              widget.onSelect('${widget.sizes[i]}');
              setState(() {
                _selectedIndex = i;
              });
            },
            child: Container(
              height: 36.0,
              width: 36.0,
              margin: EdgeInsets.symmetric(
                horizontal: 4.0,
              ),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: _selectedIndex == i
                    ? Theme.of(context).colorScheme.secondary
                    : Colors.grey,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Text(
                widget.sizes[i],
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
      ],
    );
  }
}
