import 'package:flutter/material.dart';

import '../../core/constants/app_color.dart';

class SalesmanCustomTextfield extends StatelessWidget {
  final String hintText;
  final TextEditingController? controller;
  bool obscureText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextInputType? keyboardtype;
  final String? Function(String?)? validator;

   SalesmanCustomTextfield({
    required this.hintText,
    this.suffixIcon,
    this.prefixIcon,
    this.validator,
    this.obscureText=false,
    this.controller,
    this.keyboardtype,
    super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      controller: controller,
      keyboardType: keyboardtype,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hintText,hintStyle:TextStyle(fontWeight: .w400,fontSize: 13,color: AppColors.textMuted),
        prefixIcon: prefixIcon,prefixIconColor: AppColors.textMuted,
        suffixIcon: suffixIcon,suffixIconColor: AppColors.textMuted,
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: AppColors.inputBorder),
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: AppColors.vanAmber)
        ),
      ),
    );
  }
}
