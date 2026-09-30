import 'package:e_stock/view_Model/product_viewModel.dart';
import 'package:e_stock/view_Model/profile_viewmodel.dart';
import 'package:flutter/material.dart';

import '../core/firebaseServices/auth_services.dart';

class AuthViewModel extends ChangeNotifier {
  final AuthServices authServices = AuthServices();

  final ProfileViewmodel profileViewmodel;
  final ProductViewmodel productViewmodel;

  AuthViewModel({
    required this.profileViewmodel,
    required this.productViewmodel,
  });

  bool isLoading = false;
  String? errorMessage;
  Map<String, dynamic>? currentUser;


  // ---------------- SIGNUP OWNER ----------------

  Future<bool> signupOwner({
    required String name,
    required String email,
    required String password,
    required String phone,
    required String factoryName,
  }) async {
    isLoading = true;
    errorMessage = null;

    notifyListeners();

    try {
      await authServices.signupOwner(
        name: name,
        email: email,
        password: password,
        phone: phone,
        factoryName: factoryName,
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

  // ------------------------- login owner---------
  Future<bool> loginOwner({
    required String email,
    required String password,
  }) async {
    isLoading = true;
    errorMessage = null;

    notifyListeners();

    try {
      await authServices.loginOwner(
        email: email,
        password: password,
      );
      profileViewmodel.loadOwnerData();
      print('OWNER PROFILE LISTENER STARTED');
      productViewmodel.getProducts();

      return true;
    } catch (e) {
      errorMessage = e.toString();
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // ---------------- CREATE SALESMAN ----------------

  Future<bool> createSalesman({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) async {
    isLoading = true;
    errorMessage = null;

    notifyListeners();

    try {
      await authServices.createSalesman(
        name: name,
        email: email,
        password: password,
        phone: phone,
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


  // -------login salesman-------------
  Future<bool> loginSalesman({
    required String email,
    required String password,
  }) async {
    isLoading = true;
    errorMessage = null;

    notifyListeners();

    try {
      await authServices.loginSalesman(
        email: email,
        password: password,
      );
      profileViewmodel.loadSalesmanData();
      productViewmodel.getProducts();
      return true;
    } catch (e) {
      errorMessage = e.toString();
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
  // ----------sign out---------
  Future<bool> signOut() async {
    isLoading = true;
    errorMessage = null;

    notifyListeners();

    try {

      // Stop Firebase listeners first
      await profileViewmodel.stopProfileListeners();
      await productViewmodel.stopProductListener();

      // Then sign out from Firebase
      await authServices.signOut();

      await Future.delayed(
        const Duration(milliseconds: 500),
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