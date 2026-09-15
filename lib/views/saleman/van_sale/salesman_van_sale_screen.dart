import 'package:e_stock/core/constants/app_color.dart';
import 'package:e_stock/views/widget/custom_Textfield.dart';
import 'package:e_stock/views/widget/custom_button.dart';
import 'package:e_stock/views/widget/custom_dropButton.dart';
import 'package:flutter/material.dart';

class SalesmanVanSaleScreen extends StatefulWidget {
  const SalesmanVanSaleScreen({super.key});

  @override
  State<SalesmanVanSaleScreen> createState() => _SalesmanVanSaleScreenState();
}

class _SalesmanVanSaleScreenState extends State<SalesmanVanSaleScreen> {
  var shopNameController = TextEditingController();
  var vanSaleQuantityController = TextEditingController();
  String selectProduct = 'Red Chili Powder 200g';
  final List<String> products = [
    'Red Chili Powder 200g',
    'Coriander Powder 250g',
    'Turmeric Powder 100g',
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    return Scaffold(
      backgroundColor: AppColors.backgroundCanvas,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: AppColors.headerNavy,
        automaticallyImplyLeading: false,
        title: Column(
          children: [
            Text(
              'Record Stock Dispatch',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: AppColors.whiteColor,
              ),
            ),
            Text(
              'Transfer inventory from van to shop',
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 12,
                color: AppColors.textMuted,
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Container(
            width: screenWidth - 10,
            height: 550,
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              border: .all(color: AppColors.inputBorder),
              borderRadius: .circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: Column(
                crossAxisAlignment: .start,
                children: [
                  // select Item text
                  Text(
                    'SELECT SPICE ITEM',
                    style: TextStyle(
                      color: AppColors.textLabels,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  // drop down menu container
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    // width: screenWidth - 16,
                    height: 50,
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.inputBorder),
                      borderRadius: BorderRadius.circular(8),
                      color: AppColors.backgroundCanvas,
                    ),
                    // custom Drop down menu
                    child: CustomDropdown(
                      value: selectProduct,
                      items: products,
                      onChanged: ((value) {
                        setState(() {
                          selectProduct = value!;
                        });
                      }),
                    ),
                  ),
                  SizedBox(height: 9),
                  // Retail shop name
                  Text(
                    'RETAIL SHOP NAME',
                    style: TextStyle(
                      color: AppColors.textLabels,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  // shop name Text Field
                  CustomTextfield(
                    controller: shopNameController,
                    focusedColor: AppColors.vanAmber,
                    hintText: 'Shop Name',
                  ),
                  SizedBox(height: 9),
                  // Dispatch Quantity Text
                  Text(
                    'DISPATCH QUANTITY (PACKS)',
                    style: TextStyle(
                      color: AppColors.textLabels,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8,),
                  // Dispatch  Quantity Text field
                  CustomTextfield(
                    controller: vanSaleQuantityController,
                      focusedColor: AppColors.vanAmber,
                      hintText: 'Quantity'),
                  SizedBox(height: 30,),
                  CustomButton(
                      backgroundColor: AppColors.vanAmber,
                      title: 'Confirm Stock Transfer', onTap: (){})
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
