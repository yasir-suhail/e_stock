import 'package:e_stock/core/constants/app_color.dart';
import 'package:e_stock/views/widget/custom_ottom_navigation.dart' hide CustomBottomNavigation, BottomNavItem;
import 'package:e_stock/views/example_bottom navigation/custom_bottomNav.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ExmNavigationScreen extends StatefulWidget {
  const ExmNavigationScreen({super.key});

  @override
  State<ExmNavigationScreen> createState() => _ExmNavigationScreenState();
}

class _ExmNavigationScreenState extends State<ExmNavigationScreen> {
  int selectIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CustomBottomNav(
        selectedIndex: selectIndex,

        onItemSelected: (index) {
          setState(() {
            selectIndex = index;
          });
        },

        items: [
          BottomNavItem(
            icon: (color) => Icon(
              Icons.home,
              color: color,
            ),
            label: 'Home',
          ),

          BottomNavItem(
            icon: (color) => Icon(Icons.history,
              color: color,),

            label: 'Logs',
          ),

          BottomNavItem(
            icon: (color) => Icon(
              Icons.person,
              color: color,
            ),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}