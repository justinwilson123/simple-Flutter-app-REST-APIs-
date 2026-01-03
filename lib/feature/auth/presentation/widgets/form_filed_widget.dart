import 'package:flutter/material.dart';

class FormFiledWidget extends StatelessWidget {
  final String hintText;
  final Widget icon;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  const FormFiledWidget({
    super.key,
    required this.hintText,
    required this.icon,
    this.controller,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.blue,
      ),
      margin: const EdgeInsets.symmetric(vertical: 20),
      child: TextFormField(
        controller: controller,
        validator: validator,
        cursorColor: Colors.black,
        decoration: InputDecoration(
          hintText: hintText,
          // icon: icon,
          prefixIcon: icon,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.blue),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.black),
          ),
        ),
      ),
    );
  }
}
