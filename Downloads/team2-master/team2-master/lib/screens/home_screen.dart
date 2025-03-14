import 'package:flutter/material.dart';
import 'product_screen.dart';
import 'profile_screen.dart';

class HomeScreen extends StatelessWidget {
  final List<String> categories = ["Shoes", "Electronics", "Clothing"];
  final List<Map<String, String>> products = [
    {"name": "Sneakers", "image": "assets/shoe.png"},
    {"name": "Smartphone", "image": "assets/phone.png"},
    {"name": "Laptop", "image": "assets/laptop.png"},
    {"name": "T-Shirt", "image": "assets/shirt.png"},
    {"name": "Headphones", "image": "assets/headphone.png"},
  ];

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("E-Commerce"),
        actions: [
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ProfileScreen()));
            },
          ),
        ],
      ),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: Text("Categories",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: categories
                .map((category) => Chip(label: Text(category)))
                .toList(),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Text("Products",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ),
          ...products.map((product) {
            return ListTile(
              leading: Image.asset(product["image"]!, width: 50),
              title: Text(product["name"]!),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ProductScreen(product: product)));
              },
            );
          }),
        ],
      ),
    );
  }
}