import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_2/widgets/outlined_textField_widget.dart';
import '../../app_theme/app_colors.dart';
import '../../widgets/app_button.dart';
import 'reset_password_controller.dart';
class ResetPasswordScreen extends StatelessWidget {
  ResetPasswordScreen({super.key});
  final ResetPasswordController controller =
  Get.find<ResetPasswordController>();
  // final ResetPasswordController controller = Get.put(ResetPasswordController());
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final w = size.width;
    final h = size.height;
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: w * 0.06),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: h * 0.09),
                  Center(
                    child: Container(
                      width: w * 0.13,
                      height: w * 0.13,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(w * 0.1),
                      ),
                      child: Icon(Icons.lock_outline, size: w * 0.07,),
                    ),
                  ),
                  SizedBox(height: h * 0.04),
                  Center(
                    child: Text(
                      "reset_password".tr,
                      style: TextStyle(
                        fontSize: w * 0.06,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  SizedBox(height: h * 0.015),
                  Center(
                    child: Text(
                      "reset_password_description".tr,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: w * 0.041,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ),
                  SizedBox(height: h * 0.03),
                  Padding(
                      padding: EdgeInsets.all(w * 0.02),
                    child: Text("new_password".tr,
                      style: TextStyle(fontSize: w * 0.04),)
                  ),
                  Obx(
                        () => CustomTextField2(
                      controller: controller.passwordController,
                      hintText: '........',
                          hintFontSize: w * 0.06,
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
                      padding: EdgeInsets.all(w * 0.02),
                    child:Text("confirm_new_password".tr,
                      style: TextStyle(fontSize: w * 0.04),)
                  ),
                  Obx(
                        () => CustomTextField2(
                      controller: controller.confirmPasswordController,
                      hintText: '........',
                          hintFontSize: w * 0.06,
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
                  SizedBox(height: h * 0.04),
                  Obx(
                        () => AppButton(
                      text: "",
                      onPressed: controller.isLoading.value
                          ? () {}
                          : controller.reset,
                      child: controller.isLoading.value
                          ? SizedBox(
                        width: w * 0.055,
                        height: w * 0.055,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                          : Text(
                        "save_password".tr,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: w * 0.04,
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
