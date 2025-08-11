import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:time_degnitor__project/screen2/product_list.dart';

import 'providers/product_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProductProvider()..fetchProducts(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Product CRUD',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: ProductList(),
      ),
    );
  }
}
