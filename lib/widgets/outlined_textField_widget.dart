import 'package:flutter/material.dart';
import '../app_theme/app_colors.dart';

class CustomTextField2 extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData suffixIcon;
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
    final isRtl = Directionality.of(context) == TextDirection.rtl;
    final size = MediaQuery.of(context).size;
    final w = size.width;
    final h = size.height;
    return SizedBox(
      width: double.infinity,
      height: h * 0.062,
      child: TextFormField(
        textDirection: Directionality.of(context),
        textAlign: TextAlign.start,
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        cursorColor: AppColors.primaryColor,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(fontSize: hintFontSize ?? w * 0.038,),
          hintTextDirection: Directionality.of(context),
          prefixIcon: isRtl
              ? Icon(
            suffixIcon,
            color: AppColors.primaryColor,
            size: w * 0.06,
          )
              : prefixIcon,

          suffixIcon: isRtl
              ? prefixIcon
              : Icon(
            suffixIcon,
            color: AppColors.primaryColor,
            size: w * 0.06,
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.primaryColor, width: 2),
            borderRadius: BorderRadius.circular(w * 0.025),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.Gray),
            borderRadius: BorderRadius.circular(w * 0.025),
          ),
        ),
      ),
    );
  }
}
