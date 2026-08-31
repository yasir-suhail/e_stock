// import 'package:flutter/material.dart';
//
// import '../constants/app_color.dart';
//
// class AppTheme {
//   static ThemeData get lightTheme {
//     return ThemeData(
//       useMaterial3: true,
//       scaffoldBackgroundColor: AppColors.backgroundCanvas,
//       primaryColor: AppColors.primaryBlue,
//       colorScheme: ColorScheme.fromSeed(
//         seedColor: AppColors.primaryBlue,
//         primary: AppColors.primaryBlue,
//         secondary: AppColors.vanAmber,
//         surface: Colors.white,
//       ),
//
//       // Global Typography Guidelines
//       textTheme: const TextTheme(
//         titleLarge: TextStyle(
//           fontSize: 18,
//           fontWeight: FontWeight.bold,
//           color: AppColors.textPrimary,
//         ),
//         titleMedium: TextStyle(
//           fontSize: 14,
//           fontWeight: FontWeight.bold,
//           color: AppColors.textPrimary,
//         ),
//         bodyMedium: TextStyle(
//           fontSize: 13,
//           fontWeight: FontWeight.normal,
//           color: AppColors.textPrimary,
//         ),
//         bodySmall: TextStyle(
//           fontSize: 12,
//           fontWeight: FontWeight.normal,
//           color: AppColors.textMuted,
//         ),
//         labelSmall: TextStyle(
//           fontSize: 11,
//           fontWeight: FontWeight.bold,
//           color: AppColors.textLabels,
//           letterSpacing: 0.5,
//         ),
//       ),
//
//       // Global Card Styling
//       cardTheme: CardThemeData(
//         color: Colors.white,
//         elevation: 0,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(8),
//           side: const BorderSide(color: AppColors.cardBorder, width: 1),
//         ),
//       ),
//
//       // Global Input Field Styling
//       inputDecorationTheme: InputDecorationTheme(
//         filled: true,
//         fillColor: Colors.white,
//         contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//         hintStyle: const TextStyle(fontSize: 13, color: AppColors.textMuted),
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(8),
//           borderSide: const BorderSide(color: AppColors.inputBorder, width: 1),
//         ),
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(8),
//           borderSide: const BorderSide(color: AppColors.inputBorder, width: 1),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(8),
//           borderSide: const BorderSide(color: AppColors.primaryBlue, width: 1.5),
//         ),
//       ),
//     );
//   }
// }