import 'package:e_stock/core/constants/app_color.dart';
import 'package:e_stock/views/owner/production/add_Production_Product_Screen.dart';
import 'package:e_stock/views/owner/factory_sale/factory_sale_screen.dart';
import 'package:e_stock/views/owner/load_van/load_van_screen.dart';
import 'package:e_stock/views/owner/unload_van/unload_van_screen.dart';
import 'package:e_stock/views/owner/van_sale/van_sale_screen.dart';
import 'package:e_stock/views/widget/action_card.dart';
import 'package:e_stock/views/widget/custom_button.dart';
import 'package:e_stock/views/widget/custom_dropButton.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../widget/stock_card.dart';

class OwnerDashboardScreen extends StatefulWidget {

  const OwnerDashboardScreen({
    super.key,
  });

  @override
  State<OwnerDashboardScreen> createState() => _OwnerDashboardScreenState();
}

class _OwnerDashboardScreenState extends State<OwnerDashboardScreen> {
  String selectProduct = 'Red Chili Powder 200g';
  final List<String> products = [
    'Red Chili Powder 200g',
    'Coriander Powder 250g',
    'Turmeric Powder 100g',
  ];

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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: .start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 25),
                child: Text(
                  'GLOBAL ACTIVE PRODUCT',
                  style: TextStyle(
                    color: AppColors.primaryBlue,
                    fontSize: 12,
                    fontWeight: .bold,
                  ),
                ),
              ),
              SizedBox(height: 15),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                width: screenWidth - 20,
                height: 65,
                decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  border: Border.all(color: AppColors.inputBorder),
                  borderRadius: BorderRadius.circular(10),
                ),
                //custom drop Down button
                child: CustomDropdown(
                  value: selectProduct,
                  size: 18,
                  items: products,
                  onChanged: ((value) {
                    setState(() {
                      selectProduct = value!;
                    });
                  }),
                ),
              ),
              SizedBox(height: 15),
              // factory stock  and the van stock
              Row(
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
              SizedBox(height: 16),
              Column(
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
                        selected: selectCard == 0,
                        onTap: () async {
                          setState(() {
                            selectCard = 0;
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>LoadVanScreen()));
                          });
                        },

                      ),
                      SizedBox(width: 10),
                      ActionCard(
                        title: '🔄 Unload Van',
                        selected: selectCard == 1,
                        onTap: () async {
                          setState(() {
                            selectCard = 1;
                            Navigator.push(context, MaterialPageRoute(builder: ((context) => UnloadVanScreen())));
                          });
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
                        onTap: () async {
                          setState(() {
                            selectCard = 2;
                            Navigator.push(context, MaterialPageRoute(builder: ((context) => FactorySaleScreen())));

                          });
                        },
                      ),

                      const SizedBox(width: 10),

                      ActionCard(
                        title: '🛒 Van Sale',
                        selected: selectCard == 3,
                        onTap: () async {
                          setState(() {
                            selectCard = 3;
                            Navigator.push(context, MaterialPageRoute(builder: ((context) => VansaleScreen())));

                          });
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: ((context) => AddProductionProductScreen())));
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
            ],
          ),
        ),
      ),
    );
  }
}
