import 'package:e_stock/core/constants/app_color.dart';
import 'package:e_stock/views/login_screen/login_screen.dart';
import 'package:e_stock/views/widget/custom_Textfield.dart';
import 'package:e_stock/views/widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  // /Form
  final formKey = GlobalKey<FormState>();

  // controllers
  var fullNameController = TextEditingController();
  var factoryNameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var passwordController = TextEditingController();
  // boolean operation for show and hide password
  bool showPassword = false;
  //  boolean for the circular progress indicator
  bool loading= false;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.sizeOf(context).width;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.backgroundCanvas,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // the top container of owner registration
            Container(
              width: screenWidth,
              height: 100,
              color: AppColors.headerNavy,
              child: Padding(
                padding: const EdgeInsets.only(top: 34, left: 24),
                child: Column(
                  crossAxisAlignment: .start,
                  children: [
                    Text(
                      'Owner Registration',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: .bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      'Register main warehouse & factory account',
                      style: TextStyle(
                        color: AppColors.textMuted,
                        fontSize: 12,
                        fontWeight: .w400,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            // the whole big containner
            Container(
              width: screenWidth - 32,
              height: 650,
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.inputBorder),
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                //inside the whole containner
                child: Column(
                  crossAxisAlignment: .start,
                  children: [
                    SizedBox(height: 15),
                    Container(
                      height: 22,
                      // width: screenWidth-300,
                      width: 150,
                      decoration: BoxDecoration(
                        color: Color(0xffEFF6FF),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Center(
                        child: Text(
                          'CREATE OWNER ACCOUNT',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: .bold,
                            color: AppColors.primaryBlue,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    // the form of the text form field
                    Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: .start,
                        spacing: 8,
                        children: [
                          // full name
                          Text(
                            'FULL NAME',
                            style: TextStyle(
                              fontWeight: .bold,
                              fontSize: 11,
                              color: AppColors.textLabels,
                            ),
                          ),
                          // Full name text form field
                      CustomTextfield(
                            controller: fullNameController,
                            hintText: ' Full name',
                            validator: (value){
                              if(value!.isEmpty){
                                return ' please Enter a full name ';
                              }
                            },
                          ),
                          // Factory name
                          Text(
                            'FACTORY / MILL NAME',
                            style: TextStyle(
                              fontWeight: .bold,
                              fontSize: 11,
                              color: AppColors.textLabels,
                            ),
                          ),
                          // Factory  text form field
                          CustomTextfield(
                            controller: factoryNameController,
                            hintText: 'Factory name ',
                            validator: (value){
                              if(value!.isEmpty){
                                return ' please Enter a factory name ';
                              }
                            },
                          ),
                          // Email name
                          Text(
                            'OWNER EMAIL ADDRESS',
                            style: TextStyle(
                              fontWeight: .bold,
                              fontSize: 11,
                              color: AppColors.textLabels,
                            ),
                          ),
                          // Email text form field
                          CustomTextfield(
                            controller: emailController,
                            keyboardtype: .emailAddress,
                            prefixIcon: Icon(Icons.email_outlined),
                            hintText: 'Enter a valid email',
                            validator:
                                (value){
                              if(value!.isEmpty){
                                return 'please Enter email';
                              } else if(!value.contains('@')){
                                return 'Enter a valid email';
                              }
                            },
                          ),
                          // Phone number
                          Text(
                            'PHONE NUMBER',
                            style: TextStyle(
                              fontWeight: .bold,
                              fontSize: 11,
                              color: AppColors.textLabels,
                            ),
                          ),
                      // phone number text form field
                          CustomTextfield(
                            keyboardtype: .phone,
                            controller: phoneController,
                            hintText: 'Phone number',
                            validator: (value){
                              if(value!.isEmpty){
                                return ' Enter a phone number';
                              }
                            },
                          ),
                          // password
                          Text(
                            'CREATE PASSWORD',
                            style: TextStyle(
                              fontWeight: .bold,
                              fontSize: 11,
                              color: AppColors.textLabels,
                            ),
                          ),
                          // password text form field
                          CustomTextfield(
                            obscureText: showPassword,
                            controller: passwordController,
                            prefixIcon: Icon(Icons.lock_outline_rounded),
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  showPassword =!showPassword;
                                });
                              },
                              icon: Icon(
                                showPassword
                                    ? Icons.visibility_outlined
                                    : Icons.visibility_off_outlined,
                              ),
                            ),
                            hintText: 'Create a strong password ',
                            validator: (value){
                              if(value!.isEmpty){
                                return 'please Enter password';
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 25,),
                    CustomButton(
                        title: 'Register Owner Account', loading: loading, onTap: () async{

                          if(!formKey.currentState!.validate()){
                            return ;
                          }
                          setState(() {
                            loading = true;
                          });
                          await Future.delayed(Duration(seconds: 2));
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Register Successfully')));
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
                    }
                    ),
                    SizedBox(height: 19,),
                    Row(
                      mainAxisAlignment: .center,
                      children: [
                        Text('Already registered?'),
                        SizedBox(width: 5,),
                        Text('Sign In Here')
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
