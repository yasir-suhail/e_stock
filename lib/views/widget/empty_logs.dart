import 'package:flutter/material.dart';
import 'package:e_stock/core/constants/app_color.dart';

class EmptyLogs extends StatelessWidget {
  final String filter;

  const EmptyLogs({
    super.key,
    required this.filter,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.receipt_long_outlined,
            size: 50,
            color: AppColors.textMuted,
          ),

          const SizedBox(height: 12),

          Text(
            'No $filter logs found.',
            style: TextStyle(
              fontSize: 14,
              color: AppColors.textMuted,
            ),
          ),
        ],
      ),
    );
  }
}