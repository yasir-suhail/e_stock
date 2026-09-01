import 'package:e_stock/core/constants/app_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final bool loading;

  const CustomButton({
    required this.title,
    required this.onTap,
    this.loading = false,
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
          color: AppColors.primaryBlue,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: loading
              ? CircularProgressIndicator(strokeAlign: 0, color: Colors.white)
              : Text(title, style: TextStyle(fontWeight: FontWeight.bold,fontSize: 13,color: Colors.white)),
        ),
      ),
    );
  }
}
