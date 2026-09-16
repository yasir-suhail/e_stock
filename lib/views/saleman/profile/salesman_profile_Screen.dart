import 'package:e_stock/core/constants/app_color.dart';
import 'package:e_stock/views/widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../view_Model/auth_viewmodel.dart';
import '../../../view_Model/profile_viewmodel.dart';
import '../../login/login_screen.dart';

class SalesmanProfileScreen extends StatefulWidget {
  const SalesmanProfileScreen({super.key});

  @override
  State<SalesmanProfileScreen> createState() => _SalesmanProfileScreenState();
}

class _SalesmanProfileScreenState extends State<SalesmanProfileScreen> {
  @override
  void initState() {
    super.initState();

    // Load salesman data after the screen is created
    //
    // We use addPostFrameCallback so that the Provider is accessed
    // after the first frame of the screen has been created.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProfileViewmodel>().loadSalesmanData();
    });
  }

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
        // Whenever ProfileViewmodel calls notifyListeners(),
        // this part of the UI rebuilds.
        child: Consumer<ProfileViewmodel>(
          builder: (context, profileViewModel, child) {
            // LOADING
            if (profileViewModel.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            // ERROR
            if (profileViewModel.errorMessage != null) {
              return Center(child: Text(profileViewModel.errorMessage!));
            }
            // NO DATA
            if (profileViewModel.salesman == null) {
              return const Center(child: Text('No user data found'));
            }
            // SALESMAN DATA
            // Get the SalesmanModel from the ViewModel.
            // The ! means:
            // "We already checked above that salesman is not null."
            final salesman = profileViewModel.salesman!;
            return Column(
              children: [
                // SALESMAN HEADER
                Container(
                  width: screenWidth,
                  height: 180,

                  decoration: BoxDecoration(color: AppColors.headerNavy),

                  child: Center(
                    child: Column(
                      mainAxisAlignment: .center,
                      children: [
                        // SALESMAN PROFILE AVATAR
                        CircleAvatar(
                          radius: 40,
                          backgroundColor: AppColors.vanAmber,

                          child: Text(
                            // Get the first two characters
                            // from the salesman name.
                            // Example:
                            // "Ali Khan" → "AL"
                            // If name is empty, show "S".
                            salesman.name.isNotEmpty
                                ? salesman.name
                                      .substring(
                                        0,
                                        salesman.name.length >= 2 ? 2 : 1,
                                      )
                                      .toUpperCase()
                                : 'S',

                            style: TextStyle(
                              color: AppColors.whiteColor,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                        SizedBox(height: 6),
                        // SALESMAN NAME
                        Text(
                          salesman.name,
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
                // SALESMAN ACCOUNT INFORMATION
                Container(
                  width: screenWidth - 20,
                  height: 150,

                  decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: AppColors.inputBorder),
                  ),

                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 19,
                      left: 16,
                      right: 19,
                    ),

                    child: Column(
                      crossAxisAlignment: .start,

                      children: [
                        // FACTORY ACCOUNT
                        Text(
                          'FACTORY ACCOUNT',

                          style: TextStyle(
                            fontSize: 12,
                            color: AppColors.textMuted,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        SizedBox(height: 4),

                        // IMPORTANT:
                        //
                        // factoryName comes from the OWNER record.
                        //
                        // ProfileServices gets the salesman ownerId,
                        // finds that owner, gets factoryName,
                        // and puts it inside SalesmanModel.
                        //
                        // So here we can simply write:
                        //
                        // salesman.factoryName
                        Text(
                          salesman.factoryName ?? 'No factory name',

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
                // LOG OUT
                // Consumer for the logout because the logout
                // is handled by AuthViewModel.
                Consumer<AuthViewModel>(
                  builder: (context, authViewModel, child) {
                    return GestureDetector(
                      // Disable logout button while logout
                      // operation is running.
                      onTap: authViewModel.isLoading
                          ? null
                          : () async {
                              // Call logout from AuthViewModel.
                              final success = await authViewModel.signOut();

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
                                  // Remove all previous screens.
                                  (route) => false,
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      authViewModel.errorMessage ??
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
                          // Show loading indicator while
                          // AuthViewModel is signing out.
                          child: authViewModel.isLoading
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
                    );
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
