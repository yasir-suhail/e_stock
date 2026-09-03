import 'package:flutter/material.dart';

import '../../core/constants/app_color.dart';
import '../widget/custom_Textfield.dart';
import '../widget/custom_button.dart';

class UnloadVanScreen extends StatefulWidget {
  final VoidCallback onBack;

  const UnloadVanScreen({required this.onBack, super.key});

  @override
  State<UnloadVanScreen> createState() => _UnloadVanScreenState();
}

class _UnloadVanScreenState extends State<UnloadVanScreen> {
  var vanToFactoryController = TextEditingController();
  var unloadReasonController = TextEditingController();
  String selectProduct = 'Red Chili Powder 200g';

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    return Scaffold(
      backgroundColor: AppColors.backgroundCanvas,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            setState(() {
              widget.onBack();
            });
          },
          icon: Icon(Icons.arrow_back_rounded, color: Colors.white),
        ),
        backgroundColor: AppColors.headerNavy,
        centerTitle: true,
        title: Column(
          crossAxisAlignment: .start,
          children: [
            Text(
              'Unload Van (Return Stock)',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: .bold,
              ),
            ),
            SizedBox(height: 4),
            Text(
              'Move inventory from Factory to Van',
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
              // the main container
              Container(
                width: screenWidth - 20,
                height: 550,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppColors.inputBorder),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: .start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 19),
                        child: Text(
                          'SELECT PRODUCT TO LOAD',
                          style: TextStyle(
                            color: AppColors.textLabels,
                            fontSize: 12,
                            fontWeight: .bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 8),
                      // dropdown menu container
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        height: 50,
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.inputBorder),
                          borderRadius: BorderRadius.circular(8),
                          color: AppColors.cardBorder,
                        ),
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
                      SizedBox(height: 18),
                      //Card Row
                      Row(
                        crossAxisAlignment: .center,
                        children: [
                          // Van stock container
                          Container(
                            width: screenWidth / 2 - 26,
                            height: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: AppColors.inputBorder),
                              color: AppColors.backgroundCanvas,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(top: 12, left: 10),
                              child: Column(
                                crossAxisAlignment: .start,
                                children: [
                                  Text(
                                    'VAN BALANCE',
                                    style: TextStyle(
                                      fontWeight: .bold,
                                      fontSize: 12,
                                      color: AppColors.textLabels,
                                    ),
                                  ),
                                  SizedBox(height: 7),
                                  Text(
                                    '50 Packs',
                                    style: TextStyle(
                                      color: AppColors.vanAmber,
                                      fontSize: 16,
                                      fontWeight: .bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          // Factory stock container
                          Container(
                            width: screenWidth / 2 - 26,
                            height: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: AppColors.inputBorder),
                              color: AppColors.backgroundCanvas,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(top: 12, left: 10),
                              child: Column(
                                crossAxisAlignment: .start,
                                children: [
                                  Text(
                                    'FACTORY TARGET',
                                    style: TextStyle(
                                      fontWeight: .bold,
                                      fontSize: 12,
                                      color: AppColors.textLabels,
                                    ),
                                  ),
                                  SizedBox(height: 7),
                                  Text(
                                    '1,400 Packs',
                                    style: TextStyle(
                                      color: AppColors.productionGreen,
                                      fontSize: 16,
                                      fontWeight: .bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 24),
                      // Return to  factory Text
                      Text(
                        'RETURN QUANTITY (PACKS)',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: .bold,
                          color: AppColors.textLabels,
                        ),
                      ),
                      SizedBox(height: 8),
                      // text form field of Return to factory
                      CustomTextfield(
                        controller: vanToFactoryController,
                        hintText: 'Enter Quantity',
                      ),
                      SizedBox(height: 19),
                      // unload Reason Text
                      Text(
                        'UNLOAD REASON',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: .bold,
                          color: AppColors.textLabels,
                        ),
                      ),
                      SizedBox(height: 8),
                      // select driver text form field
                      CustomTextfield(
                        controller: unloadReasonController,
                        hintText: 'End of day market return)',
                      ),
                      SizedBox(height: 50),
                      // Confirm Unload to Factory
                      CustomButton(title: 'Confirm Unload toFactory',
                          backgroundColor: AppColors.headerNavy,
                          onTap: (){})
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
