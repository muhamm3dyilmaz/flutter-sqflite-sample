import 'package:flutter/material.dart';
import 'package:shop_app/data/dbHelper.dart';
import 'package:shop_app/models/product.dart';
import 'package:shop_app/screens/product_add.dart';
import 'package:shop_app/screens/product_detail.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  var dbHelper = DbHelper();
  List<Product>? products;
  int productCount = 0;

  @override
  void initState() {
    getProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Products"),
        backgroundColor: Colors.deepPurple,
      ),
      body: buildProductList(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurple,
        splashColor: Colors.purpleAccent,
        tooltip: "Add new product",
        child: const Icon(Icons.add, color: Colors.black),
        onPressed: () {
          goToProductAdd();
        },
      ),
    );
  }

  buildProductList() {
    // print(products);
    return ListView.builder(
      itemCount: productCount,
      itemBuilder: (BuildContext context, int position) {
        return Card(
          color: Colors.amber[50],
          elevation: 2,
          child: ListTile(
            leading: const CircleAvatar(
              backgroundColor: Colors.black12,
              child: Text("P"),
            ),
            title: Text(products![position].name.toString()),
            subtitle: Text(products![position].description.toString()),
            onTap: () {
              goToDetail(products![position]);
            },
          ),
        );
      },
    );
  }

  void goToProductAdd() async {
    bool result = await Navigator.push(context, MaterialPageRoute(builder: (context) => const ProductAdd()));

    if (result) {
      getProducts();
    }
  }

  void getProducts() async {
    var productsFuture = dbHelper.getProducts();
    productsFuture.then(
      (data) {
        setState(() {
          products = data;
          productCount = data.length;
        });
      },
    );
  }

  void goToDetail(Product product) async {
    bool? result = await Navigator.push<bool?>(
      context,
      MaterialPageRoute(builder: (context) => ProductDetail(product)),
    );

    if (result != null && result) {
      getProducts();
    }
  }
}
