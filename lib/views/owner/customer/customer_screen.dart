// import 'package:e_stock/core/constants/app_color.dart';
// import 'package:e_stock/view_Model/customer_viewmodel.dart';
// import 'package:e_stock/views/widget/custom_Textfield.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// import '../../../model/customer_model.dart';
// import '../../widget/cusotmer_custom_card.dart';
// import 'add_customer_screen.dart';
//
// class CustomerScreen extends StatefulWidget {
//   const CustomerScreen({super.key});
//
//   @override
//   State<CustomerScreen> createState() => _CustomerScreenState();
// }
//
// class _CustomerScreenState extends State<CustomerScreen> {
//   var customerSearchController = TextEditingController();
//
//   @override
//   void initState() {
//     super.initState();
//
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       context.read<CustomerViewModel>().listenToCustomers();
//     });
//   }
//
//   @override
//   void dispose() {
//     customerSearchController.dispose();
//     super.dispose();
//   }
//   void _showDeleteDialog(
//       BuildContext context,
//       CustomerModel customer,
//       ) {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: const Text(
//             'Delete Customer',
//           ),
//
//           content: Text(
//             'Are you sure you want to delete ${customer.name}?',
//           ),
//
//           actions: [
//
//             // CANCEL
//             TextButton(
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//               child: const Text('Cancel'),
//             ),
//
//             // DELETE
//             TextButton(
//               onPressed: () async {
//                 Navigator.pop(context);
//
//                 await context
//                     .read<CustomerViewModel>()
//                     .deleteCustomer(customer.id);
//               },
//               child: const Text(
//                 'Delete',
//                 style: TextStyle(
//                   color: Colors.red,
//                 ),
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }
//   @override
//   Widget build(BuildContext context) {
//     final customerViewModel = Provider.of<CustomerViewModel>(context);
//
//     return Scaffold(
//       backgroundColor: AppColors.backgroundCanvas,
//
//       // APP BAR
//       appBar: AppBar(
//         backgroundColor: AppColors.headerNavy,
//
//         title: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//
//           children: [
//             Text(
//               'Manage Customers',
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//                 color: AppColors.whiteColor,
//               ),
//             ),
//
//             const SizedBox(height: 4),
//
//             Text(
//               'Customer Overview & Customer List',
//               style: TextStyle(
//                 color: AppColors.textMuted,
//                 fontSize: 12,
//                 fontWeight: FontWeight.w400,
//               ),
//             ),
//           ],
//         ),
//       ),
//
//       // FLOATING ACTION BUTTON
//       floatingActionButton: FloatingActionButton.extended(
//         backgroundColor: AppColors.primaryBlue,
//
//         foregroundColor: AppColors.whiteColor,
//
//         onPressed: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(builder: (context) => const AddCustomerScreen()),
//           );
//         },
//
//         label: const SizedBox(
//           width: 120,
//           height: 30,
//
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//
//             children: [
//               Icon(Icons.add),
//
//               SizedBox(width: 4),
//
//               Text('Add Customer'),
//             ],
//           ),
//         ),
//       ),
//
//       // BODY
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//
//           children: [
//             // SEARCH
//             CustomTextfield(
//               controller: customerSearchController,
//               suffixIcon: const Icon(Icons.search),
//               focusedColor: AppColors.inputBorder,
//               hintText: 'Search by customer name',
//               onChanged: (value) {
//                 customerViewModel.searchCustomers(value);
//               },
//             ),
//
//             const SizedBox(height: 20),
//
//             // CUSTOMER LIST
//             Expanded(
//               child: Consumer<CustomerViewModel>(
//                 builder: (context, customerViewModel, child) {
//                   // LOADING
//                   if (customerViewModel.isLoading) {
//                     return const Center(child: CircularProgressIndicator());
//                   }
//
//                   // ERROR
//                   if (customerViewModel.errorMessage != null) {
//                     return Center(child: Text(customerViewModel.errorMessage!));
//                   }
//
//                   // NO CUSTOMERS
//                   if (customerViewModel.displayCustomers.isEmpty) {
//                     return const Center(child: Text('No customers found'));
//                   }
//
//                   // CUSTOMER LIST
//                   return ListView.builder(
//                     itemCount: customerViewModel.displayCustomers.length,
//
//                     itemBuilder: (context, index) {
//                       final customer =
//                           customerViewModel.displayCustomers[index];
//
//                       return CustomerCustomCard(
//                       customer: customer,
//
//                       onEdit: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => AddCustomerScreen(
//                               customer: customer,
//                             ),
//                           ),
//                         );
//                       },
//
//                       onDelete: () {
//                         _showDeleteDialog(
//                           context,
//                           customer,
//                         );
//                       },
//                       );
//                     },
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:e_stock/core/constants/app_color.dart';
import 'package:e_stock/view_Model/customer_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../model/customer_model.dart';
import '../../widget/cusotmer_custom_card.dart';
import 'add_customer_screen.dart';

class CustomerScreen extends StatefulWidget {
  const CustomerScreen({super.key});

  @override
  State<CustomerScreen> createState() => _CustomerScreenState();
}

class _CustomerScreenState extends State<CustomerScreen> {
  final customerSearchController = TextEditingController();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CustomerViewModel>().listenToCustomers();
    });
  }

  @override
  void dispose() {
    customerSearchController.dispose();
    super.dispose();
  }

  // DELETE CONFIRMATION DIALOG
  void _showDeleteDialog(BuildContext context, CustomerModel customer) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete Customer'),

          content: Text('Are you sure you want to delete ${customer.name}?'),

          actions: [
            // CANCEL
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),

            // DELETE
            TextButton(
              onPressed: () async {
                Navigator.pop(context);

                await context.read<CustomerViewModel>().deleteCustomer(
                  customer.id,
                );
              },

              child: const Text('Delete', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;

    final customerViewModel = Provider.of<CustomerViewModel>(context);

    return Scaffold(
      backgroundColor: AppColors.backgroundCanvas,

      // APP BAR
      appBar: AppBar(
        backgroundColor: AppColors.headerNavy,
        automaticallyImplyLeading: false,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Customers',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 4),

            Text(
              'Manage your customers',
              style: TextStyle(color: AppColors.textMuted, fontSize: 12),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AddCustomerScreen(),
                ),
              );

              if (!mounted) return;

              if (result == 'added') {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Customer added successfully'),
                  ),
                );
              }
            },
            icon: const Icon(
              Icons.add,
              color: Colors.white,
            ),
            tooltip: 'Add Customer',
          ),

          const SizedBox(width: 5),
        ],
      ),

      // FLOATING ACTION BUTTON
      // floatingActionButton: FloatingActionButton.extended(
      //   backgroundColor: AppColors.primaryBlue,
      //   foregroundColor: AppColors.whiteColor,
      //   onPressed: () async{
      //     final result = await Navigator.push(
      //       context,
      //       MaterialPageRoute(
      //         builder: (context) => const AddCustomerScreen(),
      //       ),
      //     );
      //     if (!context.mounted) return;
      //
      //     if (result == 'added') {
      //
      //       ScaffoldMessenger.of(context).showSnackBar(
      //         const SnackBar(
      //           content: Text('Customer added successfully'),
      //         ),
      //       );
      //     }
      //   },
      //
      //   label: const SizedBox(
      //     width: 120,
      //     height: 30,
      //
      //     child: Row(
      //       mainAxisAlignment: MainAxisAlignment.center,
      //
      //       children: [
      //         Icon(Icons.add),
      //
      //         SizedBox(width: 4),
      //
      //         Text('Add Customer'),
      //       ],
      //     ),
      //   ),
      // ),

      // BODY
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            // SEARCH
            Container(
              width: screenWidth - 20,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppColors.inputBorder),
              ),
              child: TextField(
                controller: customerSearchController,
                decoration: InputDecoration(
                  hintText: 'Search customers...',
                  prefixIcon: Icon(Icons.search, color: AppColors.textMuted),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 14),
                ),
                onChanged: (value) {
                  customerViewModel.searchCustomers(value);
                },
              ),
            ),
            const SizedBox(height: 20),

            // CUSTOMER LIST TITLE
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'CUSTOMER LIST',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textLabels,
                ),
              ),
            ),
            const SizedBox(height: 10),
            // CUSTOMER LIST
            Expanded(
              child: Consumer<CustomerViewModel>(
                builder: (context, customerViewModel, child) {
                  // LOADING
                  if (customerViewModel.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  // ERROR
                  if (customerViewModel.errorMessage != null) {
                    return Center(child: Text(customerViewModel.errorMessage!));
                  }

                  // NO CUSTOMERS
                  if (customerViewModel.displayCustomers.isEmpty) {
                    return const Center(child: Text('No customers found'));
                  }

                  // CUSTOMER LIST
                  return ListView.builder(
                    itemCount: customerViewModel.displayCustomers.length,
                    itemBuilder: (context, index) {
                      final customer =
                          customerViewModel.displayCustomers[index];
                      return CustomerCustomCard(
                        customer: customer,

                        // EDIT
                        onEdit: () async {
                          final messenger = ScaffoldMessenger.of(context);
                          final result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddCustomerScreen(
                                customer: customer,
                              ),
                            ),
                          );
                          if (!mounted) return;
                          if (result == 'updated') {
                            messenger.showSnackBar(
                              const SnackBar(
                                content: Text('Customer updated successfully'),
                              ),
                            );
                          }
                        },

                        // DELETE
                        onDelete: () {
                          _showDeleteDialog(context, customer);
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
