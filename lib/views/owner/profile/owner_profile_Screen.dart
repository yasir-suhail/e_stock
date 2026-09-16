// import 'package:e_stock/core/constants/app_color.dart';
// import 'package:e_stock/views/owner/profile/add_saleman_Screen.dart';
// import 'package:e_stock/views/widget/custom_button.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'package:provider/provider.dart';
//
// import '../../../view_Model/auth_viewmodel.dart';
// import '../../login/login_screen.dart';
//
// class OwnerProfileScreen extends StatefulWidget {
//   const OwnerProfileScreen({super.key});
//
//   @override
//   State<OwnerProfileScreen> createState() => _OwnerProfileScreenState();
// }
//
// class _OwnerProfileScreenState extends State<OwnerProfileScreen> {
//   FirebaseAuth auth = FirebaseAuth.instance;
//   final DatabaseReference ownerUsers = FirebaseDatabase.instance.ref('owner');
//
//   Future<Map<String, dynamic>?> getCurrentUser() async {
//     try {
//       final User? user = auth.currentUser;
//       if (user == null) {
//         return null;
//       }
//       final String uid = user.uid;
//       final DataSnapshot snapshot = await ownerUsers.child(uid).get();
//       if (snapshot.exists) {
//         final data = Map<dynamic, dynamic>.from(snapshot.value as Map);
//         return {
//           'uid': uid,
//           'name': data['name'].toString(),
//           'email': data['email'].toString(),
//           'phone': data['phone'].toString(),
//           'factoryName':data['factoryName'].toString(),
//         };
//       }
//     } catch (e) {}
//     return null;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     double screenWidth = MediaQuery.sizeOf(context).width;
//     return Scaffold(
//       backgroundColor: AppColors.backgroundCanvas,
//       appBar: AppBar(
//         backgroundColor: AppColors.headerNavy,
//         automaticallyImplyLeading: false,
//         title: Column(
//           crossAxisAlignment: .start,
//           children: [
//             Text(
//               'Account Profile',
//               style: TextStyle(
//                 color: Colors.white,
//                 fontWeight: .bold,
//                 fontSize: 18,
//               ),
//             ),
//             SizedBox(height: 6),
//             Text(
//               'Active user account & role details',
//               style: TextStyle(
//                 color: AppColors.textMuted,
//                 fontSize: 12,
//                 fontWeight: .w400,
//               ),
//             ),
//           ],
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 20),
//           child:
//           FutureBuilder<Map<String, dynamic>?>(
//             future: getCurrentUser(),
//             builder: (context, snapshot) {
//               //loading
//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 return const Center(child: CircularProgressIndicator());
//               }
//               // if some error then show
//               if (snapshot.hasError) {
//                 return Center(child: Text('Error: ${snapshot.error}'));
//               }
//               // if there is not data
//               if (snapshot.data == null) {
//                 return const Center(child: Text('No user data found'));
//               }
//               // data received
//               final data = snapshot.data;
//               return  Column(
//                 children: [
//                   SizedBox(height: 20),
//                   Container(
//                     height: 150,
//                     width: screenWidth - 32,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(10),
//                       border: Border.all(color: AppColors.inputBorder),
//                       color: Colors.white,
//                     ),
//                     child: Padding(
//                       padding: const EdgeInsets.only(top: 30, left: 20),
//                       child: Row(
//                         crossAxisAlignment: .start,
//                         children: [
//                           //circle avatar containner
//                           Container(
//                             width: 90,
//                             height: 90,
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(90),
//                               border: Border.all(
//                                 color: AppColors.primaryBlue,
//                                 width: 2,
//                               ),
//                             ),
//                             child: Center(
//                               //circle avatar
//                               child: CircleAvatar(
//                                 radius: 50,
//                                 backgroundColor: Color(0xffEFF6FF),
//                                 // child: Text('name: ${data?['name']}'),
//                                 child: Text(
//                                   '${data?['name']}',
//                                   style: TextStyle(
//                                     color: AppColors.primaryBlue,
//                                     fontSize: 14,
//                                     fontWeight: .bold,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                           SizedBox(width: 20),
//                           // owner  profile data
//                           Column(
//                             crossAxisAlignment: .start,
//                             children: [
//                               SizedBox(height: 10),
//                               Text(
//                                 '${data?['name']}',
//                                 style: TextStyle(
//                                   fontWeight: .bold,
//                                   fontSize: 16,
//                                   color: AppColors.textPrimary,
//                                 ),
//                               ),
//                               SizedBox(height: 5),
//                               Text(
//                                 '${data?['email']}',
//                                 style: TextStyle(
//                                   fontWeight: .w400,
//                                   color: AppColors.textMuted,
//                                   fontSize: 12,
//                                 ),
//                               ),
//                               SizedBox(height: 5),
//                               // Text('Factory Name',style: TextStyle(fontWeight: .w400,color: AppColors.textMuted,fontSize: 12 )),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 20),
//                   // Factory detail + add salesman + logout
//                   Container(
//                     width: screenWidth - 32,
//                     height: 250,
//                     decoration: BoxDecoration(
//                       border: Border.all(color: AppColors.inputBorder),
//                       borderRadius: BorderRadius.circular(10),
//                       color: Colors.white,
//                     ),
//                     child: Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 16),
//                       child: Column(
//                         crossAxisAlignment: .start,
//                         children: [
//                           SizedBox(height: 13),
//                           Text(
//                             'FACTORY NAME',
//                             style: TextStyle(
//                               color: AppColors.textLabels,
//                               fontWeight: .bold,
//                               fontSize: 11,
//                             ),
//                           ),
//                           SizedBox(height: 4),
//                           Text(
//                             '${data?['factoryName']}',
//                             style: TextStyle(
//                               fontSize: 14,
//                               fontWeight: .bold,
//                               color: AppColors.textPrimary,
//                             ),
//                           ),
//                           SizedBox(height: 15),
//                           Divider(color: AppColors.inputBorder),
//                           SizedBox(height: 15),
//                           // add salesman button
//                           CustomButton(
//                             title: '+ Add Salesman Account',
//                             borderColor: AppColors.inputBorder,
//                             textColor: AppColors.primaryBlue,
//                             backgroundColor: AppColors.backgroundCanvas,
//                             onTap: () {
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (context) => AddSalesmanScreen(),
//                                 ),
//                               );
//                             },
//                           ),
//                           SizedBox(height: 30),
//                           // log out Button
//                           CustomButton(
//                             title: 'Sign Out',
//                             loading: context.watch<AuthViewModel>().isLoading,
//                             backgroundColor: AppColors.headerNavy,
//                             onTap: () async {
//                               final success = await context
//                                   .read<AuthViewModel>()
//                                   .signOut();
//
//                               if (!mounted) return;
//
//                               if (success) {
//                                 ScaffoldMessenger.of(context).showSnackBar(
//                                   const SnackBar(
//                                     content: Text('Signed out successfully'),
//                                   ),
//                                 );
//
//                                 Navigator.pushAndRemoveUntil(
//                                   context,
//                                   MaterialPageRoute(
//                                     builder: (context) => const LoginScreen(),
//                                   ),
//                                       (route) => false,
//                                 );
//                               } else {
//                                 ScaffoldMessenger.of(context).showSnackBar(
//                                   SnackBar(
//                                     content: Text(
//                                       context.read<AuthViewModel>().errorMessage ??
//                                           'Failed to sign out',
//                                     ),
//                                   ),
//                                 );
//                               }
//                             },
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }
//
//
//
import 'package:e_stock/core/constants/app_color.dart';
import 'package:e_stock/view_Model/profile_viewmodel.dart';
import 'package:e_stock/views/owner/profile/add_saleman_Screen.dart';
import 'package:e_stock/views/widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../view_Model/auth_viewmodel.dart';
import '../../login/login_screen.dart';

class OwnerProfileScreen extends StatefulWidget {
  const OwnerProfileScreen({super.key});

  @override
  State<OwnerProfileScreen> createState() => _OwnerProfileScreenState();
}

class _OwnerProfileScreenState extends State<OwnerProfileScreen> {
  @override
  void initState() {
    super.initState();

    // Load owner data after the screen is created
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProfileViewmodel>().loadOwnerData();
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.sizeOf(context).width;

    return Scaffold(
      backgroundColor: AppColors.backgroundCanvas,

      appBar: AppBar(
        backgroundColor: AppColors.headerNavy,
        automaticallyImplyLeading: false,

        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Account Profile',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),

            SizedBox(height: 6),

            Text(
              'Active user account & role details',
              style: TextStyle(
                color: AppColors.textMuted,
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),

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
              if (profileViewModel.owner == null) {
                return const Center(child: Text('No user data found'));
              }

              // OWNER DATA
              final owner = profileViewModel.owner!;

              return Column(
                children: [
                  SizedBox(height: 20),

                  // PROFILE CONTAINER
                  Container(
                    height: 150,
                    width: screenWidth - 32,

                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: AppColors.inputBorder),
                      color: Colors.white,
                    ),

                    child: Padding(
                      padding: const EdgeInsets.only(top: 30, left: 20),

                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [
                          // PROFILE AVATAR
                          Container(
                            width: 90,
                            height: 90,

                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(90),

                              border: Border.all(
                                color: AppColors.primaryBlue,
                                width: 2,
                              ),
                            ),

                            child: Center(
                              child: CircleAvatar(
                                radius: 50,

                                backgroundColor: const Color(0xffEFF6FF),

                                child: Text(
                                  owner.name,

                                  style: TextStyle(
                                    color: AppColors.primaryBlue,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),

                          SizedBox(width: 20),

                          // OWNER INFORMATION
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,

                            children: [
                              SizedBox(height: 10),

                              Text(
                                owner.name,

                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: AppColors.textPrimary,
                                ),
                              ),

                              SizedBox(height: 5),

                              Text(
                                owner.email,

                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.textMuted,
                                  fontSize: 12,
                                ),
                              ),

                              SizedBox(height: 5),

                              Text(
                                owner.phone,

                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.textMuted,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: 20),

                  // FACTORY CONTAINER
                  Container(
                    width: screenWidth - 32,
                    height: 250,

                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.inputBorder),
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),

                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),

                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [
                          SizedBox(height: 13),

                          Text(
                            'FACTORY NAME',

                            style: TextStyle(
                              color: AppColors.textLabels,
                              fontWeight: FontWeight.bold,
                              fontSize: 11,
                            ),
                          ),

                          SizedBox(height: 4),

                          Text(
                            owner.factoryName ?? 'No factory name',

                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textPrimary,
                            ),
                          ),

                          SizedBox(height: 15),

                          Divider(color: AppColors.inputBorder),

                          SizedBox(height: 15),

                          // ADD SALESMAN
                          CustomButton(
                            title: '+ Add Salesman Account',

                            borderColor: AppColors.inputBorder,

                            textColor: AppColors.primaryBlue,

                            backgroundColor: AppColors.backgroundCanvas,

                            onTap: () {
                              Navigator.push(
                                context,

                                MaterialPageRoute(
                                  builder: (context) => AddSalesmanScreen(),
                                ),
                              );
                            },
                          ),

                          SizedBox(height: 30),

                          // SIGN OUT
                          Consumer<AuthViewModel>(
                            builder: (context, authViewModel, child) {
                              return CustomButton(
                                title: 'Sign Out',

                                // IMPORTANT:
                                // Sign out belongs to AuthViewModel,
                                // so use authViewModel.isLoading.
                                loading: authViewModel.isLoading,

                                backgroundColor: AppColors.headerNavy,

                                onTap: () async {
                                  final success = await authViewModel.signOut();

                                  if (!mounted) return;

                                  if (success) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                          'Signed out successfully',
                                        ),
                                      ),
                                    );

                                    Navigator.pushAndRemoveUntil(
                                      context,

                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const LoginScreen(),
                                      ),

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
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
