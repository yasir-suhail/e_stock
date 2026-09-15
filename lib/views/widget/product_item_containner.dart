import 'package:e_stock/core/constants/app_color.dart';
import 'package:flutter/material.dart';

class ProductItemContainer extends StatelessWidget {
  final String productName;
  final String unit;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const ProductItemContainer({
    super.key,
    required this.productName,
    required this.unit,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:  EdgeInsets.only(bottom: 14),
      padding:  EdgeInsets.all(12),
      // height: 120,
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        border: Border.all(
          color: AppColors.inputBorder,
          width: 1.5,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          // Product icon
          Container(
            width: 45,
            height: 45,
            decoration: BoxDecoration(
              color: AppColors.headerNavy,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: AppColors.inputBorder,
              ),
            ),
            child:  Icon(
              Icons.inventory_2_outlined,
              color: Colors.white,
              size: 25,
            ),
          ),

           SizedBox(width: 12),

          // Product information
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                // Product name
                Text(
                  productName,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                 SizedBox(height: 4),

                // SKU + Unit
                Text(
                  ' Unit: $unit',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: AppColors.textMuted,
                    fontSize: 12,
                  ),
                ),

                 SizedBox(height: 9),

                // Stock information
                Row(
                  children: [

                    // Factory stock
                    // Container(
                    //   padding:  EdgeInsets.symmetric(
                    //     horizontal: 10,
                    //     vertical: 6,
                    //   ),
                    //   decoration: BoxDecoration(
                    //     color: AppColors.headerNavy,
                    //     borderRadius: BorderRadius.circular(6),
                    //   ),
                    //   child: Text(
                    //     'Factory: $factoryStock Packs',
                    //     style: TextStyle(
                    //       color: AppColors.productionGreen,
                    //       fontSize: 8,
                    //       fontWeight: FontWeight.bold,
                    //     ),
                    //   ),
                    // ),

                     SizedBox(width: 7),

                    // Van stock
                    // Container(
                    //   padding:  EdgeInsets.symmetric(
                    //     horizontal: 12,
                    //     vertical: 6,
                    //   ),
                    //   decoration: BoxDecoration(
                    //     color: AppColors.headerNavy,
                    //     borderRadius: BorderRadius.circular(6),
                    //   ),
                    //   child: Text(
                    //     'Van: $vanStock Packs',
                    //     style: TextStyle(
                    //       color: AppColors.vanAmber,
                    //       fontSize: 8,
                    //       fontWeight: FontWeight.bold,
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ],
            ),
          ),

           SizedBox(width: 8),

          // Edit + Delete buttons
          Column(
            children: [

              // Edit
              SizedBox(
                width: 50,
                height: 36,
                child: ElevatedButton(
                  onPressed: onEdit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryBlue,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.zero,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7),
                    ),
                  ),
                  child:  Text(
                    'Edit',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

               SizedBox(height: 7),

              // Delete
              SizedBox(
                width: 50,
                height: 36,
                child: OutlinedButton(
                  onPressed: onDelete,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.red,
                    side:  BorderSide(
                      color: Colors.red,
                    ),
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7),
                    ),
                  ),
                  child:  Icon(
                    Icons.delete_outline,
                    size: 19,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}