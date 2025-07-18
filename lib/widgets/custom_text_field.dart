import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData icon;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;

  const CustomTextFormField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.icon,
    required this.keyboardType,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      textInputAction: TextInputAction.next,
      validator: validator,
      style: const TextStyle(color: Color(0xFF263238), fontSize: 15),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        hintText: hintText,
        hintStyle: const TextStyle(
          color: Color(0xFF78909C),
          fontStyle: FontStyle.italic,
        ),
        prefixIcon: Icon(icon, color: Color(0xFF3F51B5)),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 14,
          horizontal: 14,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Color(0xFFCFD8DC)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Color(0xFF3F51B5), width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Color(0xFFD32F2F), width: 1.1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Color(0xFFD32F2F), width: 2),
        ),
      ),
    );
  }
}
