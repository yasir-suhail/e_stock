import 'package:e_stock/core/constants/app_color.dart';
import 'package:e_stock/views/widget/custom_Textfield.dart';
import 'package:e_stock/views/widget/custom_button.dart';
import 'package:e_stock/views/widget/custom_dropButton.dart';
import 'package:e_stock/views/widget/stock_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../model/product_model.dart';
import '../../../model/stock_model.dart';
import '../../../view_Model/product_viewModel.dart';
import '../../../view_Model/stock_viewModel.dart';
import '../../../view_Model/transaction/load_van_viewmodel.dart';

class LoadVanScreen extends StatefulWidget {
  const LoadVanScreen({super.key});

  @override
  State<LoadVanScreen> createState() => _LoadVanScreenState();
}

class _LoadVanScreenState extends State<LoadVanScreen> {
  var factoryToVanController = TextEditingController();
  var selectVanController = TextEditingController();
  String? selectedProductId;

  // String selectProduct = 'Red Chili Powder 200g';
  // final List<String> products = [
  //   'Red Chili Powder 200g',
  //   'Coriander Powder 250g',
  //   'Turmeric Powder 100g',
  // ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;

    final loadVanViewModel = Provider.of<LoadVanViewmodel>(context);

    final stockViewModel = Provider.of<StockViewmodel>(context);
    StockModel? selectedStock;
    for (final stock in stockViewModel.allStock) {
      if (stock.productId == selectedProductId) {
        selectedStock = stock;
        break;
      }
    }

    final productViewModel = Provider.of<ProductViewmodel>(context);
    ProductModel? selectedProduct;
    for (final product in productViewModel.allProducts) {
      if (product.id == selectedProductId) {
        selectedProduct = product;
        break;
      }
    }
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
                          color: AppColors.backgroundCanvas,
                        ),
                        // custom Drop down menu
                        // child: CustomDropdown(
                        //   value: selectProduct,
                        //   items: products,
                        //   onChanged: ((value) {
                        //     setState(() {
                        //       selectProduct = value!;
                        //     });
                        //   }),
                        // ),
                        child: DropdownButton<ProductModel>(
                          value: selectedProduct,
                          hint: const Text('Select Product'),
                          isExpanded: true,
                          underline: const SizedBox(),

                          items: productViewModel.allProducts.map((product) {
                            return DropdownMenuItem<ProductModel>(
                              value: product,
                              child: Text(
                                '${product.productName} ${product.packaging}',
                              ),
                            );
                          }).toList(),

                          onChanged: (ProductModel? value) {
                            setState(() {
                              selectedProductId = value?.id;
                            });
                          },
                        ),
                      ),
                      SizedBox(height: 18),
                      //Stock card
                      Row(
                        crossAxisAlignment: .center,
                        children: [
                          // factory stock card
                          StockCard(
                            containerHeight: 100,
                            title: 'Factory(SOURCE)',
                            value: selectedStock == null
                                ? '0 Packs'
                                : '${selectedStock.factoryStock} Packs',
                            valueColor: AppColors.productionGreen,
                          ),
                          SizedBox(width: 10),
                          // van stock card
                          StockCard(
                            containerHeight: 100,
                            title: 'Van(TARGET)',
                            value: selectedStock == null
                                ? '0 Packs'
                                : '${selectedStock.vanStock} Packs',
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
                      CustomButton(
                        title: loadVanViewModel.isLoading
                            ? 'Transferring...'
                            : 'Execute Transfer',

                        onTap: () async {
                          if (selectedProductId == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Please select a product'),
                              ),
                            );
                            return;
                          }

                          final quantity = int.tryParse(
                            factoryToVanController.text,
                          );

                          if (quantity == null || quantity <= 0) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Please enter a valid quantity'),
                              ),
                            );
                            return;
                          }

                          final success = await loadVanViewModel.loadVan(
                            productId: selectedProductId!,
                            quantity: quantity,
                          );

                          if (!mounted) return;

                          if (success) {
                            await stockViewModel.getStock();

                            if (!mounted) return;

                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Stock successfully transferred to van',
                                ),
                              ),
                            );

                            factoryToVanController.clear();
                          }else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  loadVanViewModel.errorMessage ??
                                      'Transfer failed',
                                ),
                              ),
                            );
                          }
                        },
                      ),
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
