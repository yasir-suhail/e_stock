import 'package:e_stock/core/constants/app_color.dart';
import 'package:e_stock/views/owner/navigation_screen.dart';
import 'package:e_stock/views/widget/custom_Textfield.dart';
import 'package:e_stock/views/widget/custom_button.dart';
import 'package:flutter/material.dart';

class SalemanForm extends StatefulWidget {
  const SalemanForm({super.key});

  @override
  State<SalemanForm> createState() => _SalemanFormState();
}

class _SalemanFormState extends State<SalemanForm> {
  var salemanEmailController = TextEditingController();
  var salemanpasswordController = TextEditingController();
  bool showPassword = false;
  bool loading = false;
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    return Column(
      crossAxisAlignment: .start,
      children: [
        Text(
          'SALESMAN EMAIL / LOGIN ID',
          style: TextStyle(
            fontSize: 14,
            fontWeight: .bold,
            color: AppColors.textLabels,
          ),
        ),
        SizedBox(height: 8),
        // form and inside the form the email and the password text form field
        Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: .start,
            children: [
              // email Text form field
              CustomTextfield(
                controller: salemanEmailController,
                prefixIcon: Icon(Icons.email_outlined),
                hintText: 'Saleman@gmail.com',
                validator: (value){
                  if(value!.isEmpty){
                    return ' please Enter Email';
                  } else if (!value.contains('@')){
                    return 'Enter a valid Email';
                  }else {
                    return null;
                  }
                },
              ),
              SizedBox(height: 14),
              Text(
                'Password',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: .bold,
                  color: AppColors.textLabels,
                ),
              ),
              SizedBox(height: 8),
              // Password Text Form field
              CustomTextfield(
                obscureText: !showPassword,
                controller: salemanpasswordController,
                hintText: 'Password',
                prefixIcon: Icon(Icons.lock_outline_rounded),
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      showPassword = !showPassword;
                    });
                  },
                  icon: Icon(
                    showPassword
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                  ),
                ),
                validator: (value){
                  if(value!.isEmpty){
                    return 'Enter a password';
                  }else {
                    return null;
                  }
                },
              ),
            ],
          ),
        ),
        SizedBox(height: 20),
        // Sign in  custom Button
        CustomButton(title: 'Sign In',loading: loading, onTap: () async{
          if(!formKey.currentState!.validate()){
            return;
          }
          setState(() {
                loading = true;
          });
          await Future.delayed(Duration(seconds: 2));
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>NavigationScreen()));
          setState(() {
             loading =false;
          });
        }),
        SizedBox(height: 20),
        Container(
          width: .infinity,
          height: 50,
          color: Color(0xffEFF6FF),
          child: Column(
            crossAxisAlignment: .start,
            children: [
              Text(
                "Don't have an account?",
                style: TextStyle(
                  fontWeight: .bold,
                  fontSize: 11,
                  color: AppColors.primaryBlue,
                ),
              ),
              Text(
                'Ask your Factory Owner to create your account from their profile.',
                style: TextStyle(fontSize: 11, fontWeight: .w400),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
