import 'package:e_stock/core/constants/app_color.dart';
import 'package:e_stock/views/owner/products/add_products.dart';
import 'package:e_stock/views/widget/custom_Textfield.dart';
import 'package:e_stock/views/widget/product_item_containner.dart';
import 'package:flutter/material.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  var productSearchController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    final screenWidth=MediaQuery.sizeOf(context).width;
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
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Color(0xffDCFCE7),
        foregroundColor: AppColors.productionGreen,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddProducts()),
          );
        },
        label: SizedBox(
            width: 90,
            height: 30,
            child: Row(children: [Icon(Icons.add), Text('Add items',)])),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
          child: Column(
            crossAxisAlignment: .start,
            children: [
              CustomTextfield(
                controller: productSearchController,
                  suffixIcon: Icon(Icons.search),
                  focusedColor: AppColors.inputBorder,
                  hintText: 'Search by product name'),
              SizedBox(height: 20,),
              Expanded(child: ListView(children: [
                ProductItemContainer(
                  productName: 'Coriander Powder 250g',
                  unit: '250g Pack',
                  // factoryStock: 850,
                  // vanStock: 20,
                  onEdit: () {
                    print('Edit Coriander');
                  },
                  onDelete: () {
                    print('Delete Coriander');
                  },
                ),
              ],))

            ],
          ),
        ),
      ),
    );
  }
}
