import 'package:flutter/material.dart';

class FormFiledWidget extends StatelessWidget {
  final String hintText;
  final Widget icon;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final bool obscureText;
  final double vertical;
  const FormFiledWidget({
    super.key,
    required this.hintText,
    required this.icon,
    this.controller,
    this.validator,
    this.keyboardType,
    this.obscureText = false,
    this.vertical = 10,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: vertical),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscureText,
        validator: validator,
        cursorColor: Colors.black,
        decoration: InputDecoration(
          hintText: hintText,
          prefixIcon: icon,
          filled: true,
          fillColor: Colors.blue,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.blue),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.black),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.red),
          ),
        ),
      ),
    );
  }
}
