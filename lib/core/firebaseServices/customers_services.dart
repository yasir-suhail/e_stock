import 'package:firebase_database/firebase_database.dart';
import 'package:e_stock/model/customer_model.dart';

import 'auth_services.dart';

class CustomerServices {

  // Auth services
  final AuthServices authServices = AuthServices();

  final DatabaseReference customersReference =
  FirebaseDatabase.instance.ref('customers');

  // Current owner's customers reference
  DatabaseReference get customerReference {

    final String? uid = authServices.currentUserId;

    if (uid == null) {
      throw Exception('User is not logged in');
    }

    return customersReference.child(uid);
  }

  // ADD CUSTOMER

  Future<void> addCustomer(
      CustomerModel customer) async {

    await customerReference
        .child(customer.id)
        .set(customer.toMap());
  }

  // GET CUSTOMERS AS STREAM

  Stream<List<CustomerModel>> getCustomersStream() {

    return customerReference.onValue.map((event) {

      final snapshot = event.snapshot;

      // No customers in Firebase
      if (!snapshot.exists) {
        return <CustomerModel>[];
      }

      final data = Map<String, dynamic>.from(
        snapshot.value as Map,
      );

      // Convert Firebase data into CustomerModel list
      return data.values.map((item) {

        return CustomerModel.fromMap(
          Map<String, dynamic>.from(item),
        );

      }).toList();
    });
  }

  // GET ONE CUSTOMER BY ID

  Future<CustomerModel?> getCustomerById(
      String customerId,
      ) async {

    final snapshot =
    await customerReference
        .child(customerId)
        .get();

    if (!snapshot.exists) {
      return null;
    }

    final customerData =
    Map<String, dynamic>.from(
      snapshot.value as Map,
    );

    return CustomerModel.fromMap(
      customerData,
    );
  }

  // UPDATE CUSTOMER

  Future<void> updateCustomer(
      CustomerModel customer) async {

    await customerReference
        .child(customer.id)
        .update(customer.toMap());
  }

  // DELETE CUSTOMER

  Future<void> deleteCustomer(
      String customerId) async {

    await customerReference
        .child(customerId)
        .remove();
  }
}