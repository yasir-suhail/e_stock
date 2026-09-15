import 'package:e_stock/core/constants/app_color.dart';
import 'package:e_stock/views/widget/custom_Textfield.dart';
import 'package:e_stock/views/widget/custom_button.dart';
import 'package:flutter/material.dart';

class AddProducts extends StatefulWidget {
  const AddProducts({super.key});

  @override
  State<AddProducts> createState() => _AddProductsState();
}

class _AddProductsState extends State<AddProducts> {
var productNameController= TextEditingController();
var productPackageSizeController= TextEditingController();
var productInitialStockController= TextEditingController();
var productMinimumAlertController= TextEditingController();
  @override
  Widget build(BuildContext context) {
    final screeenWidth = MediaQuery.sizeOf(context).width;
    return Scaffold(
      backgroundColor: AppColors.backgroundCanvas,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.headerNavy,
        title: Column(
          crossAxisAlignment: .start,
          children: [
            Text(
              'Add New Product',
              style: TextStyle(
                color: AppColors.whiteColor,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 4),
            Text(
              'Register a new item into inventory catalog',
              style: TextStyle(
                color: AppColors.textMuted,
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Container(
            width: screeenWidth - 10,
            height: 550,
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              border: Border.all(color: AppColors.inputBorder),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
              child: Column(
                crossAxisAlignment: .start,
                children: [
                  Text(
                    // product name
                    'PRODUCT NAME',
                    style: TextStyle(
                      color: AppColors.textLabels,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 9,),
                  // product name text field
                  CustomTextfield(
                    controller: productNameController,
                  focusedColor: AppColors.inputBorder,
                  hintText: 'Product name'),
                  SizedBox(height: 10,),
                  //package unit size
                  Text(
                    'PACKAGING / UNIT SIZE',
                    style: TextStyle(
                      color: AppColors.textLabels,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 9,),
                  //package unit size text field
                  CustomTextfield(
                    controller: productPackageSizeController,
                  focusedColor: AppColors.inputBorder,
                  hintText: '500g packs / Jar'),
                  SizedBox(height: 10,),
              // initial stock
              Text(
                'INITIAL FACTORY OPENING STOCK',
                style: TextStyle(
                  color: AppColors.textLabels,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
                  SizedBox(height: 9),
                  // initial factory stock text form field
                  CustomTextfield(
                      controller: productInitialStockController,
                      focusedColor: AppColors.inputBorder,
                      hintText: ''),
                  SizedBox(height: 10,),
                  // minimum stock alert
                  Text(
                    'MINIMUM STOCK ALERT THRESHOLD',
                    style: TextStyle(
                      color: AppColors.textLabels,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 9,),
                  // minimum stock alert text field
                  CustomTextfield(
                      controller: productMinimumAlertController,
                      hintText: 'Minimum  stock alert '),
                  SizedBox(height: 20,),
                  // save product Button
                  CustomButton(
                      backgroundColor: AppColors.productionGreen,
                      title: 'Save Product Item (+)', onTap: (){}),
                  SizedBox(height: 20,),
                  CustomButton(
                  backgroundColor: AppColors.headerNavy,
                  title: 'Cancel', onTap: (){})
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
