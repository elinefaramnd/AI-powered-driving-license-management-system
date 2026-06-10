import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_2/widgets/outlined_textField_widget.dart';
import '../../app_theme/app_colors.dart';
import '../../widgets/app_button.dart';
import 'reset_password_controller.dart';
class ResetPasswordScreen extends StatelessWidget {
  ResetPasswordScreen({super.key});
  final ResetPasswordController controller = Get.put(ResetPasswordController());
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.06),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(height: size.height * 0.12),
                  Center(
                    child: Container(
                      width: size.width * 0.125,
                      height: size.width * 0.125,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(size.width * 0.1),
                      ),
                      child: Icon(Icons.lock_outline, size: size.width * 0.062,),
                    ),
                  ),
                  SizedBox(height: size.height * 0.036),
                  Center(
                    child: Text(
                      "إعادة تعيين كلمة المرور",
                      style: TextStyle(
                        fontSize: size.width * 0.06,
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
                        fontSize: size.width * 0.039,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ),
                  SizedBox(height: size.height * 0.024),
                  Padding(
                    padding: EdgeInsets.all(size.width * 0.03),
                    child: Text("كلمة المرور الجديدة"),
                  ),
                  Obx(
                    () => CustomTextField2(
                      controller: controller.passwordController,
                      hintText: '........',
                      hintFontSize: size.width * 0.07,
                      prefixIcon: IconButton(
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
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(size.width * 0.03,),
                    child: Text("تأكيد كلمة المرور الجديدة"),
                  ),
                  Obx(
                    () => CustomTextField2(
                      controller: controller.confirmPasswordController,
                      hintText: '........',
                      hintFontSize: size.width * 0.07,
                      prefixIcon: IconButton(
                        icon: Icon(
                          controller.obscureConfirmPassword.value
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: AppColors.primaryColor,
                        ),
                        onPressed: controller.toggleConfirmPassword,
                      ),
                      obscureText: controller.obscureConfirmPassword.value,
                      suffixIcon: Icons.lock_outline,
                    ),
                  ),
                  SizedBox(height: size.height * 0.04),
                  Obx(
                    () => AppButton(
                      text: "",
                      onPressed: controller.isLoading.value
                          ? () {}
                          : controller.reset,
                      child: controller.isLoading.value
                          ? SizedBox(
                        width: size.width * 0.055,
                        height: size.width * 0.055,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            )
                          : Text(
                              "حفظ كلمة المرور",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: size.width * 0.045,
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
