class Product {
  int? id;
  String? name;
  String? description;
  double? unitPrice;

  // Insert işleminde id auto increment olduğu için gerek yok
  Product({this.name, this.description, this.unitPrice});

  // Update-Delete gibi işlemlerde tanımlayıcı olması için id gerekli
  Product.withId({this.id, this.name, this.description, this.unitPrice});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};

    if (id != null) {
      map["id"] = id;
    }
    map["name"] = name;
    map["description"] = description;
    map["unitPrice"] = unitPrice;

    return map;
  }

  factory Product.fromObject(dynamic object) {
    return Product.withId(
      id: object["id"],
      name: object["name"],
      description: object["description"],
      unitPrice: double.tryParse(object["unitPrice"].toString()),
    );
  }
}
