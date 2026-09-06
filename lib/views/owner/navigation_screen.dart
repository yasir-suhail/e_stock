import 'package:e_stock/core/constants/app_color.dart';
import 'package:e_stock/views/owner/load_van_screen.dart';
import 'package:e_stock/views/owner/unload_van_screen.dart';
import 'package:e_stock/views/owner/van_sale_screen.dart';
import 'package:e_stock/views/owner/add_Produciton_Screen.dart';
import 'package:e_stock/views/owner/factory_sale_screen.dart';
import 'package:e_stock/views/owner/logs_screen.dart';
import 'package:e_stock/views/owner/owner_dashboard_screen.dart';
import 'package:e_stock/views/owner/owner_profile_Screen.dart';
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
    // We also pass functions to OwnerDashboardScreen.
    // When the dashboard cards are clicked,
    // those functions will be called.
    currentScreen =OwnerDashboardScreen(
        onLoadVan: openLoadVan,
        onUnloadVan: openUnloadVan,
        onFactorySale: openFactorySale,
        onVanSale: openVanSale,
        onAddProduction : addProduction,
    );
  }
  // Replace the current screen with LoadVanScreen.
  void openLoadVan(){
    setState(() {
      currentScreen=LoadVanScreen(onBack: openDashboard,);
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
  void addProduction(){
    setState(() {
      currentScreen = AddProducitonScreen(onBack: openDashboard,);
    });
  }

  // Back to dashboard
  void openDashboard(){
    setState(() {
      // Put the Dashboard back into currentScreen.
      // We pass the same callback functions again
      // so the Dashboard cards continue to work.
       currentScreen = OwnerDashboardScreen(
           onLoadVan: openLoadVan,
           onUnloadVan: openUnloadVan,
           onFactorySale: openFactorySale,
           onVanSale: openVanSale,
           onAddProduction: addProduction,
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
      bottomNavigationBar: CustomBottomNavigation(selectedIndex: selectIndex, onItemSelected: (index){
        setState(() {
          selectIndex = index;
        });
        if(index==0){
          openDashboard();
        }else if(index==1){
          setState(() {
            currentScreen=LogsScreen();
          });
        }else if(index==2){
          setState(() {
            currentScreen =OwnerProfileScreen();
          });
        }
      })
    );
  }
}
