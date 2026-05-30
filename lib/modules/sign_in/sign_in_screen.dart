import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../widgets/sign_in/sign_in_button.dart';
import '../../widgets/sign_in/sign_in_header.dart';
import '../../widgets/sign_in/sign_in_password_field.dart';
import '../../widgets/sign_in/sign_in_redirect.dart';
import '../../widgets/sign_in/sign_in_text_field.dart';
import '../../widgets/sign_up/google_signup.dart';
import 'sign_in_controller.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});
  final SignInController controller = Get.put(SignInController());
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
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
                  const SignInHeader(),
                  SizedBox(height: screenHeight * 0.03),
                  SignInTextField(
                    title: "البريد الإلكتروني",
                    controller: controller.emailController,
                    hintText: 'example@gmail.com',
                    icon: Icons.email_outlined,
                    keyboardType: TextInputType.emailAddress,
                    error: controller.emailError,
                  ),
                  SignInPasswordField(
                    title: "كلمة المرور",
                    controller: controller.passwordController,
                    hintText: '.........',
                    icon: Icons.lock_reset,
                    obscureText: controller.obscurePassword,
                    onToggle: controller.togglePassword,
                    error: controller.passwordError,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        Get.toNamed('/forgetPass');
                      },
                      child: const Text(
                        "نسيت كلمة المرور؟",
                        style: TextStyle(color: Color(0xff0D5C46)),
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.015),
                  SignInButton(controller: controller),
                  SizedBox(height: screenHeight * 0.025),
                  const GoogleSignup(),
                  SizedBox(height: screenHeight * 0.01),
                  const SignInRedirect(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
