import 'dart:async';

import 'package:e_stock/core/firebaseServices/product_services.dart';
import 'package:e_stock/core/firebaseServices/stock_services.dart';
import 'package:e_stock/model/product_model.dart';
import 'package:flutter/cupertino.dart';

import '../core/firebaseServices/transaction_services.dart';
import '../model/stock_model.dart';
import '../model/transaction_model.dart';

class ProductViewmodel extends ChangeNotifier {
  //service object
  final ProductServices productServices = ProductServices();
  final StockServices stockServices = StockServices();
  final TransactionServices transactionServices = TransactionServices();

  // product listener
  StreamSubscription<List<ProductModel>>? _productSubscription;

  //list that will hold all products
  List<ProductModel> allProducts = [];

  //list that will  be displayed after searching
  List<ProductModel> displayProducts = [];

  //loading state
  bool isAddingProduct = false;
  bool isLoadingProducts = false; // show error message
  String? errorMessage;

  // create a method addProducts that receive one productModel  and perform the async operation
  // add products
  // Future<bool> addProduct(ProductModel product) async {
  //   isAddingProduct = true;
  //   errorMessage = null;
  //   notifyListeners();
  //
  //   try {
  //     await productServices.addProduct(product);
  //
  //     return true;
  //   } catch (e) {
  //     errorMessage = e.toString();
  //     return false;
  //   } finally {
  //     isAddingProduct = false;
  //     notifyListeners();
  //   }
  // }

  Future<bool> addProduct(
      ProductModel product,
      int initialStock,
      ) async {
    isAddingProduct = true;
    errorMessage = null;
    notifyListeners();

    try {
      // 1. Add product
      await productServices.addProduct(product);

      // 2. Add initial factory stock
      if (initialStock > 0) {
        final stock = StockModel(
          productName: product.productName,
          productId: product.id,
          factoryStock: initialStock,
          vanStock: 0,
        );

        await stockServices.addStock(stock);

        // 3. Record initial stock as a transaction
        final transaction = TransactionModel(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          productId: product.id,
          productName: product.productName,
          type: 'Opening Stock',
          quantity: initialStock,
          date: DateTime.now().toString(),
        );

        await transactionServices.addTransaction(transaction);
      }

      return true;
    } catch (e) {
      errorMessage = e.toString();
      return false;
    } finally {
      isAddingProduct = false;
      notifyListeners();
    }
  }
  // get the products
  void getProducts() {
    // cancel old listener if there is already one
    _productSubscription?.cancel();

    isLoadingProducts = true;
    errorMessage = null;
    notifyListeners();

    _productSubscription = productServices.getProductsStream().listen(
          (products) {
        // update all products
        allProducts = products;

        // update displayed products
        displayProducts = List.from(allProducts);

        isLoadingProducts = false;
        notifyListeners();
      },
      onError: (e) {
        errorMessage = e.toString();
        isLoadingProducts = false;
        notifyListeners();
      },
    );
  }

  // ----------- search the product---
  void searchProducts(String query) {
    if (query.trim().isEmpty) {
      displayProducts = List.from(allProducts);
    } else {
      displayProducts = allProducts.where((product) {
        return product.productName.toLowerCase().contains(query.toLowerCase());
      }).toList();
    }

    notifyListeners();
  }

  // --------edit button
  Future<bool> updateProduct(ProductModel product) async {
    try {
      await productServices.updateProduct(product);

      return true;
    } catch (e) {
      errorMessage = e.toString();
      notifyListeners();

      return false;
    }
  }
  //--------------- delete the product
  Future<bool> deleteProduct(String productId) async {
    try {
      await productServices.deleteProduct(productId);
      await stockServices.deleteStock(productId);

      return true;
    } catch (e) {
      errorMessage = e.toString();
      notifyListeners();

      return false;
    }
  }
  // STOP PRODUCT LISTENER
  Future<void> stopProductListener() async {
    await _productSubscription?.cancel();

    _productSubscription = null;

    // Clear old owner data
    allProducts = [];
    displayProducts = [];

    isLoadingProducts = false;
  }
  @override
  void dispose() {
    _productSubscription?.cancel();
    super.dispose();
  }
}
