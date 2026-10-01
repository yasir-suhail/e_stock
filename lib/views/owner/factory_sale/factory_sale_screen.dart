// import 'package:e_stock/core/constants/app_color.dart';
// import 'package:e_stock/model/stock_model.dart';
// import 'package:e_stock/view_Model/stock_viewModel.dart';
// import 'package:e_stock/view_Model/transaction/factory_sale_viewmodel.dart';
// import 'package:e_stock/views/widget/custom_Textfield.dart';
// import 'package:e_stock/views/widget/custom_button.dart';
// import 'package:e_stock/views/widget/searchable_Product_dropdown.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'package:provider/provider.dart';
//
// import '../../../view_Model/product_viewModel.dart';
// import '../../../view_Model/stock_viewModel.dart';
// import '../../widget/custom_dropButton.dart';
//
// class FactorySaleScreen extends StatefulWidget {
//
//   const FactorySaleScreen({super.key});
//
//   @override
//   State<FactorySaleScreen> createState() => _FactorySaleScreenState();
// }
//
// class _FactorySaleScreenState extends State<FactorySaleScreen> {
//
//   var saleFactoryQuantityController = TextEditingController();
//   var reasonToSellController = TextEditingController();
//   var customerNameController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.sizeOf(context).width;
//     final factorySaleViewmodel = Provider.of<FactorySaleViewmodel>(context);
//     final stockViewModel = Provider.of<StockViewmodel>(context);
//     StockModel? selectedStock;
//
//     for (final stock in stockViewModel.allStock) {
//       if (stock.productId == factorySaleViewmodel.selectedProduct?.id) {
//         selectedStock = stock;
//         break;
//       }
//     }
//     final productViewModel = Provider.of<ProductViewmodel>(context);
//
//     return Scaffold(
//       backgroundColor: AppColors.backgroundCanvas,
//       resizeToAvoidBottomInset: true,
//       appBar: AppBar(
//         backgroundColor: AppColors.headerNavy,
//         automaticallyImplyLeading: false,
//         title: Column(
//           crossAxisAlignment: .start,
//           children: [
//             Text(
//               'Factory Sale / Direct Deduction',
//               style: TextStyle(
//                 color: Colors.white,
//                 fontSize: 18,
//                 fontWeight: .bold,
//               ),
//             ),
//             SizedBox(height: 4),
//             Text(
//               'Reduce main warehouse quantity',
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
//               // header container
//               SizedBox(height: 25),
//               // main container
//               Container(
//                 width: screenWidth - 20,
//                 // height: 550,
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(10),
//                   border: Border.all(color: AppColors.inputBorder),
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 10),
//                   child: Column(
//                     crossAxisAlignment: .start,
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.only(top: 19),
//                         child: Text(
//                           'MANUALLY SELECT PRODUCT',
//                           style: TextStyle(
//                             color: AppColors.textLabels,
//                             fontSize: 12,
//                             fontWeight: .bold,
//                           ),
//                         ),
//                       ),
//                       SizedBox(height: 8),
//                       // Drop down menu container
//
//                         // custom drop down menu
//                       //   child: CustomDropdown(
//                       //   value: selectProduct,
//                       //   items:products,
//                       //   onChanged: (value) {
//                       //     setState(() {
//                       //       selectProduct = value!;
//                       //     });
//                       //   },
//                       // )
//                          SearchableProductDropdown(
//                           products: productViewModel.allProducts,
//                           onChanged: (product) {
//                             factorySaleViewmodel.selectProduct(product);
//                           },
//                         ),
//                       SizedBox(height: 17),
//                       // available stock in factory container
//                       Container(
//                         width: screenWidth - 20,
//                         height: 100,
//                         decoration: BoxDecoration(
//                           border: Border.all(color: AppColors.inputBorder),
//                           borderRadius: BorderRadius.circular(10),
//                           color: AppColors.backgroundCanvas,
//                         ),
//                         child: Padding(
//                           padding: const EdgeInsets.only(top: 14, left: 16),
//                           child: Column(
//                             crossAxisAlignment: .start,
//                             children: [
//                               Text(
//                                 'AVAILABLE IN FACTORY',
//                                 style: TextStyle(
//                                   fontSize: 12,
//                                   fontWeight: .bold,
//                                   color: AppColors.textLabels,
//                                 ),
//                               ),
//                               SizedBox(height: 6),
//                               Text(
//                                 selectedStock == null
//                                     ? '0 Packs'
//                                     : '${selectedStock.factoryStock} Packs',
//                                 style: TextStyle(
//                                   fontSize: 20,
//                                   color: AppColors.productionGreen,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                       SizedBox(height: 17),
//                       // text of the factory sale products
//                       Text(
//                         'DEDUCT QUANTITY (PACKS)',
//                         style: TextStyle(
//                           fontWeight: .bold,
//                           fontSize: 12,
//                           color: AppColors.textLabels,
//                         ),
//                       ),
//                       SizedBox(height: 8),
//                       // Text Form field of the factory sale
//                       CustomTextfield(
//                         controller: saleFactoryQuantityController,
//                         hintText: 'Add Quantity',
//                       ),
//                       SizedBox( height:  14,),
//                       Text(
//                         'CUSTOMER NAME',
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           fontSize: 12,
//                           color: AppColors.textLabels,
//                         ),
//                       ),
//
//                       SizedBox(height: 8),
//
//                       CustomTextfield(
//                         controller: customerNameController,
//                         hintText: 'Enter customer name',
//                       ),
//
//                       SizedBox(height: 14),
//                       // Text of the reasom to sale
//                       Text(
//                         'REASON / REMARKS (OPTIONAL)',
//                         style: TextStyle(
//                           fontWeight: .bold,
//                           fontSize: 12,
//                           color: AppColors.textLabels,
//                         ),
//                       ),
//                       SizedBox(height: 8),
//                       // Text form field of the reason to sale
//                       CustomTextfield(
//                         controller: reasonToSellController,
//                         hintText: '',
//                       ),
//                       SizedBox(height: 38),
//                       // confirm factory sale button
//                       // CustomButton(title: 'Confirm Factory Sale', onTap: () {}),
//                       CustomButton(
//                         title: factorySaleViewmodel.isLoading
//                             ? 'Processing...'
//                             : 'Confirm Factory Sale',
//                         onTap: () async {
//                           final quantity = int.tryParse(
//                             saleFactoryQuantityController.text.trim(),
//                           );
//
//                           if (quantity == null || quantity <= 0) {
//                             ScaffoldMessenger.of(context).showSnackBar(
//                               const SnackBar(
//                                 content: Text('Please enter a valid quantity'),
//                               ),
//                             );
//                             return;
//                           }
//
//                           final success = await factorySaleViewmodel.factorySale(
//                             productId: factorySaleViewmodel.selectedProduct!.id,
//                             quantity: quantity,
//                             customerName: customerNameController.text.trim(),
//                           );
//
//                           if (!mounted) return;
//
//                           if (success) {
//                             await stockViewModel.getStock();
//
//                             if (!mounted) return;
//
//                             ScaffoldMessenger.of(context).showSnackBar(
//                               const SnackBar(
//                                 content: Text('Factory sale completed successfully'),
//                               ),
//                             );
//
//                             saleFactoryQuantityController.clear();
//                             customerNameController.clear();
//                             reasonToSellController.clear();
//                           } else {
//                             ScaffoldMessenger.of(context).showSnackBar(
//                               SnackBar(
//                                 content: Text(
//                                   factorySaleViewmodel.errorMessage ??
//                                       'Factory sale failed',
//                                 ),
//                               ),
//                             );
//                           }
//                         },
//                       ),
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

import 'package:e_stock/core/constants/app_color.dart';
import 'package:e_stock/model/customer_model.dart';
import 'package:e_stock/model/stock_model.dart';
import 'package:e_stock/view_Model/product_viewModel.dart';
import 'package:e_stock/view_Model/stock_viewModel.dart';
import 'package:e_stock/view_Model/transaction/factory_sale_viewmodel.dart';
import 'package:e_stock/views/widget/custom_Textfield.dart';
import 'package:e_stock/views/widget/custom_button.dart';
import 'package:e_stock/views/widget/searchable_Product_dropdown.dart';
import 'package:e_stock/views/widget/searchable_customer_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../view_Model/customer_viewmodel.dart';
import '../customer/add_customer_screen.dart';

class FactorySaleScreen extends StatefulWidget {
  const FactorySaleScreen({super.key});

  @override
  State<FactorySaleScreen> createState() => _FactorySaleScreenState();
}

class _FactorySaleScreenState extends State<FactorySaleScreen> {
  var saleFactoryQuantityController = TextEditingController();
  var reasonToSellController = TextEditingController();

  CustomerModel? selectedCustomer;
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CustomerViewModel>().listenToCustomers();
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;

    final factorySaleViewmodel = Provider.of<FactorySaleViewmodel>(context);

    final stockViewModel = Provider.of<StockViewmodel>(context);

    StockModel? selectedStock;

    for (final stock in stockViewModel.allStock) {
      if (stock.productId == factorySaleViewmodel.selectedProduct?.id) {
        selectedStock = stock;
        break;
      }
    }

    final productViewModel = Provider.of<ProductViewmodel>(context);

    return Scaffold(
      backgroundColor: AppColors.backgroundCanvas,
      resizeToAvoidBottomInset: true,

      appBar: AppBar(
        backgroundColor: AppColors.headerNavy,
        automaticallyImplyLeading: false,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Factory Sale / Direct Deduction',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 4),
            Text(
              'Reduce main warehouse quantity',
              style: TextStyle(
                color: AppColors.textMuted,
                fontSize: 12,
                fontWeight: FontWeight.w400,
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

              Container(
                width: screenWidth - 20,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppColors.inputBorder),
                ),

                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 19),
                        child: Text(
                          'MANUALLY SELECT PRODUCT',
                          style: TextStyle(
                            color: AppColors.textLabels,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      SizedBox(height: 8),

                      // PRODUCT SELECTION
                      SearchableProductDropdown(
                        products: productViewModel.allProducts,
                        onChanged: (product) {
                          factorySaleViewmodel.selectProduct(product);
                        },
                      ),

                      SizedBox(height: 17),

                      // AVAILABLE FACTORY STOCK
                      Container(
                        width: screenWidth - 20,
                        height: 100,
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.inputBorder),
                          borderRadius: BorderRadius.circular(10),
                          color: AppColors.backgroundCanvas,
                        ),

                        child: Padding(
                          padding: const EdgeInsets.only(top: 14, left: 16),

                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'AVAILABLE IN FACTORY',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.textLabels,
                                ),
                              ),

                              SizedBox(height: 6),

                              Text(
                                selectedStock == null
                                    ? '0 Packs'
                                    : '${selectedStock.factoryStock} Packs',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: AppColors.productionGreen,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      SizedBox(height: 17),

                      // QUANTITY
                      Text(
                        'DEDUCT QUANTITY (PACKS)',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: AppColors.textLabels,
                        ),
                      ),

                      SizedBox(height: 8),

                      CustomTextfield(
                        controller: saleFactoryQuantityController,
                        hintText: 'Add Quantity',
                      ),

                      SizedBox(height: 14),

                      // CUSTOMER
                      Text(
                        'CUSTOMER NAME',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: AppColors.textLabels,
                        ),
                      ),

                      SizedBox(height: 8),
                      SearchableCustomerField(
                        selectedCustomer: selectedCustomer,

                        onCustomerSelected: (customer) {
                          setState(() {
                            selectedCustomer = customer;
                          });
                        },

                        onAddCustomer: () async {
                          final result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const AddCustomerScreen(),
                            ),
                          );

                          if (!mounted) return;

                          if (result == 'added') {
                            final customerViewModel = context
                                .read<CustomerViewModel>();

                            final customers = customerViewModel.allCustomers;

                            if (customers.isNotEmpty) {
                              setState(() {
                                selectedCustomer = customers.last;
                              });
                            }
                          }
                        },
                      ),

                      SizedBox(height: 14),

                      // REASON
                      Text(
                        'REASON / REMARKS (OPTIONAL)',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: AppColors.textLabels,
                        ),
                      ),

                      SizedBox(height: 8),

                      CustomTextfield(
                        controller: reasonToSellController,
                        hintText: '',
                      ),

                      SizedBox(height: 38),

                      // CONFIRM SALE
                      CustomButton(
                        title: factorySaleViewmodel.isLoading
                            ? 'Processing...'
                            : 'Confirm Factory Sale',

                        onTap: () async {
                          final quantity = int.tryParse(
                            saleFactoryQuantityController.text.trim(),
                          );

                          if (quantity == null || quantity <= 0) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Please enter a valid quantity'),
                              ),
                            );
                            return;
                          }

                          if (factorySaleViewmodel.selectedProduct == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Please select a product'),
                              ),
                            );
                            return;
                          }

                          if (selectedCustomer == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Please select a customer'),
                              ),
                            );
                            return;
                          }

                          final success = await factorySaleViewmodel
                              .factorySale(
                                productId:
                                    factorySaleViewmodel.selectedProduct!.id,
                                quantity: quantity,
                                customerId: selectedCustomer!.id,
                            customerName: selectedCustomer!.name,
                              );

                          if (!mounted) return;

                          if (success) {
                            await stockViewModel.getStock();

                            if (!mounted) return;

                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Factory sale completed successfully',
                                ),
                              ),
                            );

                            saleFactoryQuantityController.clear();

                            reasonToSellController.clear();

                            setState(() {
                              selectedCustomer = null;
                            });
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  factorySaleViewmodel.errorMessage ??
                                      'Factory sale failed',
                                ),
                              ),
                            );
                          }
                        },
                      ),

                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 25),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    saleFactoryQuantityController.dispose();
    reasonToSellController.dispose();

    super.dispose();
  }
}
