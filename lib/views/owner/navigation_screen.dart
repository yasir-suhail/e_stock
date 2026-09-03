import 'package:e_stock/core/constants/app_color.dart';
import 'package:e_stock/views/common/load_van_screen.dart';
import 'package:e_stock/views/common/unload_van_screen.dart';
import 'package:e_stock/views/common/van_sale_screen.dart';
import 'package:e_stock/views/owner/factory_sale_screen.dart';
import 'package:e_stock/views/owner/logs_screen.dart';
import 'package:e_stock/views/owner/owner_dashboard_screen.dart';
import 'package:e_stock/views/owner/owner_profile_Screen.dart';
import 'package:flutter/material.dart';

class NavigationScreen extends StatefulWidget {

  const NavigationScreen({super.key});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}
final selectedIconColor =AppColors.primaryBlue;// selected color of icon+text
final unselectedIconsColor =Color(0xff64748B);// unselected icon+text color
class _NavigationScreenState extends State<NavigationScreen> {
  //  Track  the selected Bottom navigation index
  int selectIndex = 0;

  // This stores the screen that should currently appear
  // in the body of the Scaffold.
  //
  // Instead of Navigator.push(), we simply change this widget.
  late Widget currentScreen;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // When NavigationScreen starts,
    // the Dashboard is shown first.
    //
    // We also pass functions to OwnerDashboardScreen.
    // When the dashboard cards are clicked,
    // those functions will be called.
    currentScreen =OwnerDashboardScreen(
        onLoadVan: openLoadVan,
        onUnloadVan: openUnloadVan,
        onFactorySale: openFactorySale,
        onVanSale: openVanSale
    );
  }
  // Replace the current screen with LoadVanScreen.
  void openLoadVan(){
    setState(() {
      currentScreen=LoadVanScreen(isOwnerView: true, onBack: openDashboard,);
    });
  }
  // Replace the Dashboard with UnloadVanScreen.
  void openUnloadVan(){
    setState(() {
      currentScreen = UnloadVanScreen(onBack: openDashboard);
    });
  }
  // Replace the Dashboard with FactorySaleScreen.
  void openFactorySale(){
    setState(() {
      currentScreen = FactorySaleScreen(onBack: openDashboard);
    });
  }
  // Replace the Dashboard with VansaleScreen.
  void openVanSale(){
    setState(() {
      currentScreen =VansaleScreen(onBack: openDashboard);
    });
  }

  // Back to dashboard
  void openDashboard(){
    setState(() {
      // Put the Dashboard back into currentScreen.
      //
      // We pass the same callback functions again
      // so the Dashboard cards continue to work.
       currentScreen = OwnerDashboardScreen(
           onLoadVan: openLoadVan,
           onUnloadVan: openUnloadVan,
           onFactorySale: openFactorySale,
           onVanSale: openVanSale
       );
    });
  }

  // final List<Widget> Screens = [
  //   OwnerDashboardScreen(),
  //   LogsScreen(),
  //   OwnerProfileScreen(),
  // ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: Screens[selectIndex],

      // currentScreen decides what appears above
      // the bottom navigation bar.
      body: currentScreen,
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
                // mainAxisAlignment: .center,
                children: [
                  IconButton(
                    onPressed: () {
                      // Change the selected bottom navigation
                      // item to Home.
                      setState(() {
                        selectIndex = 0;
                      });
                      // Show the Dashboard again.
                      openDashboard();
                    },
                    icon: Icon(Icons.home,color: selectIndex==0?selectedIconColor:unselectedIconsColor,),
                  ),
                  Text('Home',style: TextStyle(color: selectIndex==0?selectedIconColor:unselectedIconsColor),),
                ],
              ),
              Column(
                children: [
                  IconButton(
                    onPressed: () {
                      // Change selected item to Logs
                      setState(() {
                        selectIndex = 1;
                      });
                      //  change the current screen to logs.
                      currentScreen = LogsScreen();
                    },
                    icon: Icon(Icons.history,color: selectIndex==1?selectedIconColor:unselectedIconsColor,),
                  ),
                  Text('Logs',style: TextStyle(color: selectIndex==1?selectedIconColor:unselectedIconsColor)),
                ],
              ),
              Column(
                children: [
                  IconButton(
                    onPressed: () {
                      // Change selected item to Profile
                      setState(() {
                        selectIndex = 2;
                      });
                      //  change the current screen to profile.
                      currentScreen = OwnerProfileScreen();
                    },
                    icon: Icon(Icons.person,color: selectIndex==2?selectedIconColor:unselectedIconsColor,),
                  ),
                  Text('Profile',style: TextStyle(color: selectIndex==2?selectedIconColor:unselectedIconsColor)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
