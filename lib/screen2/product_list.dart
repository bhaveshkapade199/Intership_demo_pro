import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_degnitor__project/providers/product_provider.dart';
import 'package:time_degnitor__project/screen2/product_create.dart';
import 'package:time_degnitor__project/screen2/product_detail.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  final searchCtrl = TextEditingController();
  List<String> categories = [];
  String selectedCategory = 'All';

  @override
  void initState() {
    super.initState();
    final provider = Provider.of<ProductProvider>(context, listen: false);
    provider.fetchProducts();
    _loadCategories();
  }

  Future<void> _loadCategories() async {
    final provider = Provider.of<ProductProvider>(context, listen: false);
    final fetchedCategories = await provider.fetchCategories();
    setState(() {
      categories = ['All', ...fetchedCategories];
    });
  }

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
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchCtrl,
              decoration: InputDecoration(
                hintText: 'Search products...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    searchCtrl.clear();
                    provider.fetchProducts();
                  },
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onSubmitted: (value) => provider.searchProducts(value),
            ),
          ),

          // Sorting buttons
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _sortButton(provider, 'A-Z'),
                _sortButton(provider, 'Z-A'),
                _sortButton(provider, 'Price Low-High'),
                _sortButton(provider, 'Price High-Low'),
              ],
            ),
          ),

          // Category filter dropdown
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButton<String>(
              value: selectedCategory,
              items: categories
                  .map((cat) => DropdownMenuItem(value: cat, child: Text(cat)))
                  .toList(),
              onChanged: (val) {
                if (val != null) {
                  setState(() => selectedCategory = val);
                  provider.filterByCategory(val);
                }
              },
            ),
          ),

          // Product list
          Expanded(
            child: provider.isLoading
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
          ),
        ],
      ),
    );
  }

  Widget _sortButton(ProductProvider provider, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: ElevatedButton(
        onPressed: () => provider.sortProducts(label),
        child: Text(label, style: const TextStyle(fontSize: 12)),
      ),
    );
  }
}
