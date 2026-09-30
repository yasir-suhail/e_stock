import 'package:e_stock/core/firebaseServices/customers_services.dart';
import 'package:e_stock/core/firebaseServices/stock_services.dart';
import 'package:e_stock/core/firebaseServices/transaction_services.dart';
import 'package:e_stock/model/customer_model.dart';
import 'package:e_stock/model/product_model.dart';
import 'package:e_stock/model/stock_model.dart';
import 'package:e_stock/model/transaction_model.dart';
import 'package:flutter/cupertino.dart';

class FactorySaleViewmodel extends ChangeNotifier {

  // services
  final StockServices stockServices = StockServices();
  final TransactionServices transactionServices = TransactionServices();
  final CustomerServices customerServices = CustomerServices();
  // final CustomerServices customerServices = CustomerServices();

  // loading state
  bool isLoading = false;

// error Message
  String? errorMessage;

  ProductModel? selectedProduct;

  // select product
  void selectProduct(ProductModel? product) {
    selectedProduct = product;
    notifyListeners();
  }

// sale product from factory ;

  Future<bool> factorySale({
    required String productId,
    required int quantity,
    required String customerId,
  }) async {
    try {
      isLoading = true;
      errorMessage = null;
      notifyListeners();
      // check a product is selected
      if (selectedProduct == null) {
        errorMessage = 'please select a product ';
        return false;
      }
      // checked quantity
      if (quantity <= 0) {
        errorMessage = ' Quantity must be greater than 0';
        return false;
      }
      // cusotmer validation
      if (customerId.trim().isEmpty) {
        errorMessage = 'Please enter customer name';
        return false;
      }
      //get current stock

      final currentStock = await stockServices.getStockByProductId(productId);
      if (currentStock == null) {
        errorMessage = ' Stock not found';
        return false;
      }
      // check factory stock
      if (currentStock.factoryStock < quantity) {
        errorMessage = 'Not enough factory stock';
        return false;
      }
      //calculated the updated stock
      final updatedStock = StockModel(
        productId: currentStock.productId,
        productName: selectedProduct!.productName,
        factoryStock: currentStock.factoryStock - quantity,
        vanStock: currentStock.vanStock,
      );
      // updated the stock in the firebase
      await stockServices.updateStock(updatedStock);

      // create the customer
      // final customer = CustomerModel(
      //   id: DateTime.now().millisecondsSinceEpoch.toString(),
      //   name: customerName.trim(),
      //   address: '',
      //   phone: '',
      // );
      // // save it into firebase
      // await customerServices.addCustomer(customer);

      // create factory sale transaction
      final transaction = TransactionModel(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          productId: productId,
        productName: selectedProduct!.productName,
        customerId: customerId,
        quantity: quantity,
          type: 'Factory Sale',
          date: DateTime.now().toString(),
          );

      // save the transaction
      await transactionServices.addTransaction(transaction);

      return true;
    }
    catch(e){
      errorMessage =e.toString();
      return false;
    }
    finally{
      isLoading= false;
      notifyListeners();
    }
  }
}