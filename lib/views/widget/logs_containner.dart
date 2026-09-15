import 'package:e_stock/core/constants/app_color.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LogsContainer extends StatelessWidget {
  final String type;
  final String product;
  final String quantity;
  final String time;

  const LogsContainer({
    super.key,
    required this.type,
    required this.product,
    required this.quantity,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(15),

      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: AppColors.inputBorder,
        ),
      ),

      child: Row(
        children: [

          // Icon
          Container(
            width: 45,
            height: 45,
            decoration: BoxDecoration(
              color: AppColors.cardBorder,
              border: Border.all(
                color: AppColors.inputBorder,
              ),
              borderRadius: BorderRadius.circular(8),
            ),

            child: Center(
              child: getIcon(type),
            ),
          ),

          const SizedBox(width: 10),

          // Log information
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text(
                  type,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: AppColors.textPrimary,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  product,
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.textLabels,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  'Quantity: $quantity',
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.textMuted,
                  ),
                ),
              ],
            ),
          ),

          Text(
            time,
            style: TextStyle(
              color: AppColors.textMuted,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget getIcon(String type) {
    print('TYPE: [$type]');

    switch (type) {
      case 'Van Sale':
        return FaIcon(FontAwesomeIcons.cartShopping);

      case 'Load Van':
        return FaIcon(FontAwesomeIcons.truck);

      case 'Production':
        return FaIcon(FontAwesomeIcons.industry);

      case 'Factory Sale':
        return FaIcon(FontAwesomeIcons.store);

      default:
        return FaIcon(FontAwesomeIcons.history);
    }
  }
}