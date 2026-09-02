import 'package:e_stock/views/common/load_van_screen.dart';
import 'package:e_stock/views/login_screen/login_screen.dart';
import 'package:e_stock/views/owner/navigation_screen.dart';
import 'package:e_stock/views/owner/owner_dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // colorScheme: .fromSeed(seedColor: Colors.deepPurple),
        fontFamily: 'Inter'
      ),
      // home:LoadVanScreen(isOwnerView: true)
      home: NavigationScreen(),
    );
  }
}

