class BobaProduct {
  String name;
  String description;
  double price;
  String imageId;

  BobaProduct({this.name, this.description, this.price, this.imageId});

  factory BobaProduct.fromDatabase(Map<String, dynamic> dbrecord) {
    return BobaProduct(
      name: dbrecord['name'],
      description: dbrecord['description'],
      price: dbrecord['price'],
      imageId: dbrecord['imageId'],
    );
  }
}

class BobaProducts {
  final List<BobaProduct> products;

  BobaProducts({this.products});

  factory BobaProducts.fromDatabase(List<dynamic> queryRecords) {
    List<BobaProduct> bobaProducts = List<BobaProduct>();
    bobaProducts = queryRecords.map((e) => BobaProduct.fromDatabase(e)).toList();
    return BobaProducts(products: bobaProducts);
  }
}