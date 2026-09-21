class ProductModel {
  // unique id for the product
  final String id;
  //product name
  final String productName;
  //packaging/unit Size of the products
  final String packaging;
  // minimum stock alert
  final int minimumStockAlert;

  //constructor
  ProductModel({
    required this.id,
    required this.productName,
    required this.packaging,
    required this.minimumStockAlert,
  });

  //convert firebase  Map data into a production model object
  factory ProductModel.fromMap(Map<String, dynamic> map) {

    return ProductModel(
      id: map['id'] ?? '',
      productName: map['productName'] ?? '',
      packaging: map['packaging'] ?? '',
      minimumStockAlert:
      map['minimumStockAlert'] ?? 0,
    );
  }
  //convert production model object into Map to save in the firebase

Map<String,dynamic> toMap(){
    return{
      'id': id,
      'productName': productName,
      'packaging':packaging,
      'minimumStockAlert':minimumStockAlert
    };
}
}
