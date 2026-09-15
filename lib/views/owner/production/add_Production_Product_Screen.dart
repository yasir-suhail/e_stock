import 'package:flutter/material.dart';

import '../../../core/constants/app_color.dart';
import '../../widget/custom_Textfield.dart';
import '../../widget/custom_button.dart';
import '../../widget/custom_dropButton.dart';

class AddProductionProductScreen extends StatefulWidget {

  const AddProductionProductScreen({ super.key});

  @override
  State<AddProductionProductScreen> createState() => _AddProductionProductScreenState();
}

class _AddProductionProductScreenState extends State<AddProductionProductScreen> {
  String selectProduct = 'Red Chili Powder 200g';
  final List<String> products = [
    'Red Chili Powder 200g',
    'Coriander Powder 250g',
    'Turmeric Powder 100g',
  ];
  var addProductFactoryController = TextEditingController();
  var batchNoController = TextEditingController();

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
              'Add Production In',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: .bold,
              ),
            ),
            SizedBox(height: 4),
            Text(
              'Record newly packaged spice stock',
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
                          'MANUALLY SELECT MANUFACTURED PRODUCT',
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
                        // custom drop down menu
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
                      // text to Add new product
                      Text(
                        'NEW PACKS PRODUCED  ',
                        style: TextStyle(
                          fontWeight: .bold,
                          fontSize: 12,
                          color: AppColors.textLabels,
                        ),
                      ),
                      SizedBox(height: 8),
                      // Text Form field of the factory sale
                     CustomTextfield(hintText: 'Add Quantity',focusedColor: AppColors.productionGreen,),
                      SizedBox(height: 14),
                      // Text of the Batch number
                      Text(
                        'BATCH / LOT NUMBER',
                        style: TextStyle(
                          fontWeight: .bold,
                          fontSize: 12,
                          color: AppColors.textLabels,
                        ),
                      ),
                      SizedBox(height: 8),
                      // Text form field of the reason to sale
                      CustomTextfield(hintText: 'LOT-2026-0823',focusedColor: AppColors.productionGreen,),
                      SizedBox(height: 38),
                      // confirm factory sale button
                      CustomButton(title: 'Add Factory Inventory', backgroundColor: AppColors.productionGreen, onTap: (){})
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
