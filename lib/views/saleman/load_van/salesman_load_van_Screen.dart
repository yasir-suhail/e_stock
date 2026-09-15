import 'package:e_stock/core/constants/app_color.dart';
import 'package:e_stock/views/widget/custom_Textfield.dart';
import 'package:e_stock/views/widget/custom_button.dart';
import 'package:flutter/material.dart';

import '../../widget/custom_dropButton.dart';

class SalesmanLoadVanScreen extends StatefulWidget {
  const SalesmanLoadVanScreen({super.key});

  @override
  State<SalesmanLoadVanScreen> createState() => _SalesmanLoadVanScreenState();
}

class _SalesmanLoadVanScreenState extends State<SalesmanLoadVanScreen> {
  var loadVanQuantityController = TextEditingController();
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
          crossAxisAlignment: .start,
          children: [
            Text(
              'Load Stock Screen',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: AppColors.whiteColor,
              ),
            ),
            Text(
              'Factory Warehouse → Van #01',
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
              border: .all(color: AppColors.inputBorder),
              borderRadius: .circular(10),
              color: AppColors.whiteColor,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 20),
              child: Column(
                crossAxisAlignment: .start,
                children: [
                  Text(
                    'SELECT SPICE PRODUCT',
                    style: TextStyle(
                      color: AppColors.textLabels,
                      fontSize: 12,
                      fontWeight: .bold,
                    ),
                  ),
                  SizedBox(height: 8),
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
                  SizedBox(height: 20,),
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
                            'AVAILABLE IN FACTORY',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: .bold,
                              color: AppColors.textLabels,
                            ),
                          ),
                          SizedBox(height: 6),
                          Text(
                            '850 Packs',
                            style: TextStyle(
                              fontSize: 20,
                              color: AppColors.productionGreen,
                              fontWeight: .bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 17,),
                  //  load pack Text
                  Text('PACKS TO LOAD',style: TextStyle(color: AppColors.textLabels,fontSize: 12,fontWeight: FontWeight.bold),),
                  SizedBox(height: 8),
                  // load packs custom text field
                  CustomTextfield(
                    controller: loadVanQuantityController,
                    focusedColor: AppColors.vanAmber,
                  hintText: 'Quantity'),
                  SizedBox(height: 20,),
                  CustomButton(
                  backgroundColor: AppColors.vanAmber,
                  title: '+ Add Stock to Van', onTap: (){})
                  //custom add button
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
