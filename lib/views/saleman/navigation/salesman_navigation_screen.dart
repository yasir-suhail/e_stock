import 'package:e_stock/core/constants/app_color.dart';
import 'package:e_stock/views/saleman/dashboard/salesman_dashboard_screen.dart';
import 'package:e_stock/views/saleman/profile/salesman_profile_Screen.dart';
import 'package:flutter/material.dart';

class SalesmanNavigationScreen extends StatefulWidget {
  const SalesmanNavigationScreen({super.key});

  @override
  State<SalesmanNavigationScreen> createState() =>
      _SalesmanNavigationScreenState();
}

class _SalesmanNavigationScreenState extends State<SalesmanNavigationScreen> {
  int selectIndex = 0;
  final selectColor = AppColors.vanAmber;
  final unselectedColor = AppColors.textMuted;
  final List<Widget> Screens = [
    SalesmanDashboardScreen(),
    // SalesmanLoadVanScreen(),
    // SalesmanUnloadVanScreen(),
    // SalesmanVanSaleScreen(),
    SalesmanProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Screens[selectIndex],
// body: SalesmanNavigationScreen(),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
          width: 362,
          height: 75,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppColors.inputBorder),
          ),
          child: Row(
            mainAxisAlignment: .spaceEvenly,
            children: [
              Column(
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        selectIndex = 0;
                      });
                    },
                    icon: Icon(
                      Icons.home,
                      color: selectIndex == 0 ? selectColor : unselectedColor,
                    ),
                  ),
                  Text(
                    'Home',
                    style: TextStyle(
                      color: selectIndex == 0 ? selectColor : unselectedColor,
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        selectIndex = 1;
                      });
                    },
                    icon: Icon(
                      Icons.person,
                      color: selectIndex == 1 ? selectColor : unselectedColor,
                    ),
                  ),
                  Text(
                    'Profile',
                    style: TextStyle(
                      color: selectIndex == 1 ? selectColor : unselectedColor,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
