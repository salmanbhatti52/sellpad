import 'package:flutter/material.dart';

import '../Constants/Colors.dart';

class TextFormFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType textInputType;
  final TextStyle enterTextStyle;
  final Color cursorColor;
  final String hintText;
  VoidCallback? onTap;
  final InputBorder border;
  final TextStyle hintStyle;
  final InputBorder focusedBorder;

  final InputBorder enableBorder;
  final Widget prefixIcon;
  String? autofillHints;
  final String? Function(String? value)? validator;
  String? Function(String? value)? onSaved;
  bool? obscureText;
  final Widget? suffixIcon;
  bool? readOnly;

  TextFormFieldWidget({
    super.key,
    required this.controller,
    required this.textInputType,
    required this.enterTextStyle,
    this.readOnly,
    required this.cursorColor,
    required this.hintText,
    required this.border,
    required this.hintStyle,
    required this.focusedBorder,
    this.onSaved,
    this.validator,
    this.onTap,
    this.autofillHints,
    required this.obscureText,
    this.suffixIcon,
    required this.enableBorder,
    required this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onSaved: onSaved,
      onTap: onTap,
      readOnly: readOnly ?? false,
      validator: validator,
      // inputFormatters: [
      //   LengthLimitingTextInputFormatter(
      //     widget.length,
      //   ),
      // ],
      keyboardType: textInputType,
      controller: controller,
      style: enterTextStyle,
      cursorColor: cursorColor,
      obscureText: obscureText ?? false,
      autofillHints: [autofillHints ?? ''],
      decoration: InputDecoration(
        filled: true,
        fillColor: white,
        suffixIcon: suffixIcon,
        // contentPadding: contentPadding,
        border: border,
        hintText: hintText,
        hintStyle: hintStyle,
        focusedBorder: focusedBorder,
        enabledBorder: enableBorder,
        prefixIcon: prefixIcon,
      ),
    );
  }
}
