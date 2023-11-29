import 'package:flutter/material.dart';
import 'package:shop_app/data/dbHelper.dart';
import 'package:shop_app/models/product.dart';

class ProductAdd extends StatefulWidget {
  const ProductAdd({super.key});

  @override
  State<ProductAdd> createState() => _ProductAddState();
}

class _ProductAddState extends State<ProductAdd> {
  var dbHelper = DbHelper();
  var txtName = TextEditingController();
  var txtDescription = TextEditingController();
  var txtUnitPrice = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Product"),
        backgroundColor: Colors.deepPurple,
      ),
      body: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              children: [
                buildNameField(),
                buildDescriptionField(),
                buildUnitPriceField(),
                buildSaveButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  buildNameField() {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: TextField(
        decoration: const InputDecoration(
          labelText: "Product Name",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(50),
            ),
          ),
        ),
        controller: txtName,
      ),
    );
  }

  buildDescriptionField() {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: TextField(
        decoration: const InputDecoration(
          labelText: "Product Description",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(50),
            ),
          ),
        ),
        controller: txtDescription,
      ),
    );
  }

  buildUnitPriceField() {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: TextField(
        decoration: const InputDecoration(
          labelText: "Product Price",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(50),
            ),
          ),
        ),
        controller: txtUnitPrice,
      ),
    );
  }

  buildSaveButton() {
    return Padding(
      padding: const EdgeInsets.all(50),
      child: TextButton(
        onPressed: () {
          addProduct();
        },
        style: TextButton.styleFrom(
          backgroundColor: Colors.deepPurple,
        ),
        child: const Text(
          "Add",
          style: TextStyle(color: Colors.black),
        ),
      ),
    );
  }

  void addProduct() async {
    await dbHelper.insert(
      Product(
        name: txtName.text,
        description: txtDescription.text,
        unitPrice: double.tryParse(txtUnitPrice.text),
      ),
    );
    // ignore: use_build_context_synchronously
    Navigator.pop(context, true);
  }
}
