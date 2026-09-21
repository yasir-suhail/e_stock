import 'package:e_stock/model/stock_model.dart';
import 'package:firebase_database/firebase_database.dart';

class StockServices {

  final DatabaseReference stockReference= FirebaseDatabase.instance.ref('stock');


  //Add stock
Future<void> addStock(StockModel stock)async{
  await stockReference.child(stock.productId).set(stock.toMap());
}

// get the stock
Future<List<StockModel>> getStocks()async{
  final snapshot = await stockReference.get();
// if no stock is available return empty list
  if(!snapshot.exists){
    return [];
  }
  // convert that object/firebase data into Map<string ,dynamic> b/c firebase
  // give us the data as general object
  final data = Map<String,dynamic>.from(snapshot.value as Map);
  // Convert every Firebase stock record into a StockModel object
  return data.entries.map((entry){
      // Get the data of one stock item
        // and convert it into Map<String, dynamic>
    final stockData= Map<String,dynamic>.from(entry.value);
// convert the map into stockmodel object
    return StockModel.fromMap(stockData);
  }).toList();
}
// update the stock
  Future<void> updateStock(StockModel stock) async {
    await stockReference
        .child(stock.productId)
        .update(stock.toMap());
  }
  // delete the stock

Future<void> deleteStock(String productId)async{

  await stockReference.child(productId).remove();
}
//-----------add production
  Future<void> addProduction({
    required String productId,
    required int quantity,
  }) async {
    final stockReferenceForProduct =
    stockReference.child(productId);

    final snapshot = await stockReferenceForProduct.get();

    // If stock does not exist, create the first stock record
    if (!snapshot.exists) {
      final newStock = StockModel(
        productId: productId,
        factoryStock: quantity,
        vanStock: 0,
      );

      await stockReferenceForProduct.set(newStock.toMap());

      return;
    }

    // If stock already exists, increase factory stock
    final stockData = Map<String, dynamic>.from(
      snapshot.value as Map,
    );

    final currentFactoryStock =
        stockData['factoryStock'] ?? 0;

    final newFactoryStock =
        currentFactoryStock + quantity;

    await stockReferenceForProduct.update({
      'factoryStock': newFactoryStock,
    });
  }
}