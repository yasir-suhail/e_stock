import 'package:e_stock/core/firebaseServices/customers_services.dart';
import 'package:e_stock/core/firebaseServices/stock_services.dart';
import 'package:e_stock/core/firebaseServices/transaction_services.dart';
import 'package:e_stock/model/product_model.dart';
import 'package:e_stock/model/stock_model.dart';
import 'package:e_stock/model/transaction_model.dart';
import 'package:flutter/cupertino.dart';

class VanSaleViewmodel extends ChangeNotifier {
  final StockServices stockServices = StockServices();
  final TransactionServices transactionServices = TransactionServices();
  final CustomerServices customerServices = CustomerServices();

  // loading
  bool isLoading = false;

  // error message
  String? errorMessage;

  ProductModel? selectedProduct;

  // selected product
  void selectProduct(ProductModel? product) {
    selectedProduct = product;
    notifyListeners();
  }

  // sale product from van
  Future<bool> vanSale({
    required String productId,
    required int quantity,
    required String customerId,
    required String customerName
  }) async {
    try {
      isLoading = true;
      errorMessage = null;
      notifyListeners();

      // check product is selected
      if (selectedProduct == null) {
        errorMessage = 'please select a product ';
        return false;
      }

      // checked quantity
      if (quantity <= 0) {
        errorMessage = 'Quantity must be greater than 0 ';
        return false;
      }

      // customer validation
      if (customerId.trim().isEmpty) {
        errorMessage = 'Please select a customer';
        return false;
      }

      if (customerName.trim().isEmpty) {
        errorMessage = 'Customer name not found';
        return false;
      }

      // get the current stock

      final currentStock = await stockServices.getStockByProductId(productId);
      if (currentStock == null) {
        errorMessage = ' stock not found ';
        return false;
      }

      // check van  stock
      if (currentStock.vanStock < quantity) {
        errorMessage = ' Not enough van stock ';
        return false;
      }

      // calculated the updated stock
      final updatedStock =  StockModel(
        productId: currentStock.productId,
        productName: selectedProduct!.productName,
        factoryStock: currentStock.factoryStock,
        vanStock: currentStock.vanStock - quantity,
      );
      // save the updated stock in the firbase
      await stockServices.updateStock(updatedStock);

      // add the record in the transaction
      final transaction = TransactionModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        productId: productId,
        productName: selectedProduct!.productName,
        customerId: customerId,
        customerName: customerName,
        quantity: quantity,
        type: 'Van sale',
        date: DateTime.now().toString(),
      );
      // save the transaction record in the firebase
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
