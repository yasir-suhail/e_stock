import 'package:e_stock/core/constants/app_color.dart';
import 'package:e_stock/model/customer_model.dart';
import 'package:flutter/material.dart';

class CustomerCustomCard extends StatelessWidget {
  final CustomerModel customer;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const CustomerCustomCard({
    super.key,
    required this.customer,
    this.onEdit,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.inputBorder),
      ),

      child: Row(
        children: [
          // ================= CUSTOMER ICON =================
          Container(
            width: 45,
            height: 45,

            decoration: BoxDecoration(
              color: AppColors.primaryBlue.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),

            child: Icon(Icons.person_outline, color: AppColors.primaryBlue),
          ),

          const SizedBox(width: 12),

          // ================= CUSTOMER INFORMATION =================
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  customer.name,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 5),

                Text(
                  customer.phone.isEmpty ? 'No phone number' : customer.phone,
                  style: TextStyle(fontSize: 12, color: AppColors.textMuted),
                ),

                const SizedBox(height: 2),

                Text(
                  customer.address,
                  style: TextStyle(fontSize: 12, color: AppColors.textMuted),
                ),
              ],
            ),
          ),

          const SizedBox(width: 10),
          // PopupMenuButton<String>(
          //   onSelected: (value) {
          //     if (value == 'edit') {
          //       onEdit?.call();
          //     }
          //
          //     if (value == 'delete') {
          //       onDelete?.call();
          //     }
          //   },
          //
          //   itemBuilder: (context) => [
          //     const PopupMenuItem(
          //       value: 'edit',
          //       child: Row(
          //         children: [
          //           Icon(Icons.edit_outlined),
          //           SizedBox(width: 10),
          //           Text('Edit'),
          //         ],
          //       ),
          //     ),
          //
          //     const PopupMenuItem(
          //       value: 'delete',
          //       child: Row(
          //         children: [
          //           Icon(Icons.delete_outline),
          //           SizedBox(width: 10),
          //           Text('Delete'),
          //         ],
          //       ),
          //     ),
          //   ],
          // ),

          // ================= EDIT + DELETE BUTTONS =================
          Column(
            children: [

              // ================= EDIT =================
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

                  child: const Text(
                    'Edit',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 7),

              // ================= DELETE =================
              SizedBox(
                width: 50,
                height: 36,

                child: OutlinedButton(
                  onPressed: onDelete,

                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.red,

                    side: const BorderSide(
                      color: Colors.red,
                    ),

                    padding: EdgeInsets.zero,

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7),
                    ),
                  ),

                  child: const Icon(
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
