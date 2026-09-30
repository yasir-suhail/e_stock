import 'dart:async';

import 'package:flutter/material.dart';
import 'package:e_stock/model/customer_model.dart';

import '../core/firebaseServices/customers_services.dart';

class CustomerViewModel extends ChangeNotifier {

  final CustomerServices customerServices =
  CustomerServices();

  // All customers loaded from Firebase
  List<CustomerModel> allCustomers = [];

  // Customers currently shown on screen
  List<CustomerModel> displayCustomers = [];

  bool isLoading = false;
  String? errorMessage;

  // Firebase customer stream subscription
  StreamSubscription<List<CustomerModel>>?
  _customerSubscription;

  // LISTEN TO CUSTOMERS

  void listenToCustomers() {

    // Prevent creating multiple listeners
    if (_customerSubscription != null) {
      return;
    }

    isLoading = true;
    errorMessage = null;
    notifyListeners();

    _customerSubscription =
        customerServices.getCustomersStream().listen(

              (customers) {

            // Update all customers
            allCustomers = customers;

            // Update displayed customers
            displayCustomers =
                List.from(allCustomers);

            // Stop loading
            isLoading = false;

            // Update UI
            notifyListeners();
          },

          onError: (error) {

            errorMessage = error.toString();

            isLoading = false;

            notifyListeners();
          },
        );
  }

  // ADD CUSTOMER

  Future<bool> addCustomer(
      CustomerModel customer) async {

    // Clear previous error
    errorMessage = null;

    try {

      // Start loading
      isLoading = true;
      notifyListeners();

      // Save customer to Firebase
      await customerServices.addCustomer(
        customer,
      );

      // The Firebase stream will automatically
      // update allCustomers and displayCustomers.

      return true;

    } catch (e) {

      errorMessage = e.toString();

      return false;

    } finally {

      // Stop loading
      isLoading = false;

      notifyListeners();
    }
  }

  // SEARCH CUSTOMERS

  void searchCustomers(String query) {

    // If search box is empty,
    // show all customers
    if (query.isEmpty) {

      displayCustomers =
          List.from(allCustomers);

    } else {

      // Search by name, phone or address
      displayCustomers =
          allCustomers.where((customer) {

            return customer.name
                .toLowerCase()
                .contains(query.toLowerCase()) ||

                customer.phone
                    .toLowerCase()
                    .contains(query.toLowerCase()) ||

                customer.address
                    .toLowerCase()
                    .contains(query.toLowerCase());

          }).toList();
    }

    // Tell UI that displayCustomers changed
    notifyListeners();
  }

  // GET ONE CUSTOMER BY ID

  Future<CustomerModel?> getCustomerById(
      String customerId,
      ) async {

    try {

      return await customerServices
          .getCustomerById(
        customerId,
      );

    } catch (e) {

      errorMessage =
          e.toString();

      notifyListeners();

      return null;
    }
  }

  // UPDATE CUSTOMER

  Future<bool> updateCustomer(
      CustomerModel customer) async {

    try {

      // Start loading
      isLoading = true;
      errorMessage = null;
      notifyListeners();

      // Update Firebase
      await customerServices
          .updateCustomer(
        customer,
      );

      // Firebase stream will automatically
      // update the local lists.

      return true;

    } catch (e) {

      errorMessage =
          e.toString();

      return false;

    } finally {

      // Stop loading
      isLoading = false;

      notifyListeners();
    }
  }

  // DELETE CUSTOMER

  Future<bool> deleteCustomer(
      String customerId) async {

    try {

      // Start loading
      isLoading = true;
      errorMessage = null;
      notifyListeners();

      // Delete from Firebase
      await customerServices
          .deleteCustomer(
        customerId,
      );

      // Firebase stream will automatically
      // update the local lists.

      return true;

    } catch (e) {

      errorMessage =
          e.toString();

      return false;

    } finally {

      // Stop loading
      isLoading = false;

      notifyListeners();
    }
  }

  // DISPOSE

  @override
  void dispose() {

    // Stop listening to Firebase
    _customerSubscription?.cancel();

    super.dispose();
  }
}