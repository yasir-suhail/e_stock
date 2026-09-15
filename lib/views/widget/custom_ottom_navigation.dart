import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../core/constants/app_color.dart';

// class BottomNavItem {
//   final IconData icon;
//   final String label;
//
//   BottomNavItem({required this.label, required this.icon});
// }

class CustomBottomNavigation extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemSelected;
  const CustomBottomNavigation({
    required this.selectedIndex,
    required this.onItemSelected,
    super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        width: 362,
        height: 75,
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: AppColors.inputBorder,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                IconButton(
                  onPressed: () {
                    onItemSelected(0);
                  },

                  icon: Icon(
                    Icons.home,
                    color: selectedIndex == 0
                        ? AppColors.primaryBlue
                        : AppColors.textMuted,
                  ),
                ),
                Text(
                  'Home',
                  style: TextStyle(
                    color: selectedIndex == 0
                        ? AppColors.primaryBlue
                        : AppColors.textMuted,
                  ),
                ),
              ],
            ),

            Column(
              children: [
                IconButton(
                  onPressed: () {
                    onItemSelected(1);
                  },
                  icon: Icon(
                    Icons.history,
                    color: selectedIndex == 1
                        ? AppColors.primaryBlue
                        : AppColors.textMuted,
                  ),
                ),
                Text(
                  'Logs',
                  style: TextStyle(
                    color: selectedIndex == 1
                        ? AppColors.primaryBlue
                        : AppColors.textMuted,
                  ),
                ),
              ],
            ),

            Column(
              children: [
                IconButton(
                  onPressed: () {
                    onItemSelected(2);
                  },
                  icon: Icon(
                    Icons.shopping_cart,
                    color: selectedIndex == 2
                        ? AppColors.primaryBlue
                        : AppColors.textMuted,
                  ),
                ),
                Text(
                  'Products',
                  style: TextStyle(
                    color: selectedIndex == 2
                        ? AppColors.primaryBlue
                        : AppColors.textMuted,
                  ),
                ),
              ],
            ),
            Column(
              children: [
                IconButton(
                  onPressed: () {
                    onItemSelected(3);
                  },
                  icon: Icon(
                    Icons.person,
                    color: selectedIndex == 3
                        ? AppColors.primaryBlue
                        : AppColors.textMuted,
                  ),
                ),
                Text(
                  'Profile',
                  style: TextStyle(
                    color: selectedIndex == 3
                        ? AppColors.primaryBlue
                        : AppColors.textMuted,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
