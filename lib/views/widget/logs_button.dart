import 'package:e_stock/core/constants/app_color.dart';
import 'package:flutter/cupertino.dart';

class LogsButton extends StatelessWidget {
  final String title;
  final bool isSelected;

  final VoidCallback onTap;

  const LogsButton({
    required this.title,
    required this.onTap,
    required this.isSelected,

    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16,vertical: 10),
        margin: EdgeInsets.only(right: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.headerNavy : AppColors.whiteColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isSelected ? AppColors.headerNavy : AppColors.inputBorder,
          ),
        ),
        child: Text(
          title,
          style: TextStyle(
            fontWeight: isSelected ? FontWeight.bold : FontWeight.w400,
            color: isSelected ? AppColors.whiteColor : AppColors.textLabels,
          ),
        ),
      ),
    );
  }
}
