import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:http/http.dart' as http;
import 'package:time_degnitor__project/class_model.dart';

class ProductList extends StatefulWidget {
  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  List<Products> postlist = [];
  List<Products> filteredList = [];

  String priceFilterText = "";

  Future<List<Products>> getPostApi() async {
    final response = await http.get(
      Uri.parse('https://dummyjson.com/products'),
    );
    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      postlist.clear();
      for (Map<String, dynamic> i in data['products']) {
        postlist.add(Products.fromJson(i));
      }

      filteredList = List.from(postlist);
      _applyFilter();
      return postlist;
    } else {
      return postlist;
    }
  }

  void _applyFilter() {
    setState(() {
      double? filterPrice = double.tryParse(priceFilterText);

      if (filterPrice != null) {
        filteredList = postlist
            .where((product) => product.price! >= filterPrice)
            .toList();
      } else {
        filteredList = List.from(postlist);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Listing Management"),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.arrow_back_ios_new_rounded),
        ),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.more_vert))],
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: const Color.fromARGB(255, 255, 255, 255),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Price",
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  priceFilterText = value;
                  _applyFilter();
                },
              ),
            ),

            FutureBuilder(
              future: getPostApi(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  if (filteredList.isEmpty && postlist.isNotEmpty) {
                    filteredList = List.from(postlist);
                    _applyFilter();
                  }

                  return Expanded(
                    child: ListView.builder(
                      itemCount: filteredList.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundImage:
                                filteredList[index].thumbnail != null
                                ? NetworkImage(filteredList[index].thumbnail!)
                                : AssetImage('assets/images/placeholder.png')
                                      as ImageProvider,
                          ),
                          title: Text(filteredList[index].title ?? "No Title"),
                          subtitle: Text(
                            "Price: \$${filteredList[index].price}",
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text("ID: ${filteredList[index].id}"),
                              SizedBox(width: 20),
                              IconButton(
                                icon: Icon(Icons.delete, color: Colors.red),
                                onPressed: () {
                                  setState(() {
                                    postlist.removeWhere(
                                      (item) =>
                                          item.id == filteredList[index].id,
                                    );
                                    filteredList.removeAt(index);
                                  });
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        'Product deleted successfully',
                                      ),
                                      backgroundColor: Colors.red,
                                      duration: Duration(seconds: 2),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) {
              return Container(
                height: 300,
                width: double.infinity,
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),
                    Container(
                      height: 40,
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: "Product-Id",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        style: TextStyle(
                          color: const Color.fromARGB(255, 0, 0, 0),
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    Container(
                      height: 40,
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: "Product-Name",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        style: TextStyle(
                          color: const Color.fromARGB(255, 0, 0, 0),
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    Container(
                      height: 40,
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: "Product-Price",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        style: TextStyle(
                          color: const Color.fromARGB(255, 0, 0, 0),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.only(left: 8, right: 8),
                      child: Container(
                        height: 40,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.cyanAccent,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: InkWell(
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Product added Successfully'),
                                backgroundColor: Colors.green,
                                duration: Duration(seconds: 3),
                              ),
                            );
                          },
                          child: Center(
                            child: Text(
                              "Add Product",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
