import 'package:flutter/material.dart';

class ProductScreen extends StatelessWidget {
  final Map<String, String> product;

  const ProductScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(product["name"]!)),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(product["image"]!, height: 200),
          Text(product["name"]!,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          Text("\$99.99", style: TextStyle(fontSize: 20, color: Colors.green)),
          SizedBox(height: 20),
          ElevatedButton(onPressed: () {}, child: Text("Add to Cart")),
        ],
      ),
    );
  }
}
