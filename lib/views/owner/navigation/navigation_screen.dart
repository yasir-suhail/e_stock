import 'package:e_stock/core/constants/app_color.dart';
import 'package:e_stock/views/owner/load_van/load_van_screen.dart';
import 'package:e_stock/views/owner/products/products.dart';
import 'package:e_stock/views/owner/unload_van/unload_van_screen.dart';
import 'package:e_stock/views/owner/van_sale/van_sale_screen.dart';
import 'package:e_stock/views/owner/production/add_Production_Product_Screen.dart';
import 'package:e_stock/views/owner/factory_sale/factory_sale_screen.dart';
import 'package:e_stock/views/owner/logs/logs_screen.dart';
import 'package:e_stock/views/owner/dashboard/owner_dashboard_screen.dart';
import 'package:e_stock/views/owner/profile/owner_profile_Screen.dart';
import 'package:e_stock/views/widget/custom_ottom_navigation.dart';
import 'package:flutter/material.dart';

class NavigationScreen extends StatefulWidget {

  const NavigationScreen({super.key});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}
class _NavigationScreenState extends State<NavigationScreen> {
  //  Track  the selected Bottom navigation index
  int selectIndex = 0;

  final List<Widget> Screens = [
    OwnerDashboardScreen(),
    LogsScreen(),
    ProductsScreen(),
    OwnerProfileScreen(),

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Screens[selectIndex],
      bottomNavigationBar: CustomBottomNavigation(selectedIndex: selectIndex, onItemSelected: (index){
        setState(() {
          selectIndex = index;
        });
      },
      )
    );
  }
}
