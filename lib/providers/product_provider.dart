// TODO Implement this library.
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProductProvider extends ChangeNotifier {
  final String baseUrl = "https://dummyjson.com/products";
  List products = [];
  bool isLoading = false;

  Future<void> fetchProducts() async {
    isLoading = true;
    notifyListeners();
    final res = await http.get(Uri.parse(baseUrl));
    if (res.statusCode == 200) {
      products = jsonDecode(res.body)['products'];
    }
    isLoading = false;
    notifyListeners();
  }

  Future<Map?> fetchSingleProduct(int id) async {
    final res = await http.get(Uri.parse('$baseUrl/$id'));
    if (res.statusCode == 200) {
      return jsonDecode(res.body);
    }
    return null;
  }

  Future<bool> addProduct(Map<String, dynamic> data) async {
    final res = await http.post(
      Uri.parse('$baseUrl/add'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );
    if (res.statusCode == 200 || res.statusCode == 201) {
      fetchProducts();
      return true;
    }
    return false;
  }

  Future<bool> updateProduct(int id, Map<String, dynamic> data) async {
    final res = await http.put(
      Uri.parse('$baseUrl/$id'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );
    if (res.statusCode == 200) {
      fetchProducts();
      return true;
    }
    return false;
  }

  Future<bool> deleteProduct(int id) async {
    final res = await http.delete(Uri.parse('$baseUrl/$id'));
    if (res.statusCode == 200) {
      products.removeWhere((p) => p['id'] == id);
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<void> searchProducts(String query) async {
    if (query.isEmpty) {
      await fetchProducts();
      return;
    }
    isLoading = true;
    notifyListeners();
    final res = await http.get(Uri.parse('$baseUrl/search?q=$query'));
    if (res.statusCode == 200) {
      products = jsonDecode(res.body)['products'];
    }
    isLoading = false;
    notifyListeners();
  }

  void sortProducts(String type) {
    if (type == 'A-Z') {
      products.sort(
        (a, b) => a['title'].toLowerCase().compareTo(b['title'].toLowerCase()),
      );
    } else if (type == 'Z-A') {
      products.sort(
        (a, b) => b['title'].toLowerCase().compareTo(a['title'].toLowerCase()),
      );
    } else if (type == 'Price Low-High') {
      products.sort((a, b) => a['price'].compareTo(b['price']));
    } else if (type == 'Price High-Low') {
      products.sort((a, b) => b['price'].compareTo(a['price']));
    }
    notifyListeners();
  }

  Future<void> filterByCategory(String category) async {
    if (category == 'All') {
      await fetchProducts();
      return;
    }
    isLoading = true;
    notifyListeners();
    final res = await http.get(Uri.parse('$baseUrl/category/$category'));
    if (res.statusCode == 200) {
      products = jsonDecode(res.body)['products'];
    }
    isLoading = false;
    notifyListeners();
  }

  Future<List<String>> fetchCategories() async {
    final res = await http.get(Uri.parse('$baseUrl/categories'));
    if (res.statusCode == 200) {
      return List<String>.from(jsonDecode(res.body));
    }
    return [];
  }
}
