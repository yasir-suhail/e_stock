import 'package:e_stock/model/customer_model.dart';
import 'package:e_stock/view_Model/transaction/van_sale_viewmodel.dart';
import 'package:e_stock/views/widget/custom_Textfield.dart';
import 'package:e_stock/views/widget/custom_button.dart';
import 'package:e_stock/views/widget/custom_dropButton.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/app_color.dart';
import '../../../model/stock_model.dart';
import '../../../view_Model/customer_viewmodel.dart';
import '../../../view_Model/product_viewModel.dart';
import '../../../view_Model/stock_viewModel.dart';
import '../../widget/searchable_Product_dropdown.dart';
import '../../widget/searchable_customer_field.dart';
import '../customer/add_customer_screen.dart';

class VansaleScreen extends StatefulWidget {
  const VansaleScreen({super.key});

  @override
  State<VansaleScreen> createState() => _VansaleScreenState();
}

class _VansaleScreenState extends State<VansaleScreen> {
  var saleFromVanQuantityController = TextEditingController();
  var shopCustomerNameController = TextEditingController();

  CustomerModel? selectedCustomer;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final productViewModel = Provider.of<ProductViewmodel>(context);
    final vanSaleViewmodel = Provider.of<VanSaleViewmodel>(context);
    final stockViewModel = Provider.of<StockViewmodel>(context);

    StockModel? selectedStock;

    for (final stock in stockViewModel.allStock) {
      if (stock.productId == vanSaleViewmodel.selectedProduct?.id) {
        selectedStock = stock;
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
              'Record Van Route Sale',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: .bold,
              ),
            ),
            SizedBox(height: 4),
            Text(
              'Deduct quantity directly from mobile van',
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
                // height: 550,
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
                          'MANUALLY SELECT PRODUCT',
                          style: TextStyle(
                            color: AppColors.textLabels,
                            fontSize: 12,
                            fontWeight: .bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 8),

                      //  custom drop down menu
                      // PRODUCT SELECTION
                      SearchableProductDropdown(
                        products: productViewModel.allProducts,
                        onChanged: (product) {
                          vanSaleViewmodel.selectProduct(product);
                        },
                      ),

                      SizedBox(height: 17),
                      // available stock in factory container
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
                            crossAxisAlignment: .start,
                            children: [
                              Text(
                                'AVAILABLE ON VAN',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: .bold,
                                  color: AppColors.textLabels,
                                ),
                              ),
                              SizedBox(height: 6),
                              Text(
                                selectedStock == null
                                    ? '0 Packs'
                                    : '${selectedStock.vanStock} Packs',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: AppColors.vanAmber,
                                  fontWeight: .bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 17),
                      // text of the factory sale quantity
                      Text(
                        'DEDUCT QUANTITY (PACKS)',
                        style: TextStyle(
                          fontWeight: .bold,
                          fontSize: 12,
                          color: AppColors.textLabels,
                        ),
                      ),
                      SizedBox(height: 8),
                      // Text Form field of the quantity ]
                      CustomTextfield(
                        focusedColor: AppColors.vanAmber,
                        controller: saleFromVanQuantityController,
                        hintText: 'Add Quantity',
                      ),
                      SizedBox(height: 14),
                      // Text of the shop/customer name
                      Text(
                        'SHOP / CUSTOMER NAME',
                        style: TextStyle(
                          fontWeight: .bold,
                          fontSize: 12,
                          color: AppColors.textLabels,
                        ),
                      ),
                      SizedBox(height: 8),
                      // Text form field of the the customer /shop name
                      // CustomTextfield(
                      //   focusedColor: AppColors.vanAmber,
                      //   controller: shopCustomerNameController,
                      //   hintText: 'ASSAD FOODS',
                      // ),
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

                      SizedBox(height: 38),
                      // confirm factory sale button
                      CustomButton(
                        title: vanSaleViewmodel.isLoading
                            ? 'Processing'
                            : 'Confirm van sale',
                        backgroundColor: AppColors.vanAmber,
                        onTap: () async {
                          // Get quantity text and try to convert it into an integer
                          final quantity = int.tryParse(
                            saleFromVanQuantityController.text.trim(),
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

                          // Check product selection
                          if (vanSaleViewmodel.selectedProduct == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Please select a product'),
                              ),
                            );
                            return;
                          }

                          // Check customer selection
                          if (selectedCustomer == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Please select a customer'),
                              ),
                            );
                            return;
                          }

                          // Call ViewModel to perform the van sale
                          final success = await vanSaleViewmodel.vanSale(
                            productId: vanSaleViewmodel.selectedProduct!.id,
                            quantity: quantity,
                            customerId: selectedCustomer!.id,
                            customerName: selectedCustomer!.name,
                          );

                          // Check whether screen is still mounted
                          if (!mounted) return;

                          if (success) {
                            // Refresh stock after successful sale
                            await stockViewModel.getStock();

                            if (!mounted) return;

                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Van sale completed successfully'),
                              ),
                            );

                            // Clear quantity field
                            saleFromVanQuantityController.clear();

                            // Clear selected customer
                            setState(() {
                              selectedCustomer = null;
                            });
                          } else {
                            // Show error returned by ViewModel
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  vanSaleViewmodel.errorMessage ?? 'Van sale failed',
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
