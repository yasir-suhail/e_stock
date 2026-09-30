import 'package:e_stock/core/firebaseServices/stock_services.dart';
import 'package:e_stock/core/firebaseServices/transaction_services.dart';
import 'package:e_stock/model/transaction_model.dart';
import 'package:flutter/cupertino.dart';

import '../../model/product_model.dart';
import '../../model/stock_model.dart';

class LoadVanViewmodel extends ChangeNotifier {
  // Services
  final StockServices stockServices = StockServices();
  final TransactionServices transactionServices = TransactionServices();

  // Loading state
  bool isLoading = false;

  // Error message for UI
  String? errorMessage;

  // Selected product
  ProductModel? selectedProduct;

  // Select product
  void selectProduct(ProductModel? product) {
    selectedProduct = product;
    notifyListeners();
  }

  // Load product from factory stock to van stock
  Future<bool> loadVan({
    required String productId,
    required int quantity,
  }) async {
    try {
      isLoading = true;
      errorMessage = null;
      notifyListeners();

      // 1. Check whether a product is selected
      if (selectedProduct == null) {
        errorMessage = 'Please select a product';
        return false;
      }

      // 2. Check quantity
      if (quantity <= 0) {
        errorMessage = 'Quantity must be greater than 0';
        return false;
      }

      // 3. Get current stock
      final currentStock =
      await stockServices.getStockByProductId(productId);

      // 4. Check whether stock exists
      if (currentStock == null) {
        errorMessage = 'Stock not found';
        return false;
      }

      // 5. Check factory stock
      if (currentStock.factoryStock < quantity) {
        errorMessage = 'Not enough factory stock';
        return false;
      }

      // 6. Calculate updated stock
      final updatedStock = StockModel(
        productId: currentStock.productId,
        productName: selectedProduct!.productName,
        factoryStock: currentStock.factoryStock - quantity,
        vanStock: currentStock.vanStock + quantity,
      );

      // 7. Update stock in Firebase
      await stockServices.updateStock(updatedStock);

      // 8. Create transaction record
      final transaction = TransactionModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        productId: productId,
        productName: selectedProduct!.productName,
        quantity: quantity,
        type: 'Load Van',
        date: DateTime.now().toString(),
      );

      // 9. Save transaction
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