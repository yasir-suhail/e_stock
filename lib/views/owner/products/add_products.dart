import 'package:e_stock/core/constants/app_color.dart';
import 'package:e_stock/views/widget/custom_Textfield.dart';
import 'package:e_stock/views/widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:e_stock/view_Model/product_viewModel.dart';

import '../../../model/product_model.dart';

class AddProducts extends StatefulWidget {
  final ProductModel? product;

  const AddProducts({this.product, super.key});

  @override
  State<AddProducts> createState() => _AddProductsState();
}

class _AddProductsState extends State<AddProducts> {
  var productNameController = TextEditingController();
  var productPackageSizeController = TextEditingController();
  var productInitialStockController = TextEditingController();
  var productMinimumAlertController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();

    if (widget.product != null) {
      productNameController.text = widget.product!.productName;
      productPackageSizeController.text = widget.product!.packaging;
      productMinimumAlertController.text = widget.product!.minimumStockAlert
          .toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    final screeenWidth = MediaQuery.sizeOf(context).width;
    final productViewModel = Provider.of<ProductViewmodel>(context);
    return Scaffold(
      backgroundColor: AppColors.backgroundCanvas,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.headerNavy,
        title: Column(
          crossAxisAlignment: .start,
          children: [
            Text(
              widget.product == null ? 'Add New Product' : 'Edit Product',
              style: TextStyle(
                color: AppColors.whiteColor,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 4),
            Text(
              widget.product == null
                  ? 'Register a new item into inventory catalog'
                  : 'Update product information',
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
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Container(
            width: screeenWidth - 10,
            height: 550,
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              border: Border.all(color: AppColors.inputBorder),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: .start,
                  children: [
                    Text(
                      // product name
                      'PRODUCT NAME',
                      style: TextStyle(
                        color: AppColors.textLabels,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 9),
                    // product name text field
                    CustomTextfield(
                      controller: productNameController,
                      focusedColor: AppColors.inputBorder,
                      hintText: 'Product name',
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter product name';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10),
                    //package unit size
                    Text(
                      'PACKAGING / UNIT SIZE',
                      style: TextStyle(
                        color: AppColors.textLabels,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 9),
                    //package unit size text field
                    CustomTextfield(
                      controller: productPackageSizeController,
                      focusedColor: AppColors.inputBorder,
                      hintText: '500g packs / Jar',
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter packaging / unit size';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10),
                    // initial stock
                    Text(
                      'INITIAL FACTORY OPENING STOCK',
                      style: TextStyle(
                        color: AppColors.textLabels,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 9),
                    // initial factory stock text form field
                    CustomTextfield(
                      keyboardtype: .number,
                      controller: productInitialStockController,
                      focusedColor: AppColors.inputBorder,
                      hintText: '',
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return null; // Empty is allowed
                        }

                        if (int.tryParse(value.trim()) == null) {
                          return 'Please enter a valid number';
                        }

                        return null;
                      },
                    ),
                    SizedBox(height: 10),
                    // minimum stock alert
                    Text(
                      'MINIMUM STOCK ALERT THRESHOLD',
                      style: TextStyle(
                        color: AppColors.textLabels,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 9),
                    // minimum stock alert text field
                    CustomTextfield(
                      keyboardtype: .number,
                      controller: productMinimumAlertController,
                      focusedColor: AppColors.inputBorder,
                      hintText: 'Minimum stock alert',
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter minimum stock alert';
                        }

                        if (int.tryParse(value.trim()) == null) {
                          return 'Please enter a valid number';
                        }

                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    // save product Button
                    // CustomButton(
                    //   backgroundColor: AppColors.productionGreen,
                    //
                    //   title: productViewModel.isAddingProduct
                    //       ? 'Saving...'
                    //       : 'Save Product Item (+)',
                    //
                    //   onTap: productViewModel.isAddingProduct
                    //       ? () {}
                    //       : () async {
                    //           if (!_formKey.currentState!.validate()) {
                    //             return;
                    //           }
                    //           // final initialStock =
                    //           // productInitialStockController.text.trim().isEmpty
                    //           //     ? 0
                    //           //     : int.parse(
                    //           //   productInitialStockController.text.trim(),
                    //           // );
                    //           final product = ProductModel(
                    //
                    //             id: DateTime.now().millisecondsSinceEpoch
                    //                 .toString(),
                    //             productName: productNameController.text.trim(),
                    //             packaging: productPackageSizeController.text
                    //                 .trim(),
                    //             minimumStockAlert: int.parse(
                    //               productMinimumAlertController.text.trim(),
                    //             ),
                    //           );
                    //
                    //           final success = await productViewModel.addProduct(
                    //             product,
                    //           );
                    //
                    //           if (!mounted) return;
                    //
                    //           if (success) {
                    //             productNameController.clear();
                    //             productPackageSizeController.clear();
                    //             productInitialStockController.clear();
                    //             productMinimumAlertController.clear();
                    //
                    //             ScaffoldMessenger.of(context).showSnackBar(
                    //               const SnackBar(
                    //                 content: Text('Product added successfully'),
                    //               ),
                    //             );
                    //           }
                    //         },
                    // ),
                    CustomButton(
                      backgroundColor: AppColors.productionGreen,

                      title: productViewModel.isAddingProduct
                          ? 'Saving...'
                          : widget.product == null
                          ? 'Save Product Item (+)'
                          : 'Update Product',

                      onTap: productViewModel.isAddingProduct
                          ? () {}
                          : () async {
                              if (!_formKey.currentState!.validate()) {
                                return;
                              }
                              final initialStock =
                                        productInitialStockController.text.trim().isEmpty
                                            ? 0
                                            : int.parse(
                                          productInitialStockController.text.trim(),
                                        );
                              final product = ProductModel(
                                id:
                                    widget.product?.id ??
                                    DateTime.now().millisecondsSinceEpoch
                                        .toString(),
                                productName: productNameController.text.trim(),
                                packaging: productPackageSizeController.text
                                    .trim(),
                                minimumStockAlert: int.parse(
                                  productMinimumAlertController.text.trim(),
                                ),
                              );

                              bool success;

                              if (widget.product == null) {
                                // ADD PRODUCT
                                success = await productViewModel.addProduct(
                                  product,initialStock,
                                );
                              } else {
                                // UPDATE PRODUCT
                                success = await productViewModel.updateProduct(
                                  product,
                                );
                              }

                              if (!mounted) return;

                              if (success) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      widget.product == null
                                          ? 'Product added successfully'
                                          : 'Product updated successfully',
                                    ),
                                  ),
                                );

                                Navigator.pop(context);
                              }
                            },
                    ),
                    SizedBox(height: 20),
                    CustomButton(
                      backgroundColor: AppColors.headerNavy,
                      title: 'Cancel',
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
