import 'package:flutter/material.dart';
import 'package:time_degnitor__project/Screen/Api.dart';
import 'package:time_degnitor__project/Screen/product_model.dart';

class ProductFormScreen extends StatefulWidget {
  final Product? product;
  final bool isEdit;
  final Function onRefresh;

  ProductFormScreen({
    this.product,
    this.isEdit = false,
    required this.onRefresh,
  });

  @override
  _ProductFormScreenState createState() => _ProductFormScreenState();
}

class _ProductFormScreenState extends State<ProductFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _descController;
  late TextEditingController _priceController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.product?.title ?? '');
    _descController = TextEditingController(
      text: widget.product?.description ?? '',
    );
    _priceController = TextEditingController(
      text: widget.product?.price.toString() ?? '',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isEdit ? "Edit Product" : "Add Product"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(labelText: "Title"),
                validator: (value) => value!.isEmpty ? "Enter title" : null,
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _descController,
                decoration: InputDecoration(labelText: "Description"),
                validator: (value) =>
                    value!.isEmpty ? "Enter description" : null,
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _priceController,
                decoration: InputDecoration(labelText: "Price"),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? "Enter price" : null,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                child: Text(widget.isEdit ? "Update" : "Add"),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    if (widget.isEdit) {
                      await ApiService.updateProduct(
                        widget.product!.id,
                        _titleController.text,
                        _descController.text,
                        double.parse(_priceController.text),
                      );
                    } else {
                      await ApiService.addProduct(
                        _titleController.text,
                        _descController.text,
                        double.parse(_priceController.text),
                      );
                    }
                    widget.onRefresh();
                    Navigator.pop(context);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
