import 'package:e_stock/core/firebaseServices/profile_services.dart';
import 'package:e_stock/model/owner_model.dart';
import 'package:e_stock/model/salesman_model.dart';
import 'package:flutter/cupertino.dart';

class ProfileViewmodel extends ChangeNotifier {
  // Profile service
  final ProfileServices profileServices = ProfileServices();

  // Loading state
  bool isLoading = false;

  // Error message
  String? errorMessage;

  // Owner data
  OwnerModel? owner;

  // Salesman data
  SalesmanModel? salesman;

  // LOAD OWNER DATA

  Future<void> loadOwnerData() async {
    // Start loading
    isLoading = true;

    // Clear previous error
    errorMessage = null;

    // Tell the UI that loading has started
    notifyListeners();

    try {
      // Get owner data from ProfileServices
      owner = await profileServices.getOwnerData();
    } catch (e) {
      // Store error message
      errorMessage = e.toString().replaceFirst(
        'Exception: ',
        '',
      );
    } finally {
      // Stop loading
      isLoading = false;

      // Update the UI
      notifyListeners();
    }
  }

  // LOAD SALESMAN DATA

  Future<void> loadSalesmanData() async {
    // Start loading
    isLoading = true;

    // Clear previous error
    errorMessage = null;

    // Tell the UI that loading has started
    notifyListeners();

    try {
      // Get salesman data from ProfileServices
      salesman = await profileServices.getSalesmanData();
    } catch (e) {
      // Store error message
      errorMessage = e.toString().replaceFirst(
        'Exception: ',
        '',
      );
    } finally {
      // Stop loading
      isLoading = false;

      // Update the UI
      notifyListeners();
    }
  }
}