import 'package:e_stock/core/constants/app_color.dart';
import 'package:e_stock/views/login_screen/owner/owner_tab.dart';
import 'package:e_stock/views/login_screen/saleman/saleman_tab.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // 1. Changed from boolean to integer index
  int selectedTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.sizeOf(context).width;
    return Scaffold(
      backgroundColor: AppColors.backgroundCanvas,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.headerNavy,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'E Khata Portal',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 6),
            Text(
              'Select role or log into your account',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: AppColors.textMuted,
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
             SizedBox(height: 20),
            // A containner
            Container(
              width: screenWidth - 32,
              height: 500,
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.inputBorder),
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),
                    Center(
                      //A container for the owner and salman button
                      child: Container(
                        height: 56,
                        width: 298,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppColors.inputBorder,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // --- OWNER TAB BUTTON ---
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedTabIndex =
                                        0; // Changes to Owner tab index
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: selectedTabIndex == 0
                                        // ?  Color(0xff2563EB)
                                        ? AppColors.primaryBlue
                                        // : Colors.transparent,
                                        : AppColors.inputBorder,

                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Owner Portal',
                                      style: TextStyle(
                                        color: selectedTabIndex == 0
                                            ? Colors.white
                                            : AppColors.textMuted,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            // --- SALESMAN TAB BUTTON ---
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedTabIndex =
                                        1; // Changes to Salesman tab index
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: selectedTabIndex == 1
                                        ? AppColors.primaryBlue
                                        :
                                          // : Colors.transparent,
                                          AppColors.inputBorder,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Salesman Portal',
                                      style: TextStyle(
                                        color: selectedTabIndex == 1
                                            ? Colors.white
                                            : AppColors.textMuted,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20),

                    //  with IndexedStack to keep both forms in memory
                    Expanded(
                      child: IndexedStack(
                        index: selectedTabIndex,
                        children: [
                          OwnerForm(), // Index 0
                          SalemanForm(), // Index 1
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
