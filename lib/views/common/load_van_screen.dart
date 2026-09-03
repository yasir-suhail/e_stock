import 'package:e_stock/core/constants/app_color.dart';
import 'package:e_stock/views/widget/custom_Textfield.dart';
import 'package:e_stock/views/widget/custom_button.dart';
import 'package:flutter/material.dart';

class LoadVanScreen extends StatefulWidget {
  final VoidCallback onBack;
  final bool isOwnerView; // true = Owner, false = Salesman

  const LoadVanScreen({
    super.key,
    required this.isOwnerView,
    required this.onBack,
  });

  @override
  State<LoadVanScreen> createState() => _LoadVanScreenState();
}

class _LoadVanScreenState extends State<LoadVanScreen> {
  var factoryToVanController = TextEditingController();
  var selectVanController = TextEditingController();
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
              'Load Van Stock Transfer',
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
                      // width: screenWidth - 16,
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
                                  'FACTORY (SOURCE)',
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
                        SizedBox(width: 10),
                        // van stock container
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
                                  'VAN (TARGET)',
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
                      ],
                    ),
                    SizedBox(height: 24),
                    // transfer to van from factory
                    Text(
                      'TRANSFER QUANTITY (PACKS)',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: .bold,
                        color: AppColors.textLabels,
                      ),
                    ),
                    SizedBox(height: 8),
                    // text form field of the transfer to van
                    CustomTextfield(
                      controller: factoryToVanController,
                      hintText: 'Enter Quantity',
                    ),
                    SizedBox(height: 19),
                    // select driver text
                    Text(
                      'SELECT DRIVER / VAN',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: .bold,
                        color: AppColors.textLabels,
                      ),
                    ),
                    SizedBox(height: 8),
                    // select driver text form field
                    CustomTextfield(
                      controller: selectVanController,
                      hintText: 'Van #01 — Toyota HiAce (LES-4412)',
                    ),
                    SizedBox(height: 50),
                    // the execute transfer button
                    CustomButton(title: 'Execute Transfer', onTap: () {}),
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
