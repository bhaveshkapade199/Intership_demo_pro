import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_degnitor__project/providers/product_provider.dart';
import 'package:time_degnitor__project/screen2/product_create.dart';
import 'package:time_degnitor__project/screen2/product_detail.dart';

class ProductListScreen extends StatelessWidget {
  const ProductListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Products")),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const ProductCreateScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: provider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: provider.products.length,
              itemBuilder: (context, index) {
                final product = provider.products[index];
                return ListTile(
                  leading: Image.network(product['thumbnail'], width: 50),
                  title: Text(product['title']),
                  subtitle: Text("\$${product['price']}"),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            ProductDetailScreen(productId: product['id']),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}
