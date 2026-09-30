import 'package:e_stock/model/stock_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

import 'auth_services.dart';

class StockServices {
  //auth services
  final AuthServices authServices = AuthServices();

  // Reference to the main stock node in Firebase
  final DatabaseReference stocksReference = FirebaseDatabase.instance.ref(
    'stock',);

  // Current owner's stock reference
  DatabaseReference get stockReference {
    final String? uid = authServices.currentUserId;

    if (uid == null) {
      throw Exception('User is not logged in');
    }

    return stocksReference.child(uid);
  }
  //Add stock
  Future<void> addStock(StockModel stock) async {
    await stockReference.child(stock.productId).set(stock.toMap());
  }

  // get the stock
  Future<List<StockModel>> getStocks() async {
    final snapshot = await stockReference.get();
    // if no stock is available return empty list
    if (!snapshot.exists) {
      return [];
    }
    // convert that object/firebase data into Map<string ,dynamic> b/c firebase
    // give us the data as general object
    final data = Map<String, dynamic>.from(snapshot.value as Map);
    // Convert every Firebase stock record into a StockModel object
    return data.entries.map((entry) {
      // Get the data of one stock item
      // and convert it into Map<String, dynamic>
      final stockData = Map<String, dynamic>.from(entry.value);
      // convert the map into stockmodel object
      return StockModel.fromMap(stockData);
    }).toList();
  }

  // update the stock
  Future<void> updateStock(StockModel stock) async {
    await stockReference.child(stock.productId).update(stock.toMap());

    print('Stock update completed');
  }

  // delete the stock

  Future<void> deleteStock(String productId) async {
    await stockReference.child(productId).remove();
  }

  // Get stock of one product
  Future<StockModel?> getStockByProductId(String productId) async {
    final snapshot = await stockReference.child(productId).get();

    if (!snapshot.exists) {
      return null;
    }

    final stockData = Map<String, dynamic>.from(snapshot.value as Map);

    return StockModel.fromMap(stockData);
  }
}
