import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud/editProduct.dart';
import 'package:crud/logout.dart';
import 'package:crud/productDetail.dart';
import 'package:flutter/material.dart';

class Products extends StatefulWidget {
  const Products({Key? key}) : super(key: key);

  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  var products = FirebaseFirestore.instance.collection('products');
  TextEditingController searchController = TextEditingController();
  String searchQuery = '';

  // delete product function
  void deleteProduct(String id) async {
    print(id);
    try {
      await products.doc(id).delete();
      print("Product deleted");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Product deleted"),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.red,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: searchController,
          decoration: InputDecoration(
            hintText: 'Search products...',
            border: InputBorder.none,
            hintStyle: TextStyle(color: Colors.white60),
            icon: Icon(Icons.search, color: Colors.white),
          ),
          style: TextStyle(color: Colors.white),
          onChanged: (value) {
            setState(() {
              searchQuery = value.trim().toLowerCase();
            });
          },
        ),
        backgroundColor: Colors.deepPurple,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, "/add");
            },
            icon: Icon(Icons.add),
            tooltip: 'Add Product',
          ),
          IconButton(
            onPressed: () {
              Logout.signOut(context);
            },
            icon: Icon(Icons.logout),
            tooltip: 'Logout',
            color: Colors.white,
          ),
        ],
      ),
      body: Center(
        child: StreamBuilder(
          stream: products.snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var productList = snapshot.data!.docs;
              // Filter products based on search query
              var filteredList = productList.where((product) {
                final title = product['title'].toString().toLowerCase();
                final description = product['description'].toString().toLowerCase();
                return title.contains(searchQuery) || description.contains(searchQuery);
              }).toList();
              return ListView.builder(
                itemCount: filteredList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(filteredList[index]['title']),
                    subtitle: Text(filteredList[index]['description']),
                    leading: CircleAvatar(
                      child: Image.memory(
                        base64Decode(filteredList[index]['image']),
                        height: 40,
                      ),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () {
                            Map<String, dynamic> productDetails = {
                              'id': filteredList[index].id,
                              'title': filteredList[index]['title'],
                              'description': filteredList[index]['description'],
                              'price': filteredList[index]['price'],
                              'image': filteredList[index]['image'],
                            };
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProductDetail(productDetails),
                              ),
                            );
                          },
                          icon: Icon(Icons.info),
                        ),
                        IconButton(
                          onPressed: () {
                            Map<String, dynamic> productDetails = {
                              'id': filteredList[index].id,
                              'title': filteredList[index]['title'],
                              'description': filteredList[index]['description'],
                              'price': filteredList[index]['price'],
                              'image': filteredList[index]['image'],
                            };
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditProduct(product: productDetails),
                              ),
                            );
                          },
                          icon: Icon(Icons.edit),
                        ),
                        IconButton(
                          onPressed: () {
                            deleteProduct(filteredList[index].id);
                          },
                          icon: Icon(Icons.delete, color: Colors.red),
                        ),
                      ],
                    ),
                  );
                },
              );
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}
