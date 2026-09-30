import 'package:firebase_database/firebase_database.dart';
import 'package:e_stock/model/product_model.dart';

import 'auth_services.dart';

class ProductServices {
  // Reference to the products node in Firebase
  final DatabaseReference productsReference = FirebaseDatabase.instance.ref(
    'products',
  );
  //Auth services
  final AuthServices authServices = AuthServices();
  //  current owner product reference
  DatabaseReference get productReference {
    final String? uid = authServices.currentUserId;

    if (uid == null) {
      throw Exception('User is not logged in');
    }

    return productsReference.child(uid);
  }

  // -------------ADD PRODUCT
  Future<void> addProduct(ProductModel product) async {
    await productReference.child(product.id).set(product.toMap());
  }

  // --------------GET PRODUCTS
  Stream<List<ProductModel>> getProductsStream() {
    return productReference.onValue.map((event) {

      if (!event.snapshot.exists) {
        return [];
      }

      // convert the whole firebase result data to map
      final Map<String, dynamic> data = Map<String, dynamic>.from(
        event.snapshot.value as Map,
      );

      // now go through each product and convert the single product data to a map
      // entry.value represent one product data
      return data.entries.map((entry) {

        final Map<String, dynamic> productData = Map<String, dynamic>.from(
          entry.value,
        );

        // convert that single map to a product object/model
        return ProductModel.fromMap(productData);

      }).toList();
    });
  }
  // ---------UPDATE PRODUCT
  Future<void> updateProduct(ProductModel product) async {
    await productReference.child(product.id).update(product.toMap());
  }

  // ------------DELETE PRODUCT
  Future<void> deleteProduct(String productId) async {
    await productReference.child(productId).remove();
  }
}

// ---------------------- note:  to get the products
// Firebase whole data
// ↓
// Map
// ↓
// separate each product
// ↓
// one product Map
// ↓
// ProductModel
