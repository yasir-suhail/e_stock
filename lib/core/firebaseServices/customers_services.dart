import 'package:firebase_database/firebase_database.dart';
import 'package:e_stock/model/customer_model.dart';

import 'auth_services.dart';

class CustomerServices {

  // Auth services
  // final AuthServices authServices = AuthServices();

  final DatabaseReference customerReference =
  FirebaseDatabase.instance.ref('customers');

  // Current owner's customers reference
  // DatabaseReference get customerReference {
  //
  //   final String? uid = authServices.currentUserId;
  //
  //   if (uid == null) {
  //     throw Exception('User is not logged in');
  //   }
  //
  //   return customersReference.child(uid);
  // }
  // Add a new customer
  Future<void> addCustomer(CustomerModel customer) async {
    await customerReference
        .child(customer.id)
        .set(customer.toMap());
  }

  // Get all customers
  Future<List<CustomerModel>> getCustomers() async {

    final snapshot = await customerReference.get();

    if (!snapshot.exists) {
      return [];
    }

    final data = Map<String, dynamic>.from(
      snapshot.value as Map,
    );

    return data.values.map((item) {
      return CustomerModel.fromMap(
        Map<String, dynamic>.from(item),
      );
    }).toList();
  }

  // Get one customer by ID
  Future<CustomerModel?> getCustomerById(
      String customerId,
      ) async {

    final snapshot =
    await customerReference.child(customerId).get();

    if (!snapshot.exists) {
      return null;
    }

    final customerData = Map<String, dynamic>.from(
      snapshot.value as Map,
    );

    return CustomerModel.fromMap(customerData);
  }

  // Update customer
  Future<void> updateCustomer(CustomerModel customer) async {
    await customerReference
        .child(customer.id)
        .update(customer.toMap());
  }

  // Delete customer
  Future<void> deleteCustomer(String customerId) async {
    await customerReference
        .child(customerId)
        .remove();
  }
}