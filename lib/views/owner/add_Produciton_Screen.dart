import 'package:flutter/material.dart';

import '../../core/constants/app_color.dart';
import '../widget/custom_Textfield.dart';
import '../widget/custom_button.dart';

class AddProducitonScreen extends StatefulWidget {
  final VoidCallback onBack;
  const AddProducitonScreen({
    required this.onBack,
    super.key});

  @override
  State<AddProducitonScreen> createState() => _AddProducitonScreenState();
}

class _AddProducitonScreenState extends State<AddProducitonScreen> {
  String selectProduct = 'Red Chili Powder 200g';
  var saleFromFactoryController = TextEditingController();
  var reasonToSellController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
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
                    SizedBox(height: 17,),
                    // text to Add new product
                    Text('NEW PACKS PRODUCED  ',style: TextStyle(fontWeight: .bold,fontSize: 12,color: AppColors.textLabels),),
                    SizedBox(height: 8,),
                    // Text Form field of the factory sale
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Add Quantity',hintStyle:TextStyle(fontWeight: .w400,fontSize: 13,color: AppColors.textMuted),
                        filled: true,
                        fillColor: AppColors.backgroundCanvas,
                        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10),borderSide: BorderSide(color: AppColors.inputBorder)),
                        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10),borderSide: BorderSide(color: AppColors.productionGreen))
                      ),
                    ),
                    SizedBox(height: 14,),
                    // Text of the Batch number
                    Text('BATCH / LOT NUMBER',style: TextStyle(fontWeight: .bold,fontSize: 12,color: AppColors.textLabels),),
                    SizedBox(height: 8,),
                    // Text form field of the reason to sale
                    TextFormField(
                      decoration: InputDecoration(
                          hintText: 'LOT-2026-0823',hintStyle:TextStyle(fontWeight: .w400,fontSize: 13,color: AppColors.textMuted),
                          filled: true,
                          fillColor: AppColors.backgroundCanvas,
                          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10),borderSide: BorderSide(color: AppColors.inputBorder)),
                          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10),borderSide: BorderSide(color: AppColors.productionGreen))
                      ),
                    ),
                    SizedBox(height: 38,),
                    // confirm factory sale button
                    Container(
                      width: screenWidth,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.productionGreen
                      ),
                      child: Center(child: Text('Add to Factory Inventory ',style: TextStyle(color: Colors.white,fontWeight: .bold,fontSize: 13))),
                    )
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
