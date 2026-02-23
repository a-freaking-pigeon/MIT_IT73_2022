import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {
  final String label;
  final bool isPassword;
  final TextEditingController controller;
  final bool enabled;

  const CustomInput({
    super.key,
    required this.label,
    this.isPassword = false,
    required this.controller, 
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      enabled: enabled,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
    );
  }
}

