import 'package:e_stock/core/constants/app_color.dart';
import 'package:e_stock/views/widget/custom_Textfield.dart';
import 'package:e_stock/views/widget/custom_button.dart';
import 'package:e_stock/views/widget/custom_dropButton.dart';
import 'package:e_stock/views/widget/searchable_Product_dropdown.dart';
import 'package:e_stock/views/widget/stock_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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

  @override
  void dispose() {
    factoryToVanController.dispose();
    selectVanController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;

    final loadVanViewModel = Provider.of<LoadVanViewmodel>(context);

    final stockViewModel = Provider.of<StockViewmodel>(context);

    // Find stock of selected product
    StockModel? selectedStock;

    for (final stock in stockViewModel.allStock) {
      if (stock.productId == loadVanViewModel.selectedProduct?.id) {
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
                // height: 550,
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
                      SearchableProductDropdown(
                        hintText: 'Search or select product',
                        products: productViewModel.allProducts,
                        onChanged: (product) {
                          loadVanViewModel.selectProduct(product);
                        },
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
                          // Check selected product
                          if (loadVanViewModel.selectedProduct == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Please select a product'),
                              ),
                            );
                            return;
                          }

                          // Convert quantity
                          final quantity = int.tryParse(
                            factoryToVanController.text,
                          );

                          // Check quantity
                          if (quantity == null || quantity <= 0) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Please enter a valid quantity'),
                              ),
                            );
                            return;
                          }

                          // Load stock from factory to van
                          final success = await loadVanViewModel.loadVan(
                            productId: loadVanViewModel.selectedProduct!.id,
                            quantity: quantity,
                          );

                          if (!mounted) return;

                          // Successful transfer
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
                          } else {
                            // Transfer failed
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

// import 'package:e_stock/core/constants/app_color.dart';
// import 'package:e_stock/views/widget/custom_Textfield.dart';
// import 'package:e_stock/views/widget/custom_button.dart';
// import 'package:e_stock/views/widget/stock_card.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// import '../../../model/product_model.dart';
// import '../../../model/stock_model.dart';
// import '../../../view_Model/product_viewModel.dart';
// import '../../../view_Model/stock_viewModel.dart';
// import '../../../view_Model/transaction/load_van_viewmodel.dart';
//
// class LoadVanScreen extends StatefulWidget {
//   const LoadVanScreen({super.key});
//
//   @override
//   State<LoadVanScreen> createState() => _LoadVanScreenState();
// }
//
// class _LoadVanScreenState extends State<LoadVanScreen> {
//   final factoryToVanController = TextEditingController();
//   final selectVanController = TextEditingController();
//   final productSearchController = TextEditingController();
//
//   String? selectedProductId;
//
//   // Controls whether the product list is visible
//   bool isProductDropdownOpen = false;
//
//   @override
//   void dispose() {
//     factoryToVanController.dispose();
//     selectVanController.dispose();
//     productSearchController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.sizeOf(context).width;
//
//     final loadVanViewModel = Provider.of<LoadVanViewmodel>(context);
//
//     final stockViewModel = Provider.of<StockViewmodel>(context);
//
//     final productViewModel = Provider.of<ProductViewmodel>(context);
//
//     // Find stock of selected product
//     StockModel? selectedStock;
//
//     for (final stock in stockViewModel.allStock) {
//       if (stock.productId == selectedProductId) {
//         selectedStock = stock;
//         break;
//       }
//     }
//
//     return Scaffold(
//       backgroundColor: AppColors.backgroundCanvas,
//       resizeToAvoidBottomInset: true,
//
//       appBar: AppBar(
//         backgroundColor: AppColors.headerNavy,
//         automaticallyImplyLeading: false,
//         title: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Load Van Stock Transfer',
//               style: TextStyle(
//                 color: Colors.white,
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const SizedBox(height: 4),
//             Text(
//               'Move inventory from Factory to Van',
//               style: TextStyle(
//                 color: AppColors.textMuted,
//                 fontSize: 12,
//                 fontWeight: FontWeight.w400,
//               ),
//             ),
//           ],
//         ),
//       ),
//
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 10),
//           child: Column(
//             children: [
//               const SizedBox(height: 25),
//
//               // ======================================================
//               // MAIN CONTAINER
//               // ======================================================
//               Container(
//                 width: screenWidth - 20,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(10),
//                   border: Border.all(color: AppColors.inputBorder),
//                   color: Colors.white,
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 10),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       // ==================================================
//                       // SELECT PRODUCT
//                       // ==================================================
//                       Padding(
//                         padding: const EdgeInsets.only(top: 19),
//                         child: Text(
//                           'SELECT PRODUCT TO LOAD',
//                           style: TextStyle(
//                             color: AppColors.textLabels,
//                             fontSize: 12,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//
//                       const SizedBox(height: 8),
//
//                       // ==================================================
//                       // SEARCH + DROPDOWN FIELD
//                       // ==================================================
//                       TextField(
//                         controller: productSearchController,
//
//                         decoration: InputDecoration(
//                           hintText: selectedProductId == null
//                               ? 'Search or select product...'
//                               : 'Product selected',
//
//                           prefixIcon: Icon(
//                             selectedProductId == null
//                                 ? Icons.search
//                                 : Icons.check_circle,
//                             color: selectedProductId != null
//                                 ? Colors.green
//                                 : AppColors.textMuted,
//                           ),
//
//                           // Clear selected/search text
//                           suffixIcon: Row(
//                             mainAxisSize: MainAxisSize.min,
//                             children: [
//                               if (productSearchController.text.isNotEmpty)
//                                 IconButton(
//                                   icon: const Icon(Icons.clear),
//                                   onPressed: () {
//                                     setState(() {
//                                       selectedProductId = null;
//                                       productSearchController.clear();
//                                       isProductDropdownOpen = true;
//                                     });
//                                   },
//                                 ),
//
//                               // Dropdown arrow
//                               IconButton(
//                                 icon: Icon(
//                                   isProductDropdownOpen
//                                       ? Icons.keyboard_arrow_up
//                                       : Icons.keyboard_arrow_down,
//                                 ),
//                                 onPressed: () {
//                                   setState(() {
//                                     isProductDropdownOpen =
//                                         !isProductDropdownOpen;
//
//                                     // If opening dropdown,
//                                     // show all products.
//                                     if (isProductDropdownOpen) {
//                                       selectedProductId = null;
//                                       productSearchController.clear();
//                                     }
//                                   });
//                                 },
//                               ),
//                             ],
//                           ),
//
//                           filled: true,
//
//                           // Selected product gets a different color
//                           fillColor: selectedProductId != null
//                               ? Colors.green.withOpacity(0.08)
//                               : AppColors.backgroundCanvas,
//
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(8),
//                           ),
//
//                           enabledBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(8),
//                             borderSide: BorderSide(
//                               color: selectedProductId != null
//                                   ? Colors.green
//                                   : AppColors.inputBorder,
//                             ),
//                           ),
//
//                           focusedBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(8),
//                             borderSide: BorderSide(
//                               color: AppColors.primaryBlue,
//                               width: 1.5,
//                             ),
//                           ),
//                         ),
//
//                         // Open dropdown when user taps field
//                         onTap: () {
//                           setState(() {
//                             isProductDropdownOpen = true;
//                           });
//                         },
//
//                         // Search products while typing
//                         onChanged: (value) {
//                           setState(() {
//                             selectedProductId = null;
//                             isProductDropdownOpen = true;
//                           });
//                         },
//                       ),
//
//                       const SizedBox(height: 8),
//
//                       // ==================================================
//                       // PRODUCT DROPDOWN / SEARCH RESULTS
//                       // ==================================================
//                       if (isProductDropdownOpen)
//                         Container(
//                           constraints: const BoxConstraints(maxHeight: 220),
//                           decoration: BoxDecoration(
//                             color: Colors.white,
//                             borderRadius: BorderRadius.circular(8),
//                             border: Border.all(color: AppColors.inputBorder),
//                             boxShadow: [
//                               BoxShadow(
//                                 color: Colors.black.withOpacity(0.08),
//                                 blurRadius: 6,
//                                 offset: const Offset(0, 2),
//                               ),
//                             ],
//                           ),
//                           child: Builder(
//                             builder: (context) {
//                               final searchText = productSearchController.text
//                                   .trim()
//                                   .toLowerCase();
//
//                               // If search is empty,
//                               // show all products.
//                               final matchingProducts = productViewModel
//                                   .allProducts
//                                   .where((product) {
//                                     final productName =
//                                         '${product.productName} '
//                                                 '${product.packaging}'
//                                             .toLowerCase();
//
//                                     // Show everything when
//                                     // there is no search text.
//                                     if (searchText.isEmpty) {
//                                       return true;
//                                     }
//
//                                     return productName.contains(searchText);
//                                   })
//                                   .toList();
//
//                               // ------------------------------------------
//                               // NO PRODUCT FOUND
//                               // ------------------------------------------
//
//                               if (matchingProducts.isEmpty) {
//                                 return const Padding(
//                                   padding: EdgeInsets.all(18),
//                                   child: Center(
//                                     child: Text(
//                                       'No product found',
//                                       style: TextStyle(
//                                         color: Colors.grey,
//                                         fontSize: 14,
//                                       ),
//                                     ),
//                                   ),
//                                 );
//                               }
//
//                               // ------------------------------------------
//                               // PRODUCT LIST
//                               // ------------------------------------------
//
//                               return ListView.separated(
//                                 shrinkWrap: true,
//                                 itemCount: matchingProducts.length,
//
//                                 separatorBuilder: (context, index) {
//                                   return Divider(
//                                     height: 1,
//                                     color: AppColors.inputBorder,
//                                   );
//                                 },
//
//                                 itemBuilder: (context, index) {
//                                   final product = matchingProducts[index];
//
//                                   return Material(
//                                     color: Colors.transparent,
//                                     child: InkWell(
//                                       onTap: () {
//                                         setState(() {
//                                           selectedProductId = product.id;
//
//                                           productSearchController.text =
//                                               '${product.productName} '
//                                               '${product.packaging}';
//
//                                           isProductDropdownOpen = false;
//                                         });
//
//                                         FocusScope.of(context).unfocus();
//                                       },
//
//                                       // Different color when
//                                       // user touches a product
//                                       splashColor: AppColors.primaryBlue
//                                           .withOpacity(0.12),
//
//                                       highlightColor: AppColors.primaryBlue
//                                           .withOpacity(0.06),
//
//                                       child: Padding(
//                                         padding: const EdgeInsets.symmetric(
//                                           horizontal: 12,
//                                           vertical: 11,
//                                         ),
//                                         child: Row(
//                                           children: [
//                                             Container(
//                                               width: 36,
//                                               height: 36,
//                                               decoration: BoxDecoration(
//                                                 color: AppColors.primaryBlue
//                                                     .withOpacity(0.10),
//                                                 borderRadius:
//                                                     BorderRadius.circular(8),
//                                               ),
//                                               child: Icon(
//                                                 Icons.inventory_2_outlined,
//                                                 size: 19,
//                                                 color: AppColors.primaryBlue,
//                                               ),
//                                             ),
//
//                                             const SizedBox(width: 10),
//
//                                             Expanded(
//                                               child: Text(
//                                                 '${product.productName} '
//                                                 '${product.packaging}',
//                                                 style: const TextStyle(
//                                                   fontSize: 14,
//                                                   fontWeight: FontWeight.w500,
//                                                   color: Colors.black87,
//                                                 ),
//                                               ),
//                                             ),
//
//                                             Icon(
//                                               Icons.arrow_forward_ios,
//                                               size: 14,
//                                               color: AppColors.textMuted,
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                     ),
//                                   );
//                                 },
//                               );
//                             },
//                           ),
//                         ),
//
//                       const SizedBox(height: 18),
//
//                       // ==================================================
//                       // STOCK CARDS
//                       // ==================================================
//                       Row(
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           Expanded(
//                             child: StockCard(
//                               containerHeight: 100,
//                               title: 'Factory(SOURCE)',
//                               value: selectedStock == null
//                                   ? '0 Packs'
//                                   : '${selectedStock.factoryStock} Packs',
//                               valueColor: AppColors.productionGreen,
//                             ),
//                           ),
//
//                           const SizedBox(width: 10),
//
//                           Expanded(
//                             child: StockCard(
//                               containerHeight: 100,
//                               title: 'Van(TARGET)',
//                               value: selectedStock == null
//                                   ? '0 Packs'
//                                   : '${selectedStock.vanStock} Packs',
//                               valueColor: AppColors.vanAmber,
//                             ),
//                           ),
//                         ],
//                       ),
//
//                       const SizedBox(height: 24),
//
//                       // ==================================================
//                       // TRANSFER QUANTITY
//                       // ==================================================
//                       Text(
//                         'TRANSFER QUANTITY (PACKS)',
//                         style: TextStyle(
//                           fontSize: 12,
//                           fontWeight: FontWeight.bold,
//                           color: AppColors.textLabels,
//                         ),
//                       ),
//
//                       const SizedBox(height: 8),
//
//                       CustomTextfield(
//                         controller: factoryToVanController,
//                         hintText: 'Enter Quantity',
//                       ),
//
//                       const SizedBox(height: 19),
//
//                       // ==================================================
//                       // SELECT DRIVER / VAN
//                       // ==================================================
//                       Text(
//                         'SELECT DRIVER / VAN',
//                         style: TextStyle(
//                           fontSize: 12,
//                           fontWeight: FontWeight.bold,
//                           color: AppColors.textLabels,
//                         ),
//                       ),
//
//                       const SizedBox(height: 8),
//
//                       CustomTextfield(
//                         controller: selectVanController,
//                         hintText: 'Van #01 — Toyota HiAce (LES-4412)',
//                       ),
//
//                       const SizedBox(height: 30),
//
//                       // ==================================================
//                       // EXECUTE TRANSFER
//                       // ==================================================
//                       CustomButton(
//                         title: loadVanViewModel.isLoading
//                             ? 'Transferring...'
//                             : 'Execute Transfer',
//
//                         onTap: () async {
//                           // Check product
//                           if (selectedProductId == null) {
//                             ScaffoldMessenger.of(context).showSnackBar(
//                               const SnackBar(
//                                 content: Text('Please select a product'),
//                               ),
//                             );
//                             return;
//                           }
//
//                           // Convert quantity
//                           final quantity = int.tryParse(
//                             factoryToVanController.text,
//                           );
//
//                           // Check quantity
//                           if (quantity == null || quantity <= 0) {
//                             ScaffoldMessenger.of(context).showSnackBar(
//                               const SnackBar(
//                                 content: Text('Please enter a valid quantity'),
//                               ),
//                             );
//                             return;
//                           }
//
//                           // Load stock from factory to van
//                           final success = await loadVanViewModel.loadVan(
//                             productId: selectedProductId!,
//                             quantity: quantity,
//                           );
//
//                           if (!mounted) return;
//
//                           // Successful transfer
//                           if (success) {
//                             await stockViewModel.getStock();
//
//                             if (!mounted) return;
//
//                             ScaffoldMessenger.of(context).showSnackBar(
//                               const SnackBar(
//                                 content: Text(
//                                   'Stock successfully transferred to van',
//                                 ),
//                               ),
//                             );
//
//                             factoryToVanController.clear();
//                           } else {
//                             // Transfer failed
//                             ScaffoldMessenger.of(context).showSnackBar(
//                               SnackBar(
//                                 content: Text(
//                                   loadVanViewModel.errorMessage ??
//                                       'Transfer failed',
//                                 ),
//                               ),
//                             );
//                           }
//                         },
//                       ),
//
//                       const SizedBox(height: 20),
//                     ],
//                   ),
//                 ),
//               ),
//
//               const SizedBox(height: 25),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
