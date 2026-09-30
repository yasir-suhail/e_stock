import 'package:flutter/material.dart';
import 'package:e_stock/core/firebaseServices/stock_services.dart';
import 'package:e_stock/core/firebaseServices/transaction_services.dart';
import 'package:e_stock/model/stock_model.dart';

import '../../model/product_model.dart';
import '../../model/transaction_model.dart';

class ProductionViewModel extends ChangeNotifier {
  final StockServices stockServices = StockServices();
  final TransactionServices transactionServices = TransactionServices();

  bool isLoading = false;
  String? errorMessage;
//select product for production
  ProductModel? selectedProduct;
//select product
  void selectProduct(ProductModel? product) {
    selectedProduct = product;
    notifyListeners();
  }
  // --------- add production
  Future<bool> addProduction({
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

      // If stock does not exist, create the first stock record
      if (currentStock == null) {
        final newStock = StockModel(
          productId: productId,
          productName: selectedProduct!.productName,
          factoryStock: quantity,
          vanStock: 0,
        );

        await stockServices.addStock(newStock);
      } else {
        // If stock already exists, increase factory stock
        final updatedStock = StockModel(
          productId: currentStock.productId,
          productName: selectedProduct!.productName,
          factoryStock: currentStock.factoryStock + quantity,
          vanStock: currentStock.vanStock,
        );

        await stockServices.updateStock(updatedStock);
      }
// Create production transaction
      final transaction = TransactionModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        productId: productId,
        productName: selectedProduct!.productName,
        type: 'Production',
        quantity: quantity,
        date: DateTime.now().toString(),
      );

      // Save transaction
      await transactionServices.addTransaction(transaction);

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