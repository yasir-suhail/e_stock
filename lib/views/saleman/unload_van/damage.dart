// import 'package:e_stock/core/constants/app_color.dart';
// import 'package:e_stock/views/saleman/salesman_unload_van_screen.dart';
// import 'package:flutter/material.dart';
//
// class DamageReportBottomSheet extends StatefulWidget {
//   final List<UnloadItem> items;
//
//   const DamageReportBottomSheet({    required this.items,
//   super.key});
//
//   @override
//   State<DamageReportBottomSheet> createState() =>
//       _DamageReportBottomSheetState();
// }
//
// class _DamageReportBottomSheetState
//     extends State<DamageReportBottomSheet> {
//
//   bool isSelectAll = false;
//
//   // Calculate total damaged packs
//   int get totalDamage {
//     return widget.items.fold(
//       0,
//           (total, item) => total + item.damageQuantity,
//     );
//   }
//
//   // Select / unselect all products
//   void _toggleSelectAll(bool? value) {
//     setState(() {
//       isSelectAll = value ?? false;
//
//       for (var item in widget.items) {
//         item.isDamageSelected = isSelectAll;
//
//         if (!isSelectAll) {
//           item.damageQuantity = 0;
//         }
//       }
//     });
//   }
//
//   // Select / unselect one product
//   void _toggleItem(UnloadItem item, bool? value) {
//     setState(() {
//       item.isDamageSelected = value ?? false;
//
//       if (!item.isDamageSelected) {
//         item.damageQuantity = 0;
//       }
//
//       isSelectAll = widget.items.every(
//             (item) => item.isDamageSelected,
//       );
//     });
//   }
//
//   // Decrease damage quantity
//   void _decreaseDamage(UnloadItem item) {
//     setState(() {
//       if (item.damageQuantity > 0) {
//         item.damageQuantity--;
//       }
//     });
//   }
//
//   // Increase damage quantity
//   void _increaseDamage(UnloadItem item) {
//     setState(() {
//       // Only selected damaged products can have quantity
//       if (!item.isDamageSelected) {
//         return;
//       }
//
//       // Cannot exceed available van stock
//       if (item.damageQuantity < item.vanStock) {
//         item.damageQuantity++;
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Container(
//         height: MediaQuery.sizeOf(context).height * 0.75,
//         padding: const EdgeInsets.all(20),
//         decoration: BoxDecoration(
//           color: AppColors.headerNavy,
//           borderRadius: const BorderRadius.vertical(
//             top: Radius.circular(24),
//           ),
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Top handle
//             Center(
//               child: Container(
//                 width: 48,
//                 height: 4,
//                 decoration: BoxDecoration(
//                   color: const Color(0xFF475569),
//                   borderRadius: BorderRadius.circular(2),
//                 ),
//               ),
//             ),
//
//             const SizedBox(height: 16),
//
//             // Title
//             const Text(
//               'Report Damaged / Leaked Items',
//               style: TextStyle(
//                 color: Colors.white,
//                 fontSize: 16,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//
//             const SizedBox(height: 4),
//
//             // Subtitle
//             const Text(
//               'Select damaged items and enter spoiled quantities',
//               style: TextStyle(
//                 color: Color(0xFF94A3B8),
//                 fontSize: 11,
//               ),
//             ),
//
//             const SizedBox(height: 16),
//
//             // Select all
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 const Text(
//                   'Select Damaged Items',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 12,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//
//                 Row(
//                   children: [
//                     const Text(
//                       'Select All',
//                       style: TextStyle(
//                         color: Color(0xFF94A3B8),
//                         fontSize: 11,
//                       ),
//                     ),
//                     Checkbox(
//                       value: isSelectAll,
//                       onChanged: _toggleSelectAll,
//                       activeColor: AppColors.vanAmber,
//                       checkColor: AppColors.textPrimary,
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//
//             const SizedBox(height: 8),
//
//             // ONLY THIS PART SCROLLS
//             Expanded(
//               child: ListView.builder(
//                 itemCount: widget.items.length,
//                 itemBuilder: (context, index) {
//                   final item = widget.items[index];
//                   return Container(
//                     margin: const EdgeInsets.only(bottom: 12),
//                     padding: const EdgeInsets.all(10),
//                     decoration: BoxDecoration(
//                       color: const Color(0xFF111827),
//                       border: Border.all(
//                         color: const Color(0xFF374151),
//                         width: 1.5,
//                       ),
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                     child: Row(
//                       children: [
//                         // Product checkbox
//                         Checkbox(
//                           value: item.isDamageSelected,
//                           onChanged: (value) {
//                             _toggleItem(item, value);
//                           },
//                           activeColor: AppColors.vanAmber,
//                           checkColor: AppColors.textPrimary,
//                         ),
//
//                         // Product information
//                         Expanded(
//                           child: Column(
//                             crossAxisAlignment:
//                             CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 item.name,
//                                 style: const TextStyle(
//                                   color: Colors.white,
//                                   fontSize: 12,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                               const SizedBox(height: 4),
//                               Text(
//                                 'Available Van Stock: ${item.vanStock} Packs',
//                                 style: const TextStyle(
//                                   color: Color(0xFF94A3B8),
//                                   fontSize: 11,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//
//                         // Damage quantity
//                         Container(
//                           padding: const EdgeInsets.symmetric(
//                             horizontal: 8,
//                             vertical: 4,
//                           ),
//                           decoration: BoxDecoration(
//                             color: const Color(0xFF1C2541),
//                             borderRadius: BorderRadius.circular(6),
//                           ),
//                           child: Row(
//                             children: [
//                               // Minus
//                               InkWell(
//                                 onTap: () {
//                                   _decreaseDamage(item);
//                                 },
//                                 child: const Text(
//                                   '-',
//                                   style: TextStyle(
//                                     color: Color(0xFF94A3B8),
//                                     fontSize: 18,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                               ),
//
//                               // Quantity
//                               Padding(
//                                 padding:
//                                 const EdgeInsets.symmetric(
//                                   horizontal: 10,
//                                 ),
//                                 child: Text(
//                                   '${item.damageQuantity}',
//                                   style: TextStyle(
//                                     color: AppColors.vanAmber,
//                                     fontSize: 12,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                               ),
//
//                               // Plus
//                               InkWell(
//                                 onTap: () {
//                                   _increaseDamage(item);
//                                 },
//                                 child: Text(
//                                   '+',
//                                   style: TextStyle(
//                                     color: AppColors.vanAmber,
//                                     fontSize: 18,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   );
//                 },
//               ),
//             ),
//
//             const SizedBox(height: 12),
//
//             // Photo button
//             Container(
//               width: double.infinity,
//               padding: const EdgeInsets.symmetric(
//                 vertical: 12,
//               ),
//               decoration: BoxDecoration(
//                 color: const Color(0xFF111827),
//                 border: Border.all(
//                   color: const Color(0xFF374151),
//                 ),
//                 borderRadius: BorderRadius.circular(6),
//               ),
//               child: const Text(
//                 '+ Attach Damage Proof Photo (Optional)',
//                 textAlign: TextAlign.center,
//                 style: TextStyle(
//                   color: Color(0xFF38BDF8),
//                   fontSize: 11,
//                 ),
//               ),
//             ),
//
//             const SizedBox(height: 12),
//
//             // Confirm button
//             SizedBox(
//               width: double.infinity,
//               height: 48,
//               child: ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: AppColors.vanAmber,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                 ),
//                 onPressed: () {
//                   if (totalDamage == 0) {
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       const SnackBar(
//                         content: Text(
//                           'Please select damaged quantity first.',
//                         ),
//                       ),
//                     );
//                     return;
//                   }
//
//                   Navigator.pop(context, totalDamage);
//                 },
//                 child: Text(
//                   'Confirm & Apply Damage Report ($totalDamage Packs)',
//                   style: TextStyle(
//                     color: AppColors.textPrimary,
//                     fontSize: 13,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }