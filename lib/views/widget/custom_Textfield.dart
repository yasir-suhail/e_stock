import 'package:e_stock/core/constants/app_color.dart';
import 'package:flutter/material.dart';

class CustomTextfield extends StatelessWidget {
  final String hintText;
  final TextEditingController? controller;
  final bool obscureText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final TextInputType? keyboardtype;

  const CustomTextfield({
    required this.hintText,
    this.controller,
    this.obscureText = false,
    this.validator,
    this.keyboardtype,
    this.prefixIcon,
    this.suffixIcon,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      validator: validator,
      keyboardType: keyboardtype,
      decoration: InputDecoration(
        hintText: hintText,hintStyle:TextStyle(fontWeight: .w400,fontSize: 13,color: AppColors.textMuted),
        prefixIcon: prefixIcon,prefixIconColor: AppColors.textMuted,
        suffixIcon: suffixIcon,suffixIconColor: AppColors.textMuted,
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: AppColors.inputBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: AppColors.primaryBlue)
        ),

        // errorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red),
        // borderRadius: BorderRadius.circular(10),
        // ),
        //   focusedErrorBorder:OutlineInputBorder(borderSide: BorderSide(color: Colors.red),
        //   borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}
