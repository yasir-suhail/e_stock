import 'package:e_stock/core/constants/app_color.dart';
import 'package:e_stock/views/login_screen/login_screen.dart';
import 'package:e_stock/views/widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class OwnerProfileScreen extends StatefulWidget {
  const OwnerProfileScreen({super.key});

  @override
  State<OwnerProfileScreen> createState() => _OwnerProfileScreenState();
}

class _OwnerProfileScreenState extends State<OwnerProfileScreen> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.sizeOf(context).width;
    return Scaffold(
      backgroundColor: AppColors.backgroundCanvas,
      // appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // profile  account container
            Container(
              width: screenWidth,
              height: 100,
              color: AppColors.headerNavy,
              child: Padding(
                padding: const EdgeInsets.only(top: 34, left: 24),
                child: Column(
                  crossAxisAlignment: .start,
                  children: [
                    Text(
                      'Account Profile',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: .bold,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      'Active user account & role details',
                      style: TextStyle(
                        color: AppColors.textMuted,
                        fontSize: 12,
                        fontWeight: .w400,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            // profile container
            Container(
              height: 150,
              width: screenWidth - 32,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppColors.inputBorder),
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 30, left: 20),
                child: Row(
                  crossAxisAlignment: .start,
                  children: [
                    //circle avatar containner
                    Container(
                      width: 90,
                      height: 90,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(90),
                        border: Border.all(
                          color: AppColors.primaryBlue,
                          width: 2,
                        ),
                      ),
                      child: Center(
                        //circle avatar
                        child: CircleAvatar(
                          radius: 50,
                          backgroundColor: Color(0xffEFF6FF),
                          child: Text(
                            'OW',
                            style: TextStyle(
                              color: AppColors.primaryBlue,
                              fontSize: 20,
                              fontWeight: .bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 20),
                    // owner  profile data
                    Column(
                      crossAxisAlignment: .start,
                      children: [
                        SizedBox(height: 10),
                        Text(
                          'Owner Name',
                          style: TextStyle(
                            fontWeight: .bold,
                            fontSize: 16,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Owner@gmail.com',
                          style: TextStyle(
                            fontWeight: .w400,
                            color: AppColors.textMuted,
                            fontSize: 12,
                          ),
                        ),
                        SizedBox(height: 5),
                        // Text('Factory Name',style: TextStyle(fontWeight: .w400,color: AppColors.textMuted,fontSize: 12 )),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            // Factory detail + add salesman + logout
            Container(
              width: screenWidth - 32,
              height: 250,
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.inputBorder),
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: .start,
                  children: [
                    SizedBox(height: 13),
                    Text(
                      'FACTORY NAME',
                      style: TextStyle(
                        color: AppColors.textLabels,
                        fontWeight: .bold,
                        fontSize: 11,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Shan Spice Mills Ltd. ',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: .bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    SizedBox(height: 15),
                    Divider(color: AppColors.inputBorder),
                    SizedBox(height: 15),
                    // add salesman button
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        width: screenWidth - 32,
                        height: 44,
                        decoration: BoxDecoration(
                          color: Color(0xffF8FAFC),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: AppColors.inputBorder),
                        ),
                        child: Center(
                          child: Text(
                            '+ Add Salesman Account',
                            style: TextStyle(
                              color: AppColors.primaryBlue,
                              fontWeight: .bold,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 30,),
                    // logout Button
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
                      },
                      child: Container(
                        width: screenWidth - 32,
                        height: 44,
                        decoration: BoxDecoration(
                          color: AppColors.textPrimary,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: AppColors.inputBorder),
                        ),
                        child: Center(
                          child: Text(
                            'Sign out',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: .bold,
                              fontSize: 13,
                            ),
                          ),
                        ),
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
