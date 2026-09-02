import 'package:e_stock/core/constants/app_color.dart';
import 'package:flutter/material.dart';

class OwnerDashboardScreen extends StatefulWidget {
  const OwnerDashboardScreen({super.key});

  @override
  State<OwnerDashboardScreen> createState() => _OwnerDashboardScreenState();
}

class _OwnerDashboardScreenState extends State<OwnerDashboardScreen> {
  int selectCard = 0;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    return Scaffold(
      backgroundColor: AppColors.backgroundCanvas,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: .start,
          children: [
            //A dashboard container
            Container(
              width: screenWidth,
              height: 100,
              decoration: BoxDecoration(color: AppColors.headerNavy),
              child: Padding(
                padding: const EdgeInsets.only(top: 34, left: 24),
                child: Column(
                  crossAxisAlignment: .start,
                  children: [
                    Text(
                      'Dashboard',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: .bold,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      'Global Stock Overview & Operations',
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
            Stack(
              children: [
                Center(
                  child: Container(
                    width: screenWidth - 20,
                    height: 100,
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.inputBorder),
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                  ),
                ),
                //position the text of active product
                Positioned(
                  top: 11,
                  left: 18,
                  child: Column(
                    crossAxisAlignment: .start,
                    children: [
                      Text(
                        'GLOBAL ACTIVE PRODUCT',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: .bold,
                          color: AppColors.primaryBlue,
                        ),
                      ),
                      SizedBox(height: 7),
                      Text(
                        'Red Chili Powder 200g',
                        style: TextStyle(
                          color: AppColors.textPrimary,
                          fontWeight: .bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                // position the drop down menu
                Positioned(
                  top: 16,
                  right: 18,
                  child: DropdownMenu<String>(
                    label: Text(
                      'change',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: .bold,
                        color: AppColors.primaryBlue,
                      ),
                    ),
                    inputDecorationTheme: InputDecorationTheme(
                      fillColor: Color(0xffEFF6FF),
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Color(0xffBFDBFE)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xffBFDBFE)),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    // initialSelection: 'male',
                    dropdownMenuEntries: [
                      DropdownMenuEntry(value: '', label: ''),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 15),
            // Row for  factory stock  and the van stock
            Row(
              mainAxisAlignment: .center,
              children: [
                //left side column
                Column(
                  children: [
                    Container(
                      width: screenWidth / 2 - 15,
                      height: 120,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: AppColors.inputBorder),
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 10),
                //Right side Column
                Column(
                  children: [
                    Container(
                      width: screenWidth / 2 - 15,
                      height: 120,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: AppColors.inputBorder),
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: .start,
                children: [
                  Text(
                    'INVENTORY ACTIONS',
                    style: TextStyle(
                      color: AppColors.textLabels,
                      fontWeight: .bold,
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(height: 9),
                  //  1 Row  inventory actions of the load van and the unload van
                  Row(
                    children: [
                      // left side of the first Row  of the inventory action
                      //load van container
                      InkWell(
                        borderRadius: BorderRadius.circular(10),
                        onTap: () {
                          setState(() {
                            selectCard = 0;
                          });
                        },
                        child: Container(
                          width: screenWidth / 2 - 15,
                          height: 80,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),

                            border: Border.all(color: AppColors.inputBorder),
                            color: selectCard == 0
                                ? AppColors.primaryBlue
                                : Colors.white,
                          ),
                          child: Center(child: Text('🚚 Load Van',style: TextStyle(fontWeight: .bold,fontSize: 14,color: selectCard==0?Colors.white:AppColors.textPrimary),),),
                        ),
                      ),
                      SizedBox(width: 10),
                      // right side of the first Row of the inventory action
                      // unload van container
                      InkWell(
                        borderRadius: BorderRadius.circular(10),
                        onTap: () {
                          setState(() {
                            selectCard = 1;
                          });
                        },
                        child: Container(
                          width: screenWidth / 2 - 15,
                          height: 80,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: AppColors.inputBorder),
                            color: selectCard == 1
                                ? AppColors.primaryBlue
                                : Colors.white,
                          ),
                          child: Center(child: Text('🔄 Unload Van',style: TextStyle(fontWeight: .bold,fontSize: 14,color: selectCard==1?Colors.white:AppColors.textPrimary),),),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  // inventory action of the factory sale  van sale
                  Row(
                    children: [
                      // left side of the second Row  of the inventory action
                      // factory sale container
                      InkWell(
                        borderRadius: BorderRadius.circular(10),
                        onTap: () {
                          setState(() {
                            selectCard = 2;
                          });
                        },
                        child: Container(
                          width: screenWidth / 2 - 15,
                          height: 80,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: AppColors.inputBorder),
                            color: selectCard == 2
                                ? AppColors.primaryBlue
                                : Colors.white,
                          ),
                          child: Center(child: Text('🏭 Factory Sale',style: TextStyle(fontWeight: .bold,fontSize: 14,color: selectCard==2?Colors.white:AppColors.textPrimary),),),

                        ),
                      ),
                      SizedBox(width: 10),
                      // right side of the second Row  of the inventory action
                      // van sale container
                      InkWell(
                        borderRadius: BorderRadius.circular(10),
                        onTap: () {
                          setState(() {
                            selectCard = 3;
                          });
                        },
                        child: Container(
                          width: screenWidth / 2 - 15,
                          height: 80,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: AppColors.inputBorder),
                            color: selectCard==3?AppColors.primaryBlue:Colors.white
                          ),
                          child: Center(child: Text('🛒 Van Sale',style: TextStyle(fontWeight: .bold,fontSize: 14,color: selectCard==3?Colors.white:AppColors.textPrimary),),),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      width: screenWidth - 20,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Color(0xffF1F5F9),
                        border: Border.all(color: AppColors.inputBorder),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          '+ Add Production Batch',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: .bold,
                            color: AppColors.productionGreen,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
