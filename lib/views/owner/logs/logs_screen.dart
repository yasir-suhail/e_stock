import 'package:e_stock/core/constants/app_color.dart';
import 'package:e_stock/views/widget/logs_button.dart';
import 'package:e_stock/views/widget/logs_containner.dart';
import 'package:flutter/material.dart';

class LogsScreen extends StatefulWidget {
  const LogsScreen({super.key});

  @override
  State<LogsScreen> createState() => _LogsScreenState();
}

class _LogsScreenState extends State<LogsScreen> {
  // remembers which type was selected
  String selectedLogType = 'All';
  // contain all data logs
  final List<Map<String, dynamic>> allLogs = [
    {
      'type': 'Production',
      'product': 'Red Chili Powder',
      'quantity': '444 Packs',
      'time': '11:00 AM',
    },
    {
      'type': 'Production',
      'product': 'Turmeric Powder',
      'quantity': '648 Packs',
      'time': '03:30 PM',
    },
    {
      'type': 'Load Van',
      'product': 'Cumin Powder',
      'quantity': '252 Packs',
      'time': '11:00 AM',
    },
    {
      'type': 'Load Van',
      'product': 'Black Pepper',
      'quantity': '660 Packs',
      'time': '05:00 PM',
    },
    {
      'type': 'Van Sale',
      'product': 'Cumin Powder',
      'quantity': '576 Packs',
      'time': '11:45 AM',
    },
    {
      'type': 'Van Sale',
      'product': 'Curry Powder',
      'quantity': '564 Packs',
      'time': '11:45 AM',
    },
    {
      'type': 'Van Sale',
      'product': 'Turmeric Powder',
      'quantity': '492 Packs',
      'time': '09:15 AM',
    },
    {
      'type': 'Production',
      'product': 'Cumin Powder',
      'quantity': '504 Packs',
      'time': '03:30 PM',
    },
    {
      'type': 'Production',
      'product': 'Garlic Powder',
      'quantity': '588 Packs',
      'time': '09:15 AM',
    },
    {
      'type': 'Production',
      'product': 'Cumin Powder',
      'quantity': '660 Packs',
      'time': '04:15 PM',
    },
  ];

  //  selected filter logs
  // contain  the data currently display
  List<Map<String, dynamic>> get displayLogs {
    if (selectedLogType == 'All') {
      return allLogs;
    }
    return allLogs.where((log) => log['type'] == selectedLogType).toList();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    return Scaffold(
      backgroundColor: AppColors.backgroundCanvas,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.headerNavy,
        title: Column(
          crossAxisAlignment: .start,
          children: [
            Text(
              'Inventory Movement Logs',
              style: TextStyle(
                fontWeight: .bold,
                fontSize: 18,
                color: AppColors.whiteColor,
              ),
            ),
            SizedBox(height: 4),
            Text(
              'Complete history across all products',
              style: TextStyle(
                fontSize: 12,
                fontWeight: .w400,
                color: AppColors.textMuted,
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(height: 20),
            SizedBox(
              height: 45,
              child: ListView(
                scrollDirection: Axis.horizontal,
                // padding: EdgeInsets.symmetric(horizontal: 16),
                children: [
                  LogsButton(
                    title: 'All',
                    onTap: () {
                      setState(() {
                        selectedLogType = 'All';
                      });
                    },
                    isSelected: selectedLogType == 'All',
                  ),
                  LogsButton(
                    title: 'Production',
                    onTap: () {
                      setState(() {
                        selectedLogType = 'Production';
                      });
                    },
                    isSelected: selectedLogType == 'Production',
                  ),
                  LogsButton(
                    title: 'Load Van',
                    onTap: () {
                      setState(() {
                        selectedLogType = 'Load Van';
                      });
                    },
                    isSelected: selectedLogType == 'Load Van',
                  ),
                  LogsButton(
                    title: 'Van Sale',
                    onTap: () {
                      setState(() {
                        selectedLogType = 'Van Sale';
                      });
                    },
                    isSelected: selectedLogType == 'Van Sale',
                  ),
                  LogsButton(
                    title: 'Factory Sale',
                    onTap: () {
                      setState(() {
                        selectedLogType = 'Factory Sale';
                      });
                    },
                    isSelected: selectedLogType == 'Factory Sale',
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: displayLogs.isEmpty
                  ? Center(
                      child: Text(
                        'NO ${selectedLogType} inventory found',
                        style: TextStyle(
                          fontSize: 16,
                          color: AppColors.textLabels,
                        ),
                      ),
                    )
                  : ListView.builder(
                      itemCount: displayLogs.length,
                      itemBuilder: (context, index) {
                        final log = displayLogs[index];
                        return LogsContainer(
                          type: log['type'],
                          // type: displayLogs[index]['type'],
                          product: log['product'],
                          quantity: log['quantity'],
                          time: log['time'],
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
