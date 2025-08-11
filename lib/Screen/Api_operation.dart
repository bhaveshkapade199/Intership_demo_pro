import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:time_degnitor__project/Screen/product_model.dart';

class ApiService {
  static const baseUrl = "https://dummyjson.com";

  static Future<List<Product>> getProducts() async {
    final response = await http.get(Uri.parse("$baseUrl/products"));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      List products = data['products'];
      return products.map((e) => Product.fromJson(e)).toList();
    } else {
      throw Exception("Failed to load products");
    }
  }

  static Future<Product> addProduct(
    String title,
    String description,
    double price,
  ) async {
    final response = await http.post(
      Uri.parse("$baseUrl/products/add"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "title": title,
        "description": description,
        "price": price,
        "thumbnail": "https://i.dummyjson.com/data/products/1/thumbnail.jpg",
      }),
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      return Product.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to add product");
    }
  }

  static Future<Product> updateProduct(
    int id,
    String title,
    String description,
    double price,
  ) async {
    final response = await http.put(
      Uri.parse("$baseUrl/products/$id"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "title": title,
        "description": description,
        "price": price,
      }),
    );
    if (response.statusCode == 200) {
      return Product.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to update product");
    }
  }

  static Future<void> deleteProduct(int id) async {
    final response = await http.delete(Uri.parse("$baseUrl/products/$id"));
    if (response.statusCode != 200) {
      throw Exception("Failed to delete product");
    }
  }
}
