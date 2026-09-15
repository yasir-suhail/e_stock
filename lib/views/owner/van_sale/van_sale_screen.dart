import 'package:e_stock/views/widget/custom_Textfield.dart';
import 'package:e_stock/views/widget/custom_button.dart';
import 'package:e_stock/views/widget/custom_dropButton.dart';
import 'package:flutter/material.dart';

import '../../../core/constants/app_color.dart';

class VansaleScreen extends StatefulWidget {

  const VansaleScreen({super.key});

  @override
  State<VansaleScreen> createState() => _VansaleScreenState();
}

class _VansaleScreenState extends State<VansaleScreen> {
  String selectProduct = 'Red Chili Powder 200g';
  final List<String> products = [
    'Red Chili Powder 200g',
    'Coriander Powder 250g',
    'Turmeric Powder 100g',
  ];
  var saleFromVanQuantityController = TextEditingController();
  var shopCustomerNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    return Scaffold(
      backgroundColor: AppColors.backgroundCanvas,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: AppColors.headerNavy,
        automaticallyImplyLeading: false,
        title: Column(
          crossAxisAlignment: .start,
          children: [
            Text(
              'Record Van Route Sale',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: .bold,
              ),
            ),
            SizedBox(height: 4),
            Text(
              'Deduct quantity directly from mobile van',
              style: TextStyle(
                color: AppColors.textMuted,
                fontSize: 12,
                fontWeight: .w400,
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              SizedBox(height: 25),
              // main container
              Container(
                width: screenWidth - 20,
                height: 550,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppColors.inputBorder),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: .start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 19),
                        child: Text(
                          'MANUALLY SELECT PRODUCT',
                          style: TextStyle(
                            color: AppColors.textLabels,
                            fontSize: 12,
                            fontWeight: .bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 8),
                      // Drop down menu container
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        height: 50,
                        decoration: BoxDecoration(
                          color: AppColors.backgroundCanvas,
                          border: Border.all(color: AppColors.inputBorder),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        //  custom drop down menu
                        child: CustomDropdown(
                          value: selectProduct,
                          items: products,
                          onChanged: (value) {
                            setState(() {
                              selectProduct = value!;
                            });
                          },
                        )
                      ),
                      SizedBox(height: 17),
                      // available stock in factory container
                      Container(
                        width: screenWidth - 20,
                        height: 100,
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.inputBorder),
                          borderRadius: BorderRadius.circular(10),
                          color: AppColors.backgroundCanvas,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 14, left: 16),
                          child: Column(
                            crossAxisAlignment: .start,
                            children: [
                              Text(
                                'AVAILABLE ON VAN',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: .bold,
                                  color: AppColors.textLabels,
                                ),
                              ),
                              SizedBox(height: 6),
                              Text(
                                '50 Packs',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: AppColors.vanAmber,
                                  fontWeight: .bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 17),
                      // text of the factory sale products
                      Text(
                        'DEDUCT QUANTITY (PACKS)',
                        style: TextStyle(
                          fontWeight: .bold,
                          fontSize: 12,
                          color: AppColors.textLabels,
                        ),
                      ),
                      SizedBox(height: 8),
                      // Text Form field of the factory sale
                      CustomTextfield(
                        focusedColor: AppColors.vanAmber,
                        controller: saleFromVanQuantityController,
                        hintText: 'Add Quantity',
                      ),
                      SizedBox(height: 14),
                      // Text of the reasom to sale
                      Text(
                        'SHOP / CUSTOMER NAME',
                        style: TextStyle(
                          fontWeight: .bold,
                          fontSize: 12,
                          color: AppColors.textLabels,
                        ),
                      ),
                      SizedBox(height: 8),
                      // Text form field of the reason to sale
                      CustomTextfield(
                        focusedColor: AppColors.vanAmber,
                        controller: shopCustomerNameController,
                        hintText: 'ASSD FOODS',
                      ),
                      SizedBox(height: 38),
                      // confirm factory sale button
                      CustomButton(title: 'Confirm Van Sale', backgroundColor: AppColors.vanAmber,onTap: (){})
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
