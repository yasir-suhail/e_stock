class TransactionModel {
  final String id;
  final String productId;
  final String type;
  final int quantity;
  final String productName;

  //used for sale
  final String? customerId;

  //used when a seller perform the transaction
  final String? sellerId;
  final String? sellerName;
  final String? sellerType;

  final String date;

  TransactionModel({
    required this.id,
    required this.productId,
    required this.quantity,
    required this.type,
    required this.date,
    required this.productName,
    this.customerId,
    this.sellerId,
    this.sellerName,
    this.sellerType,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'productId': productId,
      'productName': productName,
      'quantity': quantity,
      'type': type,
      'date': date,

      'customerId': customerId,

      'sellerId': sellerId,
      'sellerName': sellerName,
      'sellerType':sellerType
    };
  }

  factory TransactionModel.fromMap(Map<String, dynamic> map) {
    return TransactionModel(
      id: map['id']??'',
      productId: map['productId']??'',
      productName: map['productName']??'',
      quantity: map['quantity']??0,
      type: map['type'] ?? '',
      date: map['date'] ?? '',

      customerId: map['customerId'],

      sellerId: map['sellerId'] ,
      sellerName: map['sellerName'] ,
      sellerType: map['sellerType'] ,
    );
  }
}
