import 'package:e_stock/core/constants/app_color.dart';
import 'package:e_stock/views/widget/custom_button.dart';
import 'package:flutter/material.dart';

import 'damage.dart';

class SalesmanUnloadVanScreen extends StatefulWidget {
  const SalesmanUnloadVanScreen({super.key});

  @override
  State<SalesmanUnloadVanScreen> createState() =>
      _SalesmanUnloadVanScreenState();
}

class _SalesmanUnloadVanScreenState extends State<SalesmanUnloadVanScreen> {
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
  // int damagedCount = 0;

  // void _openDamageReportSheet() async {
  //   final result = await showModalBottomSheet<int>(
  //     context: context,
  //     isScrollControlled: true,
  //     backgroundColor: Colors.transparent,
  //     builder: (context) {
  //       return  DamageReportBottomSheet(items: items);
  //     },
  //   );
  //
  //   if (result != null) {
  //     setState(() {
  //       damagedCount = result;
  //     });
  //   }
  // }

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
        padding:  EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Container(
          width: screenWidth - 10,
          height: 650,
          decoration: BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppColors.inputBorder),
          ),
          child: Padding(
            padding:  EdgeInsets.symmetric(horizontal: 10),
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
                      onChanged: _toggleSelectAll
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
                        padding: EdgeInsets.symmetric(horizontal: 8,vertical: 20),
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
                              activeColor:  AppColors.vanAmber,
                              checkColor:  AppColors.textPrimary
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
                                        if (item.quantity > 1)
                                          item.quantity--;
                                      });
                                    },
                                    child:  Text(
                                      '-',
                                      style: TextStyle(
                                        color: AppColors.textLabels,
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 5),
                                  Text('${item.quantity}',style: TextStyle(color: AppColors.textLabels,fontSize: 18),),
                                  SizedBox(width: 5),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        if (item.quantity < item.vanStock)
                                          item.quantity++;
                                      });
                                    },
                                    child: Text('+',style: TextStyle(
                                        color: AppColors.textLabels,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),),
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
                    title: 'Unload Selected & Close Route', onTap: (){}) ,
                // SizedBox(height: 15,),
                // InkWell(
                //   onTap: _openDamageReportSheet,
                //   child: Container(
                //     width: double.infinity,
                //     padding: const EdgeInsets.symmetric(
                //       horizontal: 12,
                //       vertical: 14,
                //     ),
                //     decoration: BoxDecoration(
                //       borderRadius: BorderRadius.circular(10),
                //       border: Border.all(
                //         color: AppColors.inputBorder,
                //       ),
                //       color: AppColors.backgroundCanvas,
                //     ),
                //     child: Row(
                //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //       children: [
                //         const Text(
                //           '0 Damaged Packs Reported',
                //           style: TextStyle(
                //             color: AppColors.textLabels,
                //             fontSize: 12,
                //           ),
                //         ),
                //         Icon(
                //           Icons.camera_alt_outlined,
                //           color: AppColors.textLabels,
                //           size: 20,
                //         ),
                //       ],
                //     ),
                //   ),
                // ),

                const SizedBox(height: 15),

                // CustomButton(
                //   backgroundColor: AppColors.vanAmber,
                //   title: 'Unload Selected & Close Route',
                //   onTap: () {},
                // ),
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

  // Damage information
  // bool isDamageSelected;
  // int damageQuantity;

  UnloadItem({
    required this.name,
    required this.vanStock,
    required this.isSelected,
    required this.quantity,
    // this.isDamageSelected = false,
    // this.damageQuantity = 0,
  });
}

