import 'package:flutter/material.dart';
import 'package:shop_app/data/dbHelper.dart';
import 'package:shop_app/models/product.dart';

class ProductDetail extends StatefulWidget {
  final Product product;
  const ProductDetail(this.product, {super.key});

  @override
  // ignore: no_logic_in_create_state
  State<ProductDetail> createState() => _ProductDetailState(product);
}

enum Options { delete, update }

class _ProductDetailState extends State<ProductDetail> {
  final Product product;
  _ProductDetailState(this.product);
  var dbHelper = DbHelper();
  var txtName = TextEditingController();
  var txtDescription = TextEditingController();
  var txtUnitPrice = TextEditingController();

  @override
  void initState() {
    txtName.text = product.name!;
    txtDescription.text = product.description!;
    txtUnitPrice.text = product.unitPrice!.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.name.toString()),
        backgroundColor: Colors.deepPurple,
        actions: [
          PopupMenuButton<Options>(
            onSelected: selectProcess,
            itemBuilder: (BuildContext context) => <PopupMenuEntry<Options>>[
              PopupMenuItem<Options>(
                value: Options.delete,
                child: const Text("Delete"),
                onTap: () {},
              ),
              PopupMenuItem<Options>(
                value: Options.update,
                child: const Text("Update"),
                onTap: () {},
              ),
            ],
          )
        ],
      ),
      body: buildProductDetail(),
    );
  }

  buildProductDetail() {
    return GestureDetector(
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
            ],
          ),
        ),
      ),
    );
  }

  void selectProcess(Options options) async {
    switch (options) {
      case Options.delete:
        if (product.id != null) {
          await dbHelper.delete(product.id!);
          // ignore: use_build_context_synchronously
          Navigator.pop(context, true);
        }
        break;

      case Options.update:
        await dbHelper.update(
          Product.withId(
            id: product.id,
            name: txtName.text,
            description: txtDescription.text,
            unitPrice: double.tryParse(txtUnitPrice.text),
          ),
        );
        // ignore: use_build_context_synchronously
        Navigator.pop(context, true);

        break;

      default:
    }
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
}
