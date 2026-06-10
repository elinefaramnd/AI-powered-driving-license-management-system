import 'package:flutter/material.dart';
import '../app_theme/app_colors.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final String hintText;
  final TextEditingController controller;
  final bool obscure;
  final IconData? icon;
  final Widget? suffixIcon;

  const CustomTextField({
    super.key,
    required this.label,
    required this.hintText,
    required this.controller,
    this.obscure = false,
    this.icon,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.only(bottom: size.height * 0.018),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: size.width * 0.04,
              fontWeight: FontWeight.w500,
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFFF1F1F1),
              borderRadius: BorderRadius.circular(size.width * 0.05),
            ),
            child: TextField(
              cursorColor: AppColors.primaryColor,
              controller: controller,
              obscureText: obscure,
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: TextStyle(
                  fontSize: size.width * 0.038,
                  color: Colors.grey,
                ),
                border: InputBorder.none,
                prefixIcon: icon != null
                    ? Icon(
                  icon,
                  color: Colors.grey[700],
                  size: size.width * 0.05,
                )
                    : null,
                suffixIcon: suffixIcon,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: size.width * 0.04,
                  vertical: size.height * 0.018,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}