import 'package:e_stock/core/constants/app_color.dart';
import 'package:e_stock/views/owner/navigation_screen.dart';
import 'package:e_stock/views/owner/owner_dashboard_screen.dart';
import 'package:e_stock/views/owner/signup_screen.dart';
import 'package:e_stock/views/widget/custom_Textfield.dart';
import 'package:e_stock/views/widget/custom_button.dart';
import 'package:flutter/material.dart';

class OwnerForm extends StatefulWidget {
  OwnerForm({super.key});

  @override
  State<OwnerForm> createState() => _OwnerFormState();
}

class _OwnerFormState extends State<OwnerForm> {
  // email controller
  var ownerEmailController = TextEditingController();

  // password controller
  var ownerPasswordController = TextEditingController();

  // obscure password
  bool showPassword = false;

  // Form
  final formKey = GlobalKey<FormState>();

  bool loading = false ;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .start,
      children: [
        Container(
          height: 22,
          // width: screenWidth-300,
          width: 100,
          decoration: BoxDecoration(
            color: Color(0xffEFF6FF),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Center(
            child: Text(
              'OWNER LOGIN',
              style: TextStyle(
                fontSize: 10,
                fontWeight: .bold,
                color: AppColors.primaryBlue,
              ),
            ),
          ),
        ),
        SizedBox(height: 15,),
        Text(
          'Owner Email Address',
          style: TextStyle(
            fontSize: 14,
            fontWeight: .bold,
            color: AppColors.textLabels,
          ),
        ),
        // form and inside the form the email and the password text form field
        Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: .start,
            children: [
              SizedBox(height: 8),
              // email Text form field
              CustomTextfield(
                controller: ownerEmailController,
                keyboardtype: .emailAddress,
                hintText: 'owner@gmail.com',
                prefixIcon: Icon(Icons.email_outlined),
                validator: (value) {
                  if ( value == null||value.isEmpty) {
                    return 'please Enter Email';
                  } else if (!value.contains('@')) {
                    return ' please Enter a valid Email';
                  } else {
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
              //password Text form field
              CustomTextfield(
                obscureText: !showPassword,
                controller: ownerPasswordController,
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
                validator: (value) {
                  if ( value == null||value.isEmpty) {
                    return 'please Enter password';
                  } else {
                    return null;
                  }
                },
              ),
            ],
          ),
        ),
        SizedBox(height: 20),
        CustomButton(title: 'Sign in',loading: loading, onTap: () async{
          if(!formKey.currentState!.validate()){
            return ;
          }
          setState(() {
            loading = true;
          });
          await Future.delayed(Duration(seconds: 2));
          Navigator.push(context, MaterialPageRoute(builder: (context)=>NavigationScreen()));

          setState(() {
            loading = false ;
          });

        }),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: .center,
          children: [
            Text(
              'Dont have an account?',
              style: TextStyle(
                color: AppColors.textMuted,
                fontSize: 14,
                fontWeight: .w400,
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>SignupScreen()));
              },
              child: Text(
                'Sign up',
                style: TextStyle(
                  fontWeight: .bold,
                  color: AppColors.primaryBlue,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
