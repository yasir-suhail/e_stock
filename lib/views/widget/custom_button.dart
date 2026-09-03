import 'package:e_stock/core/constants/app_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final bool loading;
  final Color backgroundColor;
  final Color textColor;
  final Color? borderColor;

  const CustomButton({
    required this.title,
    required this.onTap,
    this.loading = false,
    this.backgroundColor=AppColors.primaryBlue,
    this.textColor= AppColors.whiteColor,
    this.borderColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: screenWidth-32,
        height: 44,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(10),
          border: borderColor!=null? Border.all(color: borderColor!): null
        ),
        child: Center(
          child: loading
              ? CircularProgressIndicator(strokeAlign: 0, color: Colors.white)
              : Text(title, style: TextStyle(fontWeight: FontWeight.bold,fontSize: 13,color: textColor)),
        ),
      ),
    );
  }
}

