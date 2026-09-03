import 'package:e_stock/core/constants/app_color.dart';
import 'package:e_stock/views/widget/custom_Textfield.dart';
import 'package:e_stock/views/widget/custom_button.dart';
import 'package:flutter/material.dart';

import '../login_screen/login_screen.dart';

class AddSalesmanScreen extends StatefulWidget {
  const AddSalesmanScreen({super.key});

  @override
  State<AddSalesmanScreen> createState() => _AddSalesmanScreenState();
}

class _AddSalesmanScreenState extends State<AddSalesmanScreen> {
  // controller
  var addSalesmanNameController = TextEditingController();
  var addSalesmanEmailController = TextEditingController();
  var addSalesmanPasswordController = TextEditingController();

  //Form
  final formKey = GlobalKey<FormState>();

  //
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.sizeOf(context).width;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.backgroundCanvas,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.headerNavy,
        title: Column(
          crossAxisAlignment: .start,
          children: [
            Text(
              'Add New Salesman',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: .bold,
              ),
            ),
            SizedBox(height: 6),
            Text(
              'Create sales driver login for mobile van',
              style: TextStyle(
                color: AppColors.textMuted,
                fontSize: 12,
                fontWeight: .w400,
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              SizedBox(height: 20),
              // A main containner
              Container(
                width: screenWidth - 32,
                height: 600,
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.inputBorder),
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: .start,
                    children: [
                      SizedBox(height: 25),
                      Container(
                        height: 22,
                        // width: screenWidth-300,
                        width: 160,
                        decoration: BoxDecoration(
                          color: Color(0xffFEF3C7),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Center(
                          child: Text(
                            'CREATE SALESMAN ACCOUNT',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: .bold,
                              color: AppColors.vanAmber,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 19),
                      //Form
                      Form(
                        key: formKey,
                        child: Column(
                          crossAxisAlignment: .start,
                          children: [
                            Text(
                              'SALESMAN FULL NAME',
                              style: TextStyle(
                                fontWeight: .bold,
                                fontSize: 11,
                                color: AppColors.textLabels,
                              ),
                            ),
                            SizedBox(height: 9),

                            // salesman name text form
                            CustomTextfield(
                              focusedColor: AppColors.vanAmber,
                              controller: addSalesmanNameController,
                              hintText: 'Full Name',
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'please enter name';
                                }
                              },
                            ),
                            SizedBox(height: 8),
                            // email text
                            Text(
                              'LOGIN EMAIL ADDRESS',
                              style: TextStyle(
                                fontWeight: .bold,
                                fontSize: 11,
                                color: AppColors.textLabels,
                              ),
                            ),
                            SizedBox(height: 9),
                            // email text form field
                            CustomTextfield(
                              focusedColor: AppColors.vanAmber,
                              controller: addSalesmanEmailController,
                              keyboardtype: .emailAddress,
                              hintText: 'salesman@factory.com',
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'please enter name';
                                } else if (!value.contains('@')) {
                                  return 'Enter a valid email ';
                                }
                              },
                            ),
                            SizedBox(height: 8),
                            //password  text
                            Text(
                              'ASSIGN PASSWORD',
                              style: TextStyle(
                                fontWeight: .bold,
                                fontSize: 11,
                                color: AppColors.textLabels,
                              ),
                            ),
                            SizedBox(height: 9),
                            //password textform  field
                            CustomTextfield(
                              focusedColor: AppColors.vanAmber,
                              controller: addSalesmanPasswordController,
                              hintText: 'password',
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'please enter password';
                                }
                              },
                            ),
                            SizedBox(height: 25),
                            // saleman register button
                            CustomButton(
                              title: 'Create Salesman Account',
                              backgroundColor: AppColors.vanAmber,
                              loading:  loading,
                              onTap: () async {
                                if (!formKey.currentState!.validate()) {
                                  return;
                                }

                                setState(() {
                                  loading = true;
                                });

                                await Future.delayed(Duration(seconds: 2));

                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Register Successfully'),
                                  ),
                                );

                                setState(() {
                                  loading = false;
                                });
                              },
                            ),
                          ],
                        ),
                      ),

                      //salesman name text
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
