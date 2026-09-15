import 'package:flutter/material.dart';

import '../../core/constants/app_color.dart';

class BottomNavItem {
  final Widget Function(Color color) icon;
  final String label;

  const BottomNavItem({
    required this.icon,
    required this.label,
  });
}

class CustomBottomNav extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemSelected;
  final List<BottomNavItem> items;

  final Color selectedColor;
  final Color unselectedColor;

  const CustomBottomNav({
    required this.selectedIndex,
    required this.onItemSelected,
    required this.items,
    this.selectedColor = AppColors.primaryBlue,
    this.unselectedColor = AppColors.textMuted,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        width: double.infinity,
        height: 75,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: AppColors.inputBorder,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(
            items.length,
                (index) {
              final item = items[index];

              final Color color = selectedIndex == index
                  ? selectedColor
                  : unselectedColor;

              return Column(
                children: [
                  IconButton(
                    onPressed: () {
                      onItemSelected(index);
                    },
                    icon: item.icon(color),
                  ),

                  Text(
                    item.label,
                    style: TextStyle(
                      color: color,
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