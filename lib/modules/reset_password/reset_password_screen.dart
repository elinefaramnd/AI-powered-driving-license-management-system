import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_2/widgets/outlined_textField_widget.dart';

import '../../app_theme/app_colors.dart';
import '../../widgets/app_button.dart';
import 'reset_password_controller.dart';
class ResetPasswordScreen extends StatelessWidget {
  ResetPasswordScreen({super.key});
  final ResetPasswordController controller =
  Get.put(ResetPasswordController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.end,
                children: [
                  const SizedBox(height: 70),
                  Center(
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: Icon(Icons.lock_outline, size: 25),
                    ),
                  ),
                  const SizedBox(height: 30,),

                  Center(
                    child: const Text(

                      "إعادة تعيين كلمة المرور",

                      style: TextStyle(

                        fontSize: 24,

                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  Center(
                    child: Text(

                      "أدخل بياناتك لإنشاء كلمة مرور جديدة",

                      textAlign: TextAlign.center,

                      style: TextStyle(

                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),
                  // Padding(
                  //   padding: const EdgeInsets.all(8.0),
                  //   child: Text("البريد الالكتروني"),
                  // ),
                  // CustomTextField2(
                  //   controller: controller.email,
                  //   hintText: 'ادخل بريدك الإلكتروني',
                  //   suffixIcon: Icons.email_outlined,
                  //   keyboardType: TextInputType.emailAddress,
                  // ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("كلمة المرور الجديدة"),
                  ),
                  Obx(() => CustomTextField2(
                    controller: controller.passwordController,
                    hintText: '........',
                    hintFontSize: 28,
                    prefixIcon:  IconButton(
                      icon: Icon(
                        controller.obscurePassword.value
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: AppColors.primaryColor,
                      ),
                      onPressed: controller.togglePassword,
                    ),
                    obscureText: controller.obscurePassword.value,
                    suffixIcon: Icons.lock_outline,
                  )),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("تأكيد كلمة المرور الجديدة"),
                  ),
                  Obx(() => CustomTextField2(
                    controller: controller.confirmPasswordController,
                    hintText: '........',
                    hintFontSize: 28,
                    prefixIcon:IconButton(
                      icon: Icon(
                        controller.obscureConfirmPassword.value
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: AppColors.primaryColor,
                      ),
                      onPressed: controller.toggleConfirmPassword,
                    ),
                    obscureText: controller.obscureConfirmPassword.value,
                    suffixIcon:  Icons.lock_outline,
                  )),

                  const SizedBox(height: 25),
                  Obx(
                        () => AppButton(

                      text: "",

                      onPressed: controller.isLoading.value
                          ? () {}
                          : controller.reset,

                      child: controller.isLoading.value
                          ? const SizedBox(
                        width: 22,
                        height: 22,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                          : const Text(
                        "حفظ كلمة المرور",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}