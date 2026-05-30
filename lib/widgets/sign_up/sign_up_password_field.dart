import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../app_theme/app_colors.dart';
import '../../modules/sign_up/sign_up_controller.dart';
import '../outlined_textField_widget.dart';

class SignUpPasswordField extends StatelessWidget {
  final String title;
  final TextEditingController controller;
  final String hintText;
  final IconData icon;
  final bool isConfirm;
  final VoidCallback onToggle;
  final RxString error;

  const SignUpPasswordField({
    super.key,
    required this.title,
    required this.controller,
    required this.hintText,
    required this.icon,
    required this.isConfirm,
    required this.onToggle,
    required this.error,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Padding(
          padding: EdgeInsets.all(screenWidth * 0.02),
          child: Text(title),
        ),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),

          child: GetBuilder<SignUpController>(
            builder: (controller) {
              final obscure = isConfirm
                  ? controller.obscureConfirmPassword
                  : controller.obscurePassword;

              return CustomTextField2(
                controller: this.controller,
                hintText: hintText,
                hintFontSize: screenWidth * 0.055,
                prefixIcon: IconButton(
                  icon: Icon(
                    obscure ? Icons.visibility_off : Icons.visibility,
                    color: AppColors.primaryColor,
                  ),
                  onPressed: onToggle,
                ),
                obscureText: obscure,
                suffixIcon: icon,
              );
            },
          ),
        ),

        Obx(
              () => error.value.isNotEmpty
              ? Padding(
            padding: EdgeInsets.only(
              right: screenWidth * 0.02,
              top: screenWidth * 0.01,
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