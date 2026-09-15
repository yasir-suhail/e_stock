import 'package:e_stock/core/constants/app_color.dart';
import 'package:e_stock/views/saleman/load_van/salesman_load_van_Screen.dart';
import 'package:e_stock/views/saleman/unload_van/salesman_unload_van_screen.dart';
import 'package:e_stock/views/saleman/van_sale/salesman_van_sale_screen.dart';
import 'package:e_stock/views/widget/custom_dropButton.dart';
import 'package:e_stock/views/widget/stock_card.dart';
import 'package:flutter/material.dart';

class SalesmanDashboardScreen extends StatefulWidget {

const SalesmanDashboardScreen({
    super.key});

  @override
  State<SalesmanDashboardScreen> createState() =>
      _SalesmanDashboardScreenState();
}

class _SalesmanDashboardScreenState extends State<SalesmanDashboardScreen> {
  // the active product
  String selectProduct = 'Red Chili Powder 200g';
  // list of the products
  final List<String> products = [
    'Red Chili Powder 200g',
    'Coriander Powder 250g',
    'Turmeric Powder 100g',
  ];

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.sizeOf(context).width;
    return Scaffold(
      backgroundColor: AppColors.backgroundCanvas,
      appBar: AppBar(
        backgroundColor: AppColors.headerNavy,
        title: Column(
          crossAxisAlignment: .start,
          children: [
            Text(
              'Welcome, Ali khan',
              style: TextStyle(
                fontSize: 18,
                color: AppColors.whiteColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 6),
            Text(
              ' Route Dashboard',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: AppColors.textMuted,
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
              SizedBox(height: 15),
              // drop down container
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                width: screenWidth - 20,
                height: 65,
                decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  border: Border.all(color: AppColors.inputBorder),
                  borderRadius: BorderRadius.circular(10),
                ),
                // custom drop button
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
              // the stock card Row
              Row(
                children: [
                  StockCard(
                    title: ' Van Stock',
                    value: '365 packs',
                    valueColor: AppColors.vanAmber,
                  ),
                  SizedBox(width: 10),
                  StockCard(
                    title: "Today's Sales",
                    value: '85 Packs',
                    valueColor: AppColors.productionGreen,
                  ),
                ],
              ),
              SizedBox(height: 16),
              Text(
                'INVENTORY ACTIONS',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textLabels,
                ),
              ),
              SizedBox(height: 9),
              // inventory action
              // load van action
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>SalesmanLoadVanScreen()));
                },
                child: Stack(
                  children: [
                    Container(
                      width: screenWidth - 20,
                      height: 80,
                      decoration: BoxDecoration(
                        color: AppColors.whiteColor,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: AppColors.inputBorder),
                      ),
                    ),
                    Positioned(
                      top: 15,
                      left: 12,
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Color(0xffEFF6FF),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Icon(
                            Icons.arrow_upward,
                            color: AppColors.primaryBlue,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 17,
                      left: 74,
                      child: Column(
                        crossAxisAlignment: .start,
                          children: [
                            Text('Load Stock to Van',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                            SizedBox(height: 6,),
                            Text('Transfer inventory from warehouse',style: TextStyle(fontSize: 11,fontWeight: FontWeight.w400,color: AppColors.textMuted),)
                          ]
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 15,),
              // dispatch to shop
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: ((context) => SalesmanVanSaleScreen())));
                },
                child: Stack(
                  children: [
                    Container(
                      width: screenWidth - 20,
                      height: 80,
                      decoration: BoxDecoration(
                        color: AppColors.whiteColor,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: AppColors.inputBorder),
                      ),
                    ),
                    Positioned(
                      top: 15,
                      left: 12,
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Color(0xffFEF3C7),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Icon(
                            Icons.arrow_forward,
                            color: AppColors.vanAmber ,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 17,
                      left: 74,
                      child: Column(
                          crossAxisAlignment: .start,
                          children: [
                            Text('Dispatch to Shop',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                            SizedBox(height: 6,),
                            Text('Deliver spice inventory to retailer',style: TextStyle(fontSize: 11,fontWeight: FontWeight.w400,color: AppColors.textMuted),)
                          ]
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 15,),
              // unload van stock
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>SalesmanUnloadVanScreen()));
                },
                child: Stack(
                  children: [
                    Container(
                      width: screenWidth - 20,
                      height: 80,
                      decoration: BoxDecoration(
                        color: AppColors.whiteColor,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: AppColors.inputBorder),
                      ),
                    ),
                    Positioned(
                      top: 15,
                      left: 12,
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Color(0xffFEE2E2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Icon(
                            Icons.arrow_downward,
                            color: Color(0xffDC2626)
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 17,
                      left: 74,
                      child: Column(
                          crossAxisAlignment: .start,
                          children: [
                            Text('Unload Van Stock',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                            SizedBox(height: 6,),
                            Text('Return unsold stock at end of shift',style: TextStyle(fontSize: 11,fontWeight: FontWeight.w400,color: AppColors.textMuted),)
                          ]
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
