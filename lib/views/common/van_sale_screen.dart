import 'package:e_stock/views/widget/salemans_custom_button.dart';
import 'package:e_stock/views/widget/salesman_custom_textfield.dart';
import 'package:flutter/material.dart';

import '../../core/constants/app_color.dart';
import '../widget/custom_Textfield.dart';
import '../widget/custom_button.dart';

class VansaleScreen extends StatefulWidget {
   final VoidCallback onBack;
  const VansaleScreen({
    required this.onBack,
    super.key});

  @override
  State<VansaleScreen> createState() => _VansaleScreenState();
}

class _VansaleScreenState extends State<VansaleScreen> {
  String selectProduct = 'Red Chili Powder 200g';
  var saleFromVanController = TextEditingController();
  var shopCustomerNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final screenWidth  = MediaQuery.sizeOf(context).width;
    return Scaffold(
      backgroundColor: AppColors.backgroundCanvas,
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // header container
            Container(
              width: screenWidth,
              height: 100,
              decoration: BoxDecoration(color: AppColors.headerNavy),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        widget.onBack();
                      });
                    },
                    icon: Icon(
                      Icons.arrow_back_rounded,
                      color: AppColors.textLabels,
                      size: 22,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 34),
                    child: Column(
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
                ],
              ),
            ),
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
                        color: Color(0xffF1F5F9),
                        border: Border.all(color: AppColors.inputBorder),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      // drop down menu
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          isExpanded: true,
                          value: selectProduct,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: .bold,
                            color: AppColors.textPrimary,
                          ),
                          items:
                          [
                            'Red Chili Powder 200g',
                            'Coriander Powder 250g',
                            'Turmeric Powder 100g',
                          ]
                              .map(
                                (product) => DropdownMenuItem(
                              value: product,
                              child: Text(product),
                            ),
                          )
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              selectProduct = value!;
                            });
                          },
                        ),
                      ),
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
                    SizedBox(height: 17,),
                    // text of the factory sale products
                    Text('DEDUCT QUANTITY (PACKS)',style: TextStyle(fontWeight: .bold,fontSize: 12,color: AppColors.textLabels),),
                    SizedBox(height: 8,),
                    // Text Form field of the factory sale
                    SalesmanCustomTextfield(
                        controller: saleFromVanController,
                        hintText: 'Add Quantity'),
                    SizedBox(height: 14,),
                    // Text of the reasom to sale
                    Text('SHOP / CUSTOMER NAME',style: TextStyle(fontWeight: .bold,fontSize: 12,color: AppColors.textLabels),),
                    SizedBox(height: 8,),
                    // Text form field of the reason to sale
                    SalesmanCustomTextfield(
                        controller: shopCustomerNameController,
                        hintText: 'ASSD FOODS'),
                    SizedBox(height: 38,),
                    // confirm factory sale button
                    SalemansCustomButton(title: 'Confirm Van Sale ', onTap: (){})
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
