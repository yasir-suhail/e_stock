import 'package:flutter/material.dart';

import '../core/firebaseServices/firebase_services.dart';

class AuthViewModel extends ChangeNotifier {
  final FirebaseServices _firebaseServices = FirebaseServices();

  bool isLoading = false;
  String? errorMessage;

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
      await _firebaseServices.signupOwner(
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
      await _firebaseServices.loginOwner(
        email: email,
        password: password,
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
      await _firebaseServices.createSalesman(
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
      await _firebaseServices.loginSalesman(
        email: email,
        password: password,
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
  // ----------sign out---------
  Future<bool> signOut() async {
    isLoading = true;
    errorMessage = null;

    notifyListeners();

    try {
      await _firebaseServices.signOut();

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