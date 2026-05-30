import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../outlined_textField_widget.dart';

class SignUpTextField extends StatelessWidget {
  final String title;
  final TextEditingController controller;
  final String hintText;
  final IconData icon;
  final TextInputType? keyboardType;
  final RxString error;

  const SignUpTextField({
    super.key,
    required this.title,
    required this.controller,
    required this.hintText,
    required this.icon,
    required this.error,
    this.keyboardType,
  });
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Padding(
          padding: EdgeInsets.all(screenWidth * 0.02),
          child: Text(
            title,
            style: TextStyle(
              fontSize: screenWidth * 0.04,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.02,
          ),
          child: CustomTextField2(
            controller: controller,
            hintText: hintText,
            suffixIcon: icon,
            keyboardType: keyboardType ?? TextInputType.text,
          ),
        ),
        Obx(
              () => error.value.isNotEmpty
              ? Padding(
            padding: EdgeInsets.only(
              right: screenWidth * 0.02,
              top: screenHeight * 0.005,
            ),
            child: Text(
              error.value,
              style: TextStyle(
                color: Colors.red,
                fontSize: screenWidth * 0.03,
              ),
            ),
          )
              : const SizedBox(),
        ),
      ],
    );
  }
}