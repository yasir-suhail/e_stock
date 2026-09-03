import 'package:e_stock/core/constants/app_color.dart';
import 'package:e_stock/views/widget/action_card.dart';
import 'package:e_stock/views/widget/custom_dropButton.dart';
import 'package:flutter/material.dart';

import '../widget/stock_card.dart';

class OwnerDashboardScreen extends StatefulWidget {
  // These callbacks are functions received from the parent NavigationScreen.
  // When a card is tapped, these functions tell the parent
  // which screen should be displayed.
  final VoidCallback onLoadVan;
  final VoidCallback onUnloadVan;
  final VoidCallback onFactorySale;
  final VoidCallback onVanSale;
  final VoidCallback onAddProduction;

  const OwnerDashboardScreen({
    required this.onLoadVan,
    required this.onUnloadVan,
    required this.onFactorySale,
    required this.onVanSale,
    required this.onAddProduction,
    super.key,
  });

  @override
  State<OwnerDashboardScreen> createState() => _OwnerDashboardScreenState();
}

class _OwnerDashboardScreenState extends State<OwnerDashboardScreen> {
  String selectProduct = 'Red Chili Powder 200g';

  // Selects which inventory card is active.
  // 0 = Load Van
  // 1 = Unload Van
  // 2 = Factory Sale
  // 3 = Van Sale
  int selectCard = 0;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    return Scaffold(
      backgroundColor: AppColors.backgroundCanvas,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.headerNavy,
        title: Column(
          crossAxisAlignment: .start,
          children: [
            Text(
              'Dashboard',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: .bold,
              ),
            ),
            SizedBox(height: 6),
            Text(
              'Global Stock Overview & Operations',
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
          crossAxisAlignment: .start,
          children: [
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                width: screenWidth - 20,
                height: 80,
                decoration: BoxDecoration(
                  color: Color(0xffF1F5F9),
                  border: Border.all(color: AppColors.inputBorder),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: CustomDropdown(
                  title: 'GLOBAL ACTIVE PRODUCT',
                  value: selectProduct,
                  items: [ 'Red Chili Powder 200g',
                    'Coriander Powder 250g',
                    'Turmeric Powder 100g',
                  ],
                  onChanged: ((value) {
                    setState(() {
                      selectProduct=value!;
                    });
                  }),
                ),
                // drop down menu
                // child: Column(
                //   crossAxisAlignment: .start,
                //   children: [
                //     Padding(
                //       padding: const EdgeInsets.only(top: 8),
                //       child: Text(
                //         'GLOBAL ACTIVE PRODUCT',
                //         style: TextStyle(
                //           fontSize: 11,
                //           fontWeight: .bold,
                //           color: AppColors.primaryBlue,
                //         ),
                //       ),
                //     ),
                //     DropdownButtonHideUnderline(
                //       child: DropdownButton<String>(
                //         isExpanded: true,
                //         value: selectProduct,
                //         style: TextStyle(
                //           fontSize: 18,
                //           fontWeight: .bold,
                //           color: AppColors.textPrimary,
                //         ),
                //         items:
                //             [
                //                   'Red Chili Powder 200g',
                //                   'Coriander Powder 250g',
                //                   'Turmeric Powder 100g',
                //                 ]
                //                 .map(
                //                   (product) => DropdownMenuItem(
                //                     value: product,
                //                     child: Text(product),
                //                   ),
                //                 )
                //                 .toList(),
                //         onChanged: (value) {
                //           setState(() {
                //             selectProduct = value!;
                //           });
                //         },
                //       ),
                //     ),
                //   ],
                // ),
              ),
            ),

            SizedBox(height: 15),
            // factory stock  and the van stock
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  StockCard(
                    title: 'FACTORY STOCK',
                    value: '1,400 Packs',
                    valueColor: AppColors.productionGreen,
                  ),
                  const SizedBox(width: 10),
                  StockCard(
                    title: 'VAN STOCK',
                    value: '50 Packs',
                    valueColor: AppColors.vanAmber,
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: .start,
                children: [
                  Text(
                    'INVENTORY ACTIONS',
                    style: TextStyle(
                      color: AppColors.textLabels,
                      fontWeight: .bold,
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(height: 9),
                  //  1 Row  inventory actions of the load van and the unload van
                  Row(
                    children: [
                      ActionCard(
                        title: ' 🚚 Load Van',
                        onTap: () {
                          setState(() {
                            selectCard = 0;
                          });
                          // IMPORTANT:
                          // widget.onLoadVan is the function.
                          // () actually CALLS the function.
                          //
                          // The function was passed from NavigationScreen:
                          //
                          // onLoadVan: openLoadVan
                          //
                          // So this calls openLoadVan().
                          widget.onLoadVan();
                        },
                        selected: selectCard == 0,
                      ),
                      SizedBox(width: 10),
                      ActionCard(
                        title: '🔄 Unload Van',
                        selected: selectCard == 1,
                        onTap: () {
                          setState(() {
                            selectCard = 1;
                          });
                          // Calls the function received from
                          // NavigationScreen.
                          //
                          // NavigationScreen passes:
                          // onUnloadVan: openUnloadVan
                          //
                          // Therefore this calls:
                          // openUnloadVan();
                          widget.onUnloadVan();
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  Row(
                    children: [
                      ActionCard(
                        title: '🏭 Factory Sale',
                        selected: selectCard == 2,
                        onTap: () {
                          setState(() {
                            selectCard = 2;
                          });
                          // Calls the function received from
                          // NavigationScreen.
                          //
                          // NavigationScreen passes:
                          // onFactorySale: openFactorySale
                          //
                          // Therefore this calls:
                          // openFactorySale();
                          widget.onFactorySale();
                        },
                      ),

                      const SizedBox(width: 10),

                      ActionCard(
                        title: '🛒 Van Sale',
                        selected: selectCard == 3,
                        onTap: () {
                          setState(() {
                            selectCard = 3;
                          });
                          // Calls the function received from
                          // NavigationScreen.
                          //
                          // NavigationScreen passes:
                          // onVanSale: openVanSale
                          //
                          // () is IMPORTANT because it EXECUTES
                          // the function.
                          widget.onVanSale();
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  GestureDetector(
                    onTap: () {
                      widget.onAddProduction();
                    },
                    child: Container(
                      width: screenWidth - 20,
                      height: 50,
                      decoration: BoxDecoration(
                        color: AppColors.cardBorder,
                        border: Border.all(color: AppColors.inputBorder),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          '+ Add Production Batch',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: .bold,
                            color: AppColors.productionGreen,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
