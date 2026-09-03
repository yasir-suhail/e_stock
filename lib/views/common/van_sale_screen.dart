import 'package:flutter/material.dart';

class VansaleScreen extends StatefulWidget {
   final VoidCallback onBack;
  const VansaleScreen({
    required this.onBack,
    super.key});

  @override
  State<VansaleScreen> createState() => _VansaleScreenState();
}

class _VansaleScreenState extends State<VansaleScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('data'),
      ),
    );
  }
}
