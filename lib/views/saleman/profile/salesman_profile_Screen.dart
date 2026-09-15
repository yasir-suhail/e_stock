import 'package:e_stock/core/constants/app_color.dart';
import 'package:e_stock/views/widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../view_Model/auth_viewmodel.dart';
import '../../login/login_screen.dart';

class SalesmanProfileScreen extends StatefulWidget {
  const SalesmanProfileScreen({super.key});

  @override
  State<SalesmanProfileScreen> createState() => _SalesmanProfileScreenState();
}

class _SalesmanProfileScreenState extends State<SalesmanProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    return Scaffold(
      backgroundColor: AppColors.backgroundCanvas,
      resizeToAvoidBottomInset: false,
      // appBar: AppBar(
      //   automaticallyImplyLeading: false,
      //   backgroundColor: AppColors.headerNavy,
      //   title: Column(
      //     crossAxisAlignment: .start,
      //     children: [
      //       Text(
      //         'Account Profile',
      //         style: TextStyle(
      //           fontSize: 18,
      //           fontWeight: FontWeight.bold,
      //           color: AppColors.whiteColor,
      //         ),
      //       ),
      //       SizedBox(height: 6),
      //       Text(
      //         'Active user account & role details',
      //         style: TextStyle(
      //           fontSize: 12,
      //           fontWeight: FontWeight.w400,
      //           color: AppColors.textMuted,
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: screenWidth,
              height: 180,
              decoration: BoxDecoration(color: AppColors.headerNavy),
              child: Center(
                child: Column(
                  mainAxisAlignment: .center,
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: AppColors.vanAmber,
                      child: Text(
                        'A',
                        style: TextStyle(
                          color: AppColors.whiteColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      'Ali Khan',
                      style: TextStyle(
                        fontSize: 18,
                        color: AppColors.whiteColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Senior Route Salesman',
                      style: TextStyle(
                        color: AppColors.textMuted,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              width: screenWidth - 20,
              height: 250,
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppColors.inputBorder),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 19, left: 16, right: 19),
                child: Column(
                  crossAxisAlignment: .start,
                  children: [
                    //assign vehicle
                    Text(
                      'ASSIGNED VEHICLE',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.textMuted,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Van #01 (LES-4412)',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 14),
                    Divider(color: AppColors.inputBorder),
                    SizedBox(height: 14),
                    //Assign Route
                    Text(
                      'ASSIGNED ROUTE',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.textMuted,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Main Wholesale Market / Bazar Sector B',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 14),
                    Divider(color: AppColors.inputBorder),
                    SizedBox(height: 14),
                    //Factory Account name
                    Text(
                      'FACTORY ACCOUNT',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.textMuted,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Assad Foods Factory Unit #1',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),

            GestureDetector(
              onTap: context.watch<AuthViewModel>().isLoading
                  ? null
                  : () async {
                final success =
                await context.read<AuthViewModel>().signOut();

                if (!mounted) return;

                if (success) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Signed out successfully'),
                    ),
                  );

                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    ),
                        (route) => false,
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        context.read<AuthViewModel>().errorMessage ??
                            'Failed to sign out',
                      ),
                    ),
                  );
                }
              },
              child: Container(
                width: screenWidth - 20,
                height: 46,
                decoration: BoxDecoration(
                  color: const Color(0xffFEE2E2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: context.watch<AuthViewModel>().isLoading
                      ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                    ),
                  )
                      : const Text(
                    'Log Out Account',
                    style: TextStyle(
                      color: Color(0xffDC2626),
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),          ],
        ),
      ),
    );
  }
}
