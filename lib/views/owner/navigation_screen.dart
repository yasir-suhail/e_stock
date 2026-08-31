import 'package:e_stock/views/owner/logs_screen.dart';
import 'package:e_stock/views/owner/owner_dashboard_screen.dart';
import 'package:e_stock/views/owner/owner_profile_Screen.dart';
import 'package:flutter/material.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}
final selectedIconColor =Color(0xff2563EB);// selcted color of icon+text
final unselectedIconsColor =Color(0xffB5BCC7);// unselected icon+text color
class _NavigationScreenState extends State<NavigationScreen> {
  int selectIndex = 0;
  final List<Widget> Screens = [
    OwnerDashboardScreen(),
    LogsScreen(),
    OwnerProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Screens[selectIndex],
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
          width: 362,
          height: 88,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.black),
          ),
          child: Row(
            mainAxisAlignment: .spaceEvenly,
            children: [
              Column(
                // mainAxisAlignment: .center,
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        selectIndex = 0;
                      });
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
                      setState(() {
                        selectIndex = 1;
                      });
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
                      setState(() {
                        selectIndex = 2;
                      });
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
