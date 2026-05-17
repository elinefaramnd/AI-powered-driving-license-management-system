import 'package:flutter/material.dart';
import '../app_theme/app_colors.dart';

class CustomTextField2 extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData suffixIcon ;
  final bool obscureText;
  final Widget? prefixIcon;
  final TextInputType keyboardType;
  final double? hintFontSize;
  const CustomTextField2({
    super.key,
    required this.controller,
    required this.hintText,
    required this.suffixIcon,
    this.obscureText = false,
    this.prefixIcon,
    this.keyboardType = TextInputType.text,
    this.hintFontSize,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: TextFormField(
        textDirection: TextDirection.rtl,
        textAlign: TextAlign.right,
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        cursorColor: AppColors.primaryColor,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            fontSize: hintFontSize ?? 15,
          ),
          hintTextDirection: TextDirection.rtl,
          prefixIcon: prefixIcon,
          suffixIcon: Icon(suffixIcon, color: AppColors.primaryColor),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.primaryColor,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.Gray,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}