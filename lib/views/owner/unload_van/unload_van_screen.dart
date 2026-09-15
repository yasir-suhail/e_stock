// import 'package:e_stock/views/widget/action_card.dart';
// import 'package:e_stock/views/widget/custom_dropButton.dart';
// import 'package:e_stock/views/widget/stock_card.dart';
// import 'package:flutter/material.dart';
//
// import '../../../core/constants/app_color.dart';
// import '../../widget/custom_Textfield.dart';
// import '../../widget/custom_button.dart';
//
// class UnloadVanScreen extends StatefulWidget {
//
//   const UnloadVanScreen({super.key});
//
//   @override
//   State<UnloadVanScreen> createState() => _UnloadVanScreenState();
// }
//
// class _UnloadVanScreenState extends State<UnloadVanScreen> {
//   var vanToFactoryQuantityController = TextEditingController();
//   var unloadReasonController = TextEditingController();
//   String selectProduct = 'Red Chili Powder 200g';
//   final List<String> products = [
//     'Red Chili Powder 200g',
//     'Coriander Powder 250g',
//     'Turmeric Powder 100g',
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery
//         .sizeOf(context)
//         .width;
//     return Scaffold(
//       backgroundColor: AppColors.backgroundCanvas,
//       resizeToAvoidBottomInset: true,
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         backgroundColor: AppColors.headerNavy,
//         title: Column(
//           crossAxisAlignment: .start,
//           children: [
//             Text(
//               'Unload Van (Return Stock)',
//               style: TextStyle(
//                 color: Colors.white,
//                 fontSize: 18,
//                 fontWeight: .bold,
//               ),
//             ),
//             SizedBox(height: 4),
//             Text(
//               'Return inventory from Van to Factory',
//               style: TextStyle(
//                 color: AppColors.textMuted,
//                 fontSize: 12,
//                 fontWeight: .w400,
//               ),
//             ),
//           ],
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 10),
//           child: Column(
//             children: [
//               SizedBox(height: 25),
//               // the main container
//               Container(
//                 width: screenWidth - 20,
//                 height: 550,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(10),
//                   border: Border.all(color: AppColors.inputBorder),
//                   color: Colors.white,
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 10),
//                   child: Column(
//                     crossAxisAlignment: .start,
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.only(top: 19),
//                         child: Text(
//                           'SELECT PRODUCT TO UNLOAD',
//                           style: TextStyle(
//                             color: AppColors.textLabels,
//                             fontSize: 12,
//                             fontWeight: .bold,
//                           ),
//                         ),
//                       ),
//                       SizedBox(height: 8),
//                       // dropdown menu container
//                       Container(
//                           padding: const EdgeInsets.symmetric(horizontal: 12),
//                           height: 50,
//                           decoration: BoxDecoration(
//                             border: Border.all(color: AppColors.inputBorder),
//                             borderRadius: BorderRadius.circular(8),
//                             color: AppColors.backgroundCanvas,
//                           ),
//                           // custom Drop down menu
//                           child: CustomDropdown(value: selectProduct,
//                             items:products,
//                             onChanged: (value) {
//                               setState(() {
//                                 selectProduct = value!;
//                               });
//                             },)
//                       ),
//                       SizedBox(height: 18),
//                       //stock card
//                       Row(
//                         crossAxisAlignment: .center,
//                         children: [
//                           // Van stock container
//                           StockCard(title: 'VAN BALANCE', value: '50 Packs', valueColor: AppColors.vanAmber,containerHeight: 100,),
//                           SizedBox(width: 10),
//                           // Factory stock container
//                           StockCard(title: 'FACTORY TARGET', value: '1,400 Packs', valueColor: AppColors.productionGreen,containerHeight: 100,),
//
//                         ],
//                       ),
//                       SizedBox(height: 24),
//                       // Return to  factory Text
//                       Text(
//                         'RETURN QUANTITY (PACKS)',
//                         style: TextStyle(
//                           fontSize: 12,
//                           fontWeight: .bold,
//                           color: AppColors.textLabels,
//                         ),
//                       ),
//                       SizedBox(height: 8),
//                       // text form field of Return to factory
//                       CustomTextfield(
//                         controller: vanToFactoryQuantityController,
//                         hintText: 'Enter Quantity',
//                       ),
//                       SizedBox(height: 19),
//                       // unload Reason Text
//                       Text(
//                         'UNLOAD REASON',
//                         style: TextStyle(
//                           fontSize: 12,
//                           fontWeight: .bold,
//                           color: AppColors.textLabels,
//                         ),
//                       ),
//                       SizedBox(height: 8),
//                       // select driver text form field
//                       CustomTextfield(
//                         controller: unloadReasonController,
//                         hintText: 'End of day market return)',
//                       ),
//                       SizedBox(height: 50),
//                       // Confirm Unload to Factory
//                       CustomButton(title: 'Confirm Unload toFactory',
//                           backgroundColor: AppColors.headerNavy,
//                           onTap: () {})
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import '../../../core/constants/app_color.dart';
import '../../widget/custom_button.dart';

class UnloadVanScreen extends StatefulWidget {
  const UnloadVanScreen({super.key});

  @override
  State<UnloadVanScreen> createState() => _UnloadVanScreenState();
}

class _UnloadVanScreenState extends State<UnloadVanScreen> {
  final List<UnloadItem> items = [
    UnloadItem(
      name: 'Red Chili Powder (200g)',
      vanStock: 105,
      isSelected: false,
      quantity: 0,
    ),
    UnloadItem(
      name: 'Turmeric Powder (100g)',
      vanStock: 65,
      isSelected: false,
      quantity: 0,
    ),
    UnloadItem(
      name: 'Garam Masala Mix (50g)',
      vanStock: 195,
      isSelected: false,
      quantity: 0,
    ),
  ];
  bool isChecked = false;

  // the function for all checked
  void _toggleSelectAll(bool? value) {
    setState(() {
      isChecked = value ?? false;

      for (var item in items) {
        item.isSelected = isChecked;
        item.quantity = isChecked ? item.vanStock : 0;
      }
    });
  }

  // the function for the individually check the products
  void _toggleItem(UnloadItem item, bool? value) {
    setState(() {
      item.isSelected = value ?? false;
      item.quantity = item.isSelected ? item.vanStock : 0;
      if (item.isSelected) {
        item.quantity = 1;
      } else {
        item.quantity = 0;
      }
      // Check if all items are selected
      isChecked = items.every((item) => item.isSelected);
    });
  }

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
              'End of Shift Unload',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: AppColors.whiteColor,
              ),
            ),
            SizedBox(height: 6),
            Text(
              'Reconcile and return stock to warehouse',
              style: TextStyle(
                color: AppColors.textMuted,
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Container(
          width: screenWidth - 10,
          height: 650,
          decoration: BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppColors.inputBorder),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: .start,
              children: [
                SizedBox(height: 20),
                Container(
                  width: screenWidth - 40,
                  height: 70,
                  decoration: BoxDecoration(
                    border: Border.all(color: Color(0xffFDE68A)),
                    borderRadius: BorderRadius.circular(10),
                    color: Color(0xffFEF3C7),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 14, left: 12),
                    child: Column(
                      crossAxisAlignment: .start,
                      children: [
                        Text(
                          'TOTAL REMAINING STOCK TO UNLOAD',
                          style: TextStyle(
                            color: AppColors.vanAmber,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          '365 Packs',
                          style: TextStyle(
                            color: AppColors.textPrimary,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 19),
                Row(
                  mainAxisAlignment: .spaceBetween,
                  children: [
                    Text(
                      'Select Items to Return',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: AppColors.textLabels,
                      ),
                    ),
                    Checkbox(
                      checkColor: AppColors.textPrimary,
                      activeColor: AppColors.vanAmber,
                      value: isChecked,
                      onChanged: _toggleSelectAll,
                    ),
                  ],
                ),
                SizedBox(height: 13),
                SizedBox(
                  height: 300,
                  child: ListView.builder(
                    // shrinkWrap: true,
                    // physics: NeverScrollableScrollPhysics(),
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      final item = items[index];
                      return Container(
                        margin: EdgeInsets.only(bottom: 12),
                        padding: EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 20,
                        ),
                        width: screenWidth - 40,
                        height: 80,
                        decoration: BoxDecoration(
                          borderRadius: .circular(10),
                          border: Border.all(color: AppColors.inputBorder),
                          color: AppColors.backgroundCanvas,
                        ),
                        child: Row(
                          children: [
                            Checkbox(
                              value: item.isSelected,
                              onChanged: (value) {
                                _toggleItem(item, value);
                              },
                              activeColor: AppColors.vanAmber,
                              checkColor: AppColors.textPrimary,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.name,
                                    style: TextStyle(
                                      color: AppColors.vanAmber,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 2),
                                  Text(
                                    'Van Stock: ${item.vanStock} Packs',
                                    style: TextStyle(
                                      color: AppColors.textLabels,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 5,
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: AppColors.inputBorder,
                                ),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Row(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        if (item.quantity > 1) item.quantity--;
                                      });
                                    },
                                    child: Text(
                                      '-',
                                      style: TextStyle(
                                        color: AppColors.textLabels,
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    '${item.quantity}',
                                    style: TextStyle(
                                      color: AppColors.textLabels,
                                      fontSize: 18,
                                    ),
                                  ),
                                  SizedBox(width: 5),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        if (item.quantity < item.vanStock)
                                          item.quantity++;
                                      });
                                    },
                                    child: Text(
                                      '+',
                                      style: TextStyle(
                                        color: AppColors.textLabels,
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                // SizedBox(height: 20,),
                CustomButton(
                  backgroundColor: AppColors.vanAmber,
                  title: 'Unload Selected & Close Route',
                  onTap: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class UnloadItem {
  String name;
  int vanStock;
  bool isSelected;
  int quantity;

  UnloadItem({
    required this.name,
    required this.vanStock,
    required this.isSelected,
    required this.quantity,

  });
}
