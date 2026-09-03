import 'package:flutter/material.dart';
import 'package:e_stock/core/constants/app_color.dart';

class CustomDropdown extends StatelessWidget {
  final String? title;
  final String value;
  final List<String> items;
  final ValueChanged<String?> onChanged;
  final Colors? titleColor;

  const CustomDropdown({
    this.title,
    required this.value,
    required this.items,
    required this.onChanged,
    this.titleColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Text(
            title ==null? 'Select product': '$title',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: titleColor!=null ? AppColors.textLabels:AppColors.primaryBlue,
            ),
          ),
        ),

        DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            isExpanded: true,
            value: value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
            items: items
                .map(
                  (product) => DropdownMenuItem<String>(
                value: product,
                child: Text(product),
              ),
            )
                .toList(),
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}