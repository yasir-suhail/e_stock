import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/app_color.dart';
import '../../../model/product_model.dart';
import '../../../view_Model/product_viewModel.dart';
import '../../../view_Model/stock_viewModel.dart';
import '../../../view_Model/transaction/production_viewmodel.dart';
import '../../widget/custom_Textfield.dart';
import '../../widget/custom_button.dart';
import '../../widget/custom_dropButton.dart';

class AddProductionProductScreen extends StatefulWidget {

  const AddProductionProductScreen({ super.key});

  @override
  State<AddProductionProductScreen> createState() => _AddProductionProductScreenState();
}

class _AddProductionProductScreenState extends State<AddProductionProductScreen> {
  // String selectProduct = 'Red Chili Powder 200g';
  // final List<String> products = [
  //   'Red Chili Powder 200g',
  //   'Coriander Powder 250g',
  //   'Turmeric Powder 100g',
  // ];
  String? selectedProductId;
  var addProductFactoryController = TextEditingController();
  var batchNoController = TextEditingController();


  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final productViewModel =
      Provider.of<ProductViewmodel>(context, listen: false);

      productViewModel.getProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final productionViewModel =
    Provider.of<ProductionViewModel>(context);
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
                          color: AppColors.cardBorder,
                          border: Border.all(color: AppColors.inputBorder),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        // custom drop down menu
                        //   child: CustomDropdown(
                        //     value: selectProduct,
                        //     items: products,
                        //     onChanged: (value) {
                        //       setState(() {
                        //         selectProduct = value!;
                        //       });
                        //     },
                        //   )
                        child: DropdownButton<ProductModel>(
                          value: selectedProduct,
                          hint: const Text('Select Product'),
                          style: TextStyle(fontSize: 18,color: AppColors.textPrimary,fontWeight: .w400),

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
                     CustomTextfield(
                       keyboardtype: .number,
                       controller: addProductFactoryController,
                       hintText: 'Add Quantity',focusedColor: AppColors.productionGreen,),
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
                      CustomTextfield(
                        controller: batchNoController,
                        hintText: 'LOT-2026-0823',focusedColor: AppColors.productionGreen,),
                      SizedBox(height: 38),
                      // confirm factory sale button
                      // CustomButton(
                      //     title: 'Add Factory Inventory', backgroundColor: AppColors.productionGreen, onTap: (){
                      //
                      //
                      // })
                      CustomButton(
                        title: 'Add Factory Inventory',
                        loading: productionViewModel.isLoading,
                        backgroundColor: AppColors.productionGreen,
                        // onTap: () async {
                        //
                        //   if (selectedProductId == null) {
                        //     return;
                        //   }
                        //
                        //   final quantity =
                        //   int.tryParse(addProductFactoryController.text);
                        //
                        //   if (quantity == null || quantity <= 0) {
                        //     return;
                        //   }
                        //
                        //   final stockViewModel =
                        //   Provider.of<StockViewmodel>(
                        //     context,
                        //     listen: false,
                        //   );
                        //
                        //   await stockViewModel.addProduction(
                        //     productId: selectedProductId!,
                        //     quantity: quantity,
                        //   );
                        // },
                        onTap: () async {
                          if (selectedProductId == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Please select a product'),
                              ),
                            );
                            return;
                          }

                          final quantity =
                          int.tryParse(addProductFactoryController.text);

                          if (quantity == null || quantity <= 0) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Please enter a valid quantity'),
                              ),
                            );
                            return;
                          }

                          final productionViewModel =
                          Provider.of<ProductionViewModel>(
                            context,
                            listen: false,
                          );

                          final success = await productionViewModel.addProduction(
                            productId: selectedProductId!,
                            quantity: quantity,
                          );

                          if (!mounted) return;

                          if (success) {
                            addProductFactoryController.clear();
                            batchNoController.clear();

                            setState(() {
                              selectedProductId = null;
                            });

                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Production added successfully'),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  productionViewModel.errorMessage ??
                                      'Something went wrong',
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
