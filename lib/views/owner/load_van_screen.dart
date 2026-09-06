import 'package:e_stock/core/constants/app_color.dart';
import 'package:e_stock/views/widget/custom_Textfield.dart';
import 'package:e_stock/views/widget/custom_button.dart';
import 'package:e_stock/views/widget/custom_dropButton.dart';
import 'package:e_stock/views/widget/stock_card.dart';
import 'package:flutter/material.dart';

class LoadVanScreen extends StatefulWidget {
  final VoidCallback onBack;
  const LoadVanScreen({
    super.key,
    required this.onBack,
  });

  @override
  State<LoadVanScreen> createState() => _LoadVanScreenState();
}

class _LoadVanScreenState extends State<LoadVanScreen> {
  var factoryToVanController = TextEditingController();
  var selectVanController = TextEditingController();
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
                        // width: screenWidth - 16,
                        height: 50,
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.inputBorder),
                          borderRadius: BorderRadius.circular(8),
                          color: AppColors.cardBorder,
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
                      SizedBox(height: 18),
                      //Stock card
                      Row(
                        crossAxisAlignment: .center,
                        children: [
                          StockCard(
                            containerHeight: 100,
                            title: 'Factory(SOURCE)',
                            value: '1,400 Packs',
                            valueColor: AppColors.productionGreen,
                          ),
                          SizedBox(width: 10),
                          StockCard(
                            containerHeight: 100,
                            title: 'Van(TARGET)',
                            value: '50 Packs',
                            valueColor: AppColors.vanAmber,
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
      ),
    );
  }
}
