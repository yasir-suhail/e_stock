class StockModel {
  // which product does the products belong to
  final String productId;
  // quantity available in factory
  final int factoryStock;
  // quantity available in van
  final int vanStock;

  // constructor
  StockModel({
    required this.productId,required this.factoryStock,required this.vanStock
});

  // convert stockmodel into map , used when saving/updating data in firebase
  Map<String,dynamic>toMap(){
    return{
      'productId':productId,
      'factoryStock':factoryStock,
      'vanStock':vanStock
    };
  }

  //convert firebase map into stockmodel ,used when getting data from firebase
  factory StockModel.fromMap(Map<String,dynamic> map)
  {
    return StockModel(
        productId: map['productId']?? '',
        factoryStock: map['factoryStock']??0,
        vanStock: map['vanStock']??0);

  }
}