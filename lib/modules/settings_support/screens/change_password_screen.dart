import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app_theme/app_colors.dart';
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

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.primaryColor),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          'تغيير كلمة المرور',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
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
                    width: screenWidth * 0.25,
                    height: screenWidth * 0.25,
                    decoration: const BoxDecoration(
                      color: Color(0xFFE8F5E9),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.lock_outline,
                      size: screenWidth * 0.12,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.03),

                const Center(
                  child: Text(
                    'تحديث كلمة المرور',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.01),

                Center(
                  child: Text(
                    'قم بإدخال كلمة المرور الحالية والجديدة',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.04),

                PasswordFieldWidget(
                  label: 'كلمة المرور الحالية',
                  hint: 'أدخل كلمة المرور الحالية',
                  controller: _currentPasswordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'الرجاء إدخال كلمة المرور الحالية';
                    }
                    return null;
                  },
                ),
                SizedBox(height: screenHeight * 0.02),

                PasswordFieldWidget(
                  label: 'كلمة المرور الجديدة',
                  hint: 'أدخل كلمة المرور الجديدة',
                  controller: _newPasswordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'الرجاء إدخال كلمة المرور الجديدة';
                    }
                    if (value.length < 8) {
                      return 'يجب أن تكون كلمة المرور 8 أحرف على الأقل';
                    }
                    return null;
                  },
                ),
                SizedBox(height: screenHeight * 0.02),

                PasswordFieldWidget(
                  label: 'تأكيد كلمة المرور الجديدة',
                  hint: 'أعد إدخال كلمة المرور الجديدة',
                  controller: _confirmPasswordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'الرجاء تأكيد كلمة المرور الجديدة';
                    }
                    if (value != _newPasswordController.text) {
                      return 'كلمتا المرور غير متطابقتين';
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
                            : const Text(
                                'تغيير كلمة المرور',
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
