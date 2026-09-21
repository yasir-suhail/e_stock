import 'dart:math';

import 'package'
    ':e_stock/core/firebaseServices/stock_services.dart';
import 'package:e_stock/model/stock_model.dart';
import 'package:flutter/cupertino.dart';

class StockViewmodel extends ChangeNotifier {
  // stock service object
  final StockServices stockServices = StockServices();

  //store all stock
  List<StockModel> allStock = [];

  // for adding the stock
  bool isAddingStock = false;

  // to get
  bool isLoadingStock = false;
  bool isLoading = false;
  String? errorMessage;

  // add the stock
  Future<bool> addStock(StockModel stock) async {
    isAddingStock = true;
    errorMessage = null;
    notifyListeners();
    try {
      // send the stock to the services , it will save it in the firebase
      await stockServices.addStock(stock);
      // add the stock to the local list
      allStock.add(stock);
      return true;
    } catch (e) {
      errorMessage = e.toString();
      return false;
    } finally {
      isAddingStock = false;
      notifyListeners();
    }
  }

  //---------- to get the stock -----
  Future<void> getStock() async {
    isLoadingStock = true;
    errorMessage = null;
    notifyListeners();
    try {
      allStock = await stockServices.getStocks();
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoadingStock = false;
      notifyListeners();
    }
  }

  //-----update the stock
  Future<bool> updateStock(StockModel stock) async {
    errorMessage = null;
    try {
      //send the updated stock to the firebase
      await stockServices.updateStock(stock);

      //find the stock item in the local list and using the productId
      final index = allStock.indexWhere(
        (item) => item.productId == stock.productId,
      );
      // ----------------------- the -1 is the  special return value from indexWhere "meaning not found "
      // if indexWhere found the product ,then update it
      if (index != -1) {
        allStock[index] = stock;
      }
      notifyListeners();
      return true;
    } catch (e) {
      errorMessage = e.toString();
      notifyListeners();
      return false;
    }
  }
//   ---------- delete the product
Future<bool>deleteStock(String productId)async{
    errorMessage = null;
    try{
      await stockServices.deleteStock(productId);
      allStock.removeWhere((stock)=>stock.productId == productId);
      notifyListeners();
      return true;
    }catch(e){
      errorMessage= e.toString();
      notifyListeners();
      return false;
    }
}
// --------- add  production
  Future<bool> addProduction({
    required String productId,
    required int quantity,
  }) async {
    try {
      isLoading = true;
      errorMessage = null;
      notifyListeners();

      await stockServices.addProduction(
        productId: productId,
        quantity: quantity,
      );

      // Get the latest stock from Firebase
      await getStock();
return  true;
    } catch (e) {
      errorMessage = e.toString();
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
