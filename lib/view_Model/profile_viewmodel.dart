// import 'package:e_stock/core/firebaseServices/profile_services.dart';
// import 'package:e_stock/model/owner_model.dart';
// import 'package:e_stock/model/salesman_model.dart';
// import 'package:flutter/cupertino.dart';
//
// class ProfileViewmodel extends ChangeNotifier {
//   // Profile service
//   final ProfileServices profileServices = ProfileServices();
//
//   // Loading state
//   bool isLoading = false;
//
//   // Error message
//   String? errorMessage;
//
//   // Owner data
//   OwnerModel? owner;
//
//   // Salesman data
//   SalesmanModel? salesman;
//
//   // LOAD OWNER DATA
//
//   Future<void> loadOwnerData() async {
//     // Start loading
//     isLoading = true;
//
//     // Clear previous error
//     errorMessage = null;
//
//     // Tell the UI that loading has started
//     notifyListeners();
//
//     try {
//       // Get owner data from ProfileServices
//       owner = await profileServices.getOwnerData();
//     } catch (e) {
//       // Store error message
//       errorMessage = e.toString().replaceFirst(
//         'Exception: ',
//         '',
//       );
//     } finally {
//       // Stop loading
//       isLoading = false;
//
//       // Update the UI
//       notifyListeners();
//     }
//   }
//
//   // LOAD SALESMAN DATA
//
//   Future<void> loadSalesmanData() async {
//     // Start loading
//     isLoading = true;
//
//     // Clear previous error
//     errorMessage = null;
//
//     // Tell the UI that loading has started
//     notifyListeners();
//
//     try {
//       // Get salesman data from ProfileServices
//       salesman = await profileServices.getSalesmanData();
//     } catch (e) {
//       // Store error message
//       errorMessage = e.toString().replaceFirst(
//         'Exception: ',
//         '',
//       );
//     } finally {
//       // Stop loading
//       isLoading = false;
//
//       // Update the UI
//       notifyListeners();
//     }
//   }
// }
import 'dart:async';

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

  // Owner stream subscription
  StreamSubscription<OwnerModel?>? _ownerSubscription;

  // Salesman stream subscription
  StreamSubscription<SalesmanModel?>? _salesmanSubscription;

  // LOAD OWNER DATA

  void loadOwnerData() {
    // Cancel previous listener if it already exists
    _ownerSubscription?.cancel();

    // Start loading
    isLoading = true;

    // Clear previous error
    errorMessage = null;

    // Tell the UI that loading has started
    notifyListeners();

    // Listen to owner data from ProfileServices
    _ownerSubscription =
        profileServices.ownerDataStream().listen(
              (data) {
            // Store owner data
            owner = data;

            // Stop loading
            isLoading = false;

            // Update the UI
            notifyListeners();
          },
          onError: (e) {
            // Store error message
            errorMessage = e.toString().replaceFirst(
              'Exception: ',
              '',
            );

            // Stop loading
            isLoading = false;

            // Update the UI
            notifyListeners();
          },
        );
  }

  // LOAD SALESMAN DATA

  void loadSalesmanData() {
    // Cancel previous listener if it already exists
    _salesmanSubscription?.cancel();

    // Start loading
    isLoading = true;

    // Clear previous error
    errorMessage = null;

    // Tell the UI that loading has started
    notifyListeners();

    // Listen to salesman data from ProfileServices
    _salesmanSubscription =
        profileServices.salesmanDataStream().listen(
              (data) {
            // Store salesman data
            salesman = data;

            // Stop loading
            isLoading = false;

            // Update the UI
            notifyListeners();
          },
          onError: (e) {
            // Store error message
            errorMessage = e.toString().replaceFirst(
              'Exception: ',
              '',
            );

            // Stop loading
            isLoading = false;

            // Update the UI
            notifyListeners();
          },
        );
  }

  // DISPOSE

  @override
  void dispose() {
    // Cancel owner listener
    _ownerSubscription?.cancel();

    // Cancel salesman listener
    _salesmanSubscription?.cancel();

    super.dispose();
  }
}