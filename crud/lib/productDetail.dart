import 'dart:convert';

import 'package:flutter/material.dart';

class ProductDetail extends StatefulWidget {
  var productDetails = {};
  ProductDetail(this.productDetails, {super.key});

  @override
  _ProductDetailState createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView(
          children: [
            Image.memory(
              base64Decode(widget.productDetails['image']),
              height: 200,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 20),
            Text(widget.productDetails['title']),
            SizedBox(height: 20),
            Text(widget.productDetails['description']),
            SizedBox(height: 20),
            Text("Rs. ${widget.productDetails['price'].toString()}"),
            SizedBox(height: 20),
            ElevatedButton(onPressed: () {}, child: Text("Add To Cart")),
          ],
        ),
      ),
    );
  }
}
