import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditProduct extends StatefulWidget {
  final Map<String, dynamic> product;

  const EditProduct({Key? key, required this.product}) : super(key: key);

  @override
  State<EditProduct> createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  late TextEditingController titleController;
  late TextEditingController descriptionController;
  late TextEditingController priceController;
  late String imageBase64;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.product['title']);
    descriptionController = TextEditingController(
      text: widget.product['description'],
    );
    priceController = TextEditingController(
      text: widget.product['price'].toString(),
    );
    imageBase64 = widget.product['image'];
  }

  void updateProduct() async {
    try {
      await FirebaseFirestore.instance
          .collection('products')
          .doc(widget.product['id'])
          .update({
            'title': titleController.text,
            'description': descriptionController.text,
            'price': double.tryParse(priceController.text) ?? 0,
            'image': imageBase64, // optional: allow image edit too
          });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Product updated'),
          backgroundColor: Colors.green,
        ),
      );

      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Edit Product")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Image.memory(base64Decode(imageBase64), height: 100),
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: "Title"),
            ),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(labelText: "Description"),
            ),
            TextField(
              controller: priceController,
              decoration: InputDecoration(labelText: "Price"),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: updateProduct,
              child: Text("Update Product"),
            ),
          ],
        ),
      ),
    );
  }
}
