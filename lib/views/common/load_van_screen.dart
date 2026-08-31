import 'package:e_stock/core/constants/app_color.dart';
import 'package:flutter/material.dart';

class LoadVanScreen extends StatelessWidget {
  final bool isOwnerView; // true = Owner, false = Salesman

  const LoadVanScreen({super.key, required this.isOwnerView});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundCanvas,
      appBar: AppBar(
        backgroundColor: AppColors.headerNavy,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          isOwnerView ? 'Load Van (Stock Transfer)' : 'Load Stock Screen',
          style: const TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Select Product Dropdown (Common to both)
            const Text(
              'SELECT PRODUCT TO LOAD',
              style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.textLabels),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.inputBorder),
                borderRadius: BorderRadius.circular(8),
                color: Colors.white,
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  isExpanded: true,
                  value: 'Red Chili Powder 200g',
                  items: ['Red Chili Powder 200g', 'Coriander Powder 250g', 'Turmeric Powder 100g']
                      .map((product) => DropdownMenuItem(value: product, child: Text(product)))
                      .toList(),
                  onChanged: (value) {},
                ),
              ),
            ),
            const SizedBox(height: 16),

            // 2. Info Cards (Owner shows Factory vs Van balance, Salesman shows available stock)
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.cardBorder),
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('FACTORY (SOURCE)', style: TextStyle(fontSize: 10, color: AppColors.textMuted)),
                        const SizedBox(height: 4),
                        Text(isOwnerView ? '1,400 Packs' : 'Available in Factory: 1,400 Packs',
                            style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
                      ],
                    ),
                  ),
                ),
                if (isOwnerView) ...[
                  const SizedBox(width: 12),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.cardBorder),
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white,
                      ),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('VAN (TARGET)', style: TextStyle(fontSize: 10, color: AppColors.textMuted)),
                          SizedBox(height: 4),
                          Text('50 Packs', style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
                        ],
                      ),
                    ),
                  ),
                ],
              ],
            ),
            const SizedBox(height: 16),

            // 3. Transfer Quantity Field
            const Text(
              'TRANSFER QUANTITY (PACKS)',
              style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.textLabels),
            ),
            const SizedBox(height: 8),
            const TextField(
              decoration: InputDecoration(
                hintText: '50',
                border: OutlineInputBorder(),
              ),
            ),

            // 4. Owner Extra field: Assign Driver/Van Route if needed
            if (isOwnerView) ...[
              const SizedBox(height: 16),
              const Text(
                'SELECT DRIVER / VAN',
                style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.textLabels),
              ),
              const SizedBox(height: 8),
              const TextField(
                decoration: InputDecoration(
                  hintText: 'Van #01 — Toyota HiAce (LES-4412)',
                  border: OutlineInputBorder(),
                ),
              ),
            ],

            const Spacer(),

            // 5. Dynamic Action Button
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: isOwnerView ? AppColors.primaryBlue : AppColors.vanAmber,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                onPressed: () {},
                child: Text(
                  isOwnerView ? 'Execute Transfer (50 Packs)' : 'Add Stock to Van',
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}