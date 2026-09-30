import 'package:e_stock/core/constants/app_color.dart';
import 'package:e_stock/views/owner/products/add_products.dart';
import 'package:e_stock/views/widget/custom_Textfield.dart';
import 'package:e_stock/views/widget/product_item_containner.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../view_Model/product_viewModel.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  var productSearchController=TextEditingController();
  @override
  // void initState() {
  //   super.initState();
  //
  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //     final productViewmodel =
  //     Provider.of<ProductViewmodel>(context, listen: false);
  //
  //     productViewmodel.getProducts();
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    final screenWidth=MediaQuery.sizeOf(context).width;
    final productViewmodel =
    Provider.of<ProductViewmodel>(context);
    return Scaffold(
      backgroundColor: AppColors.backgroundCanvas,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: AppColors.headerNavy,
        title: Column(
          crossAxisAlignment: .start,
          children: [
              Text('Manage Products',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: AppColors.whiteColor),),
            SizedBox(height: 4,),
            Text('Catalog Overview & Inventory Items',style: TextStyle(color: AppColors.textMuted,fontSize: 12,fontWeight: FontWeight.w400),)
          ],
        ),
        // ADD BUTTON
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddProducts(),
                ),
              );
            },
            icon: Icon(
              Icons.add,
              color: AppColors.whiteColor,
            ),
            tooltip: 'Add Product',
          ),

          SizedBox(width: 5),
        ],
      ),
      // floatingActionButton: FloatingActionButton.extended(
      //   backgroundColor: Color(0xffDCFCE7),
      //   foregroundColor: AppColors.productionGreen,
      //   onPressed: () {
      //     Navigator.push(
      //       context,
      //       MaterialPageRoute(
      //         builder: (context) => AddProducts()
      //       ),
      //     );
      //   },
      //   label: SizedBox(
      //       width: 90,
      //       height: 30,
      //       child: Row(children: [Icon(Icons.add), Text('Add items',)])),
      // ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
          child: Column(
            crossAxisAlignment: .start,
            children: [
              CustomTextfield(
                controller: productSearchController,
                prefixIcon: Icon(Icons.search, color: AppColors.textMuted),
                  focusedColor: AppColors.inputBorder,
                  hintText: 'Search product...',
                onChanged: (value){
                  productViewmodel.searchProducts(value);
                },

              ),
              SizedBox(height: 20,),
              // CUSTOMER LIST TITLE
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'PRODUCT LIST',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textLabels,
                  ),
                ),
              ),
              SizedBox(height: 10,),
              // Expanded(child: ListView(children: [
              //   ProductItemContainer(
              //     productName: 'Coriander Powder 250g',
              //     unit: '250g Pack',
              //     // factoryStock: 850,
              //     // vanStock: 20,
              //     onEdit: () {
              //       print('Edit Coriander');
              //     },
              //     onDelete: () {
              //       print('Delete Coriander');
              //     },
              //   ),
              // ],))
              Expanded(
                child: Consumer<ProductViewmodel>(
                  builder: (context, productViewModel, child) {

                    if (productViewModel.isLoadingProducts) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    if (productViewModel.displayProducts.isEmpty) {
                      return const Center(
                        child: Text('No products found'),
                      );
                    }

                    return ListView.builder(
                      itemCount: productViewModel.displayProducts.length,
                      itemBuilder: (context, index) {

                        final product =
                        productViewModel.displayProducts[index];

                        return ProductItemContainer(
                          productName: product.productName,
                          unit: product.packaging,

                          onEdit: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AddProducts(
                                  product: product,
                                ),
                              ),
                            );
                          },

                          onDelete: () async {
                            final shouldDelete = await showDialog<bool>(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text('Delete Product'),
                                  content: Text(
                                    'Are you sure you want to delete ${product.productName}?',
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context, false);
                                      },
                                      child: const Text('Cancel'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context, true);
                                      },
                                      child: const Text('Delete'),
                                    ),
                                  ],
                                );
                              },
                            );

                            if (shouldDelete != true) {
                              return;
                            }

                            final success = await productViewModel.deleteProduct(
                              product.id,
                            );

                            if (!context.mounted) return;

                            if (success) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Product deleted successfully'),
                                ),
                              );
                            }
                          },
                        );
                      },
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
