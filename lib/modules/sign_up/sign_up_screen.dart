import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:project_2/modules/logout/logout_controller.dart';
import 'package:project_2/modules/sign_up/sign_up_controller.dart';
import '../../widgets/sign_up/google_signup.dart';
import '../../widgets/sign_up/sign_up_button.dart';
import '../../widgets/sign_up/sign_up_header.dart';
import '../../widgets/sign_up/sign_up_password_field.dart';
import '../../widgets/sign_up/sign_up_text_field.dart';
import '../../widgets/sign_up/signin_redirect.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});
  final SignUpController controller = Get.put(SignUpController());
  final LogOutController LogoutController = Get.put(LogOutController());
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomRight,
            colors: [Color(0xffeaf8f3), Color(0xffFEFEFE)],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.025),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(height: screenHeight * 0.01),
                  const SignUpHeader(),
                  SignUpTextField(
                    title: "الاسم الكامل",
                    controller: controller.nameController,
                    hintText: 'ادخل اسمك الثلاثي',
                    icon: Icons.person_outline,
                    error: controller.nameError,
                  ),
                  SignUpTextField(
                    title: "البريد الإلكتروني",
                    controller: controller.emailController,
                    hintText: 'example@gmail.com',
                    icon: Icons.email_outlined,
                    keyboardType: TextInputType.emailAddress,
                    error: controller.emailError,
                  ),
                  SignUpTextField(
                    title: "رقم الهاتف",
                    controller: controller.phoneController,
                    hintText: '0936000000',
                    icon: Icons.phone_outlined,
                    keyboardType: TextInputType.phone,
                    error: controller.phoneError,
                  ),
                  SignUpPasswordField(
                    title: "كلمة المرور",
                    controller: controller.passwordController,
                    hintText: '........',
                    icon: Icons.lock_outline,
                    isConfirm: false,
                    onToggle: controller.togglePasswordVisibility,
                    error: controller.passwordError,
                  ),

                  SignUpPasswordField(
                    title: "تأكيد كلمة المرور",
                    controller: controller.confirmPasswordController,
                    hintText: '........',
                    icon: Icons.lock_reset,
                    isConfirm: true,
                    onToggle: controller.toggleConfirmPasswordVisibility,
                    error: controller.confirmPasswordError,
                  ),
                  SizedBox(height: screenHeight * 0.035),
                  SignUpButton(controller: controller),
                  SizedBox(height: screenHeight * 0.025),
                  const GoogleSignup(),
                  SizedBox(height: screenHeight * 0.01),
                  const SignInRedirect(),
                  SizedBox(height: screenHeight * 0.02),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
