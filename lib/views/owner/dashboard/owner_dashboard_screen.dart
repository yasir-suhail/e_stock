import 'package:e_stock/core/constants/app_color.dart';
import 'package:e_stock/view_Model/transaction/factory_sale_viewmodel.dart';
import 'package:e_stock/views/owner/production/add_Production_Product_Screen.dart';
import 'package:e_stock/views/owner/factory_sale/factory_sale_screen.dart';
import 'package:e_stock/views/owner/load_van/load_van_screen.dart';
import 'package:e_stock/views/owner/unload_van/unload_van_screen.dart';
import 'package:e_stock/views/owner/van_sale/van_sale_screen.dart';
import 'package:e_stock/views/widget/action_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../model/product_model.dart';
import '../../../model/stock_model.dart';
import '../../../view_Model/product_viewModel.dart';
import '../../../view_Model/stock_viewModel.dart';
import '../../../view_Model/transaction/load_van_viewmodel.dart';
import '../../../view_Model/transaction/production_viewmodel.dart';
import '../../../view_Model/transaction/van_sale_viewmodel.dart';
import '../../widget/searchable_Product_dropdown.dart';
import '../../widget/stock_card.dart';

class OwnerDashboardScreen extends StatefulWidget {
  const OwnerDashboardScreen({super.key});

  @override
  State<OwnerDashboardScreen> createState() => _OwnerDashboardScreenState();
}

class _OwnerDashboardScreenState extends State<OwnerDashboardScreen> {

  int selectCard = 0;

  @override
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final productViewModel = Provider.of<ProductViewmodel>(
        context,
        listen: false,
      );

      final stockViewModel = Provider.of<StockViewmodel>(
        context,
        listen: false,
      );

      productViewModel.getProducts();
      stockViewModel.getStock();
    });
  }
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final productViewModel = Provider.of<ProductViewmodel>(context);

    final stockViewModel = Provider.of<StockViewmodel>(context);
    StockModel? selectedStock;

    for (final stock in stockViewModel.allStock) {
      if (stock.productId == stockViewModel.selectedProduct?.id) {
        selectedStock = stock;
        break;
      }
    }
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
                // padding: EdgeInsets.symmetric(horizontal: 10),
                // width: screenWidth - 10,
                // height: 65,
                decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  border: Border.all(color: AppColors.inputBorder),
                  borderRadius: BorderRadius.circular(10),
                ),
                //custom drop Down button
                // child: DropdownButton<ProductModel>(
                //   value: selectedProduct,
                //   hint: const Text('Select Product'),
                //   isExpanded: true,
                //   style: TextStyle(fontSize: 18,color: AppColors.textPrimary,fontWeight: .w500),
                //   underline: const SizedBox(),
                //   items: productViewModel.allProducts.map((product) {
                //     return DropdownMenuItem<ProductModel>(
                //       value: product,
                //       child: Text(
                //         '${product.productName} ${product.packaging}',
                //       ),
                //     );
                //   }).toList(),
                //
                //   onChanged: (ProductModel? value) {
                //     setState(() {
                //       selectedProductId = value?.id;
                //     });
                //   },
                // ),
                child: SearchableProductDropdown(
                  hintText: 'Search or select product',
                  products: productViewModel.allProducts,
                  focusedColor: AppColors.primaryBlue,
                  onChanged: (product) {
                    stockViewModel.selectProduct(product);
                  },
                ),
              ),
              SizedBox(height: 15),
              // factory stock  and the van stock
              Row(
                children: [
                  // factory stock
                  StockCard(
                    title: 'FACTORY STOCK',
                    value: selectedStock == null
                        ? '0 Packs'
                        : '${selectedStock.factoryStock} Packs',
                    valueColor: AppColors.productionGreen,
                  ),
                  const SizedBox(width: 10),
                  //van stock
                  StockCard(
                    title: 'VAN STOCK',
                    value: selectedStock == null
                        ? '0 Packs'
                        : '${selectedStock.vanStock} Packs',
                    valueColor: AppColors.vanAmber,
                  ),                ],
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
                        title: '  Load Van',
                        selected: selectCard == 0,
                        onTap: () async {
                          setState(() {
                            selectCard = 0;
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ChangeNotifierProvider(
                                  create: (_) => LoadVanViewmodel(),
                                  child: const LoadVanScreen(),
                                ),
                              ),
                            );
                          });
                        },
                      ),
                      SizedBox(width: 10),
                      ActionCard(
                        title: ' Unload Van',
                        selected: selectCard == 1,
                        onTap: () async {
                          setState(() {
                            selectCard = 1;
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: ((context) => UnloadVanScreen()),
                              ),
                            );
                          });
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  Row(
                    children: [
                      ActionCard(
                        title: ' Factory Sale',
                        selected: selectCard == 2,
                        onTap: () async {
                          setState(() {
                            selectCard = 2;
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ChangeNotifierProvider(
                                  create: (_) => FactorySaleViewmodel(),
                                  child: const FactorySaleScreen(),
                                ),
                              ),
                            );
                          });
                        },
                      ),

                      const SizedBox(width: 10),

                      ActionCard(
                        title: ' Van Sale',
                        selected: selectCard == 3,
                        onTap: () async {
                          setState(() {
                            selectCard = 3;
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ChangeNotifierProvider(
                                  create: (_) => VanSaleViewmodel(),
                                  child: const VansaleScreen(),
                                ),
                              ),
                            );
                          });
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  GestureDetector(
                    onTap: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChangeNotifierProvider(
                            create: (_) => ProductionViewModel(),
                            child: const AddProductionProductScreen(),
                          ),
                        ),
                      );

                      if (!mounted) return;

                      await Provider.of<StockViewmodel>(
                        context,
                        listen: false,
                      ).getStock();
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
