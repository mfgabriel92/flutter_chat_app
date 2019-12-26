import 'package:flutter/material.dart';

class TextInput extends StatelessWidget {
  final TextEditingController controller;
  final Function onChanged;
  final String hintText;
  final bool isPassword;
  final double borderRadius;
  final TextInputType keyboardType;

  TextInput({
    this.controller,
    @required this.onChanged,
    this.hintText,
    this.isPassword = false,
    this.keyboardType = TextInputType.text,
    this.borderRadius = 4.0,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      controller: controller,
      obscureText: isPassword,
      keyboardType: keyboardType,
      style: TextStyle(
        color: Colors.black87,
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        hintText: hintText,
        hintStyle: TextStyle(
          color: Colors.black54,
        ),
        contentPadding: EdgeInsets.symmetric(
          vertical: 16.0,
          horizontal: 24.0,
        ),
        border: OutlineInputBorder(),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black12),
          borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black12),
          borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
        ),
      ),
    );
  }
}
