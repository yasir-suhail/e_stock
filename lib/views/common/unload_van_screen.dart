import 'package:flutter/material.dart';

class UnloadVanScreen extends StatefulWidget {
  final VoidCallback onBack;
  const UnloadVanScreen({
    required this.onBack,
    super.key});

  @override
  State<UnloadVanScreen> createState() => _UnloadVanScreenState();
}

class _UnloadVanScreenState extends State<UnloadVanScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
