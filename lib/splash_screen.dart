import 'dart:async';

import 'package:e_stock/core/constants/app_color.dart';
import 'package:e_stock/views/login/login_screen.dart';
import 'package:e_stock/views/owner/navigation/navigation_screen.dart';
import 'package:e_stock/views/saleman/navigation/salesman_navigation_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final FirebaseAuth auth = FirebaseAuth.instance;

  final DatabaseReference ownerUsers =
  FirebaseDatabase.instance.ref('owner');

  final DatabaseReference salesmanUsers =
  FirebaseDatabase.instance.ref('salesman');

  @override
  void initState() {
    super.initState();

    checkUser();
  }

  Future<void> checkUser() async {
    await Future.delayed(
      const Duration(seconds: 3),
    );

    final User? user = auth.currentUser;

    if (user == null) {
      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        ),
      );

      return;
    }

    final String uid = user.uid;

    final DataSnapshot ownerSnapshot =
    await ownerUsers.child(uid).get();

    if (ownerSnapshot.exists) {
      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const NavigationScreen(),
        ),
      );

      return;
    }

    final DataSnapshot salesmanSnapshot =
    await salesmanUsers.child(uid).get();

    if (salesmanSnapshot.exists) {
      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const SalesmanNavigationScreen(),
        ),
      );

      return;
    }

    // User exists in Firebase Authentication
    // but does not exist in our owner or salesman database.
    await auth.signOut();

    if (!mounted) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.headerNavy,
      body: Center(
        child: CircularProgressIndicator(
          color: AppColors.whiteColor,
          strokeWidth: 2,
        ),
      ),
    );
  }
}