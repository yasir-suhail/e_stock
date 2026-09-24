import 'package:flutter/material.dart';
import 'package:e_stock/model/customer_model.dart';

import '../core/firebaseServices/customers_services.dart';

class CustomerViewModel extends ChangeNotifier {

  final CustomerServices customerServices =
  CustomerServices();

  List<CustomerModel> allCustomers = [];

  bool isLoading = false;
  String? errorMessage;

  // Add customer
  Future<bool> addCustomer(CustomerModel customer) async {

    try {
      isLoading = true;
      errorMessage = null;
      notifyListeners();

      await customerServices.addCustomer(customer);

      allCustomers.add(customer);

      return true;

    } catch (e) {
      errorMessage = e.toString();
      return false;

    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // Get all customers
  Future<void> getCustomers() async {

    try {
      isLoading = true;
      errorMessage = null;
      notifyListeners();

      allCustomers =
      await customerServices.getCustomers();

    } catch (e) {
      errorMessage = e.toString();

    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // Get one customer by ID
  Future<CustomerModel?> getCustomerById(
      String customerId,
      ) async {

    try {
      return await customerServices.getCustomerById(
        customerId,
      );

    } catch (e) {
      errorMessage = e.toString();
      notifyListeners();
      return null;
    }
  }

  // Update customer
  Future<bool> updateCustomer(
      CustomerModel customer,
      ) async {

    try {
      isLoading = true;
      errorMessage = null;
      notifyListeners();

      await customerServices.updateCustomer(customer);

      final index = allCustomers.indexWhere(
            (item) => item.id == customer.id,
      );

      if (index != -1) {
        allCustomers[index] = customer;
      }

      return true;

    } catch (e) {
      errorMessage = e.toString();
      return false;

    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // Delete customer
  Future<bool> deleteCustomer(
      String customerId,
      ) async {

    try {
      isLoading = true;
      errorMessage = null;
      notifyListeners();

      await customerServices.deleteCustomer(
        customerId,
      );

      allCustomers.removeWhere(
            (item) => item.id == customerId,
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