import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app_theme/app_colors.dart';
import '../../../widgets/custom_app_bar.dart';
import '../settings_controller.dart';
import '../../../widgets/settings_widget/password_field_widget.dart';

class ChangePasswordScreen extends StatelessWidget {
  ChangePasswordScreen({super.key});

  final SettingsController controller = Get.find<SettingsController>();
  final _formKey = GlobalKey<FormState>();

  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isArabic = Get.locale?.languageCode == "ar";
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: "change_password".tr,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.06,
            vertical: screenHeight * 0.02,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: screenWidth * 0.2,
                    height: screenWidth * 0.2,
                    decoration: const BoxDecoration(
                      color: Color(0xFFE8F5E9),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.lock_outline,
                      size: screenWidth * 0.1,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.03),

                Center(
                  child: Text(
                    "update_password".tr,
                    textAlign:
                    isArabic ? TextAlign.right : TextAlign.left,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.01),

                Center(
                  child: Text(
                    "update_password_subtitle".tr,
                    textAlign:
                    TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.04),

                PasswordFieldWidget(
                  label: "current_password".tr,
                  hint:  "enter_current_password".tr,
                  controller: _currentPasswordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "current_password_required".tr;
                    }
                    return null;
                  },
                ),
                SizedBox(height: screenHeight * 0.02),

                PasswordFieldWidget(
                  label: "new_password".tr,
                  hint: "enter_new_password".tr,
                  controller: _newPasswordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "new_password_required".tr;
                    }
                    if (value.length < 8) {
                      return "password_min_length".tr;
                    }
                    return null;
                  },
                ),
                SizedBox(height: screenHeight * 0.02),

                PasswordFieldWidget(
                  label: "confirm_new_password".tr,
                  hint: "confirm_new_password_hint".tr,
                  controller: _confirmPasswordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "confirm_password_required".tr;
                    }
                    if (value != _newPasswordController.text) {
                      return "passwords_not_match".tr;
                    }
                    return null;
                  },
                ),

                SizedBox(height: screenHeight * 0.05),

                Obx(() => SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: ElevatedButton(
                        onPressed: controller.isUpdating.value
                            ? null
                            : () {
                                if (_formKey.currentState!.validate()) {
                                  controller.changePassword(
                                    currentPassword: _currentPasswordController.text,
                                    newPassword: _newPasswordController.text,
                                    confirmPassword: _confirmPasswordController.text,
                                  );
                                }
                              },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        child: controller.isUpdating.value
                            ? const CircularProgressIndicator(color: Colors.white)
                            : Text(
                          "change_password".tr,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      ),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
