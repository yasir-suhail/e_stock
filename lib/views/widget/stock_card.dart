import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../core/constants/app_color.dart';

class StockCard extends StatelessWidget {
  final String title;
  final String value;
  final Color valueColor;
  const StockCard({
    required this.title,
    required this.value,
    required this.valueColor,
    super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 120,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: AppColors.inputBorder,
          ),
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.only(
            top: 12,
            left: 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  color: AppColors.textLabels,
                ),
              ),

              const SizedBox(height: 7),

              Text(
                value,
                style: TextStyle(
                  color: valueColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
