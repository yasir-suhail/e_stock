import 'package:flutter/material.dart';

class FactorySaleScreen extends StatefulWidget {
  final VoidCallback onBack;
  const FactorySaleScreen({ required this.onBack ,super.key});

  @override
  State<FactorySaleScreen> createState() => _FactorySaleScreenState();
}

class _FactorySaleScreenState extends State<FactorySaleScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
