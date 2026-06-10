import 'package:flutter/material.dart';

import '../app_theme/app_colors.dart';
class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final double height;
  final double borderRadius;
  final Widget? child;
  const AppButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.backgroundColor = const Color(0xff054239),
    this.height = 54,
    this.borderRadius = 18,
    this.child
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      width: double.infinity,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryColor,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
        child: child ?? Text(text,
          style: TextStyle(
            color: Colors.white,
            fontSize: size.width * 0.046,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}