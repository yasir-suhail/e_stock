import 'package:e_stock/core/firebaseServices/stock_services.dart';
import 'package:e_stock/core/firebaseServices/transaction_services.dart';
import 'package:e_stock/model/transaction_model.dart';
import 'package:flutter/cupertino.dart';

import '../../model/stock_model.dart';

class LoadVanViewmodel extends ChangeNotifier {
  final StockServices stockServices = StockServices();
  final TransactionServices transactionServices = TransactionServices();

  bool isLoading = false;
  String? errorMessage;

  // Load product from factory stock to van stock
  Future<bool> loadVan({
    required String productId,
    required int quantity,
  }) async {
    try {
      isLoading = true;
      errorMessage = null;
      notifyListeners();

      // Get current stock of the selected product
      final currentStock =
      await stockServices.getStockByProductId(productId);

      // Check if the stock record exists
      if (currentStock == null) {
        errorMessage = 'Stock not found';
        return false;
      }

      // Check if factory stock is enough
      if (currentStock.factoryStock < quantity) {
        errorMessage = 'Not enough factory stock';
        return false;
      }

      // Move quantity from factory stock to van stock
      final updatedStock = StockModel(
        productId: currentStock.productId,
        factoryStock:
        currentStock.factoryStock - quantity,
        vanStock:
        currentStock.vanStock + quantity,
      );

      // Update the stock in Firebase
      await stockServices.updateStock(updatedStock);

      // Create Load Van transaction
      final transaction = TransactionModel(
        id: DateTime.now()
            .millisecondsSinceEpoch
            .toString(),
        productId: productId,
        quantity: quantity,
        type: 'Load Van',
        date: DateTime.now().toString(),
      );

      // Save transaction
      await transactionServices.addTransaction(
        transaction,
      );

      return true;
    } catch (e) {
      errorMessage = e.toString();
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}