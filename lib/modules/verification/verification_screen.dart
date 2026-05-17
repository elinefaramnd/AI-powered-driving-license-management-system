import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import '../../app_theme/app_colors.dart';
import '../../widgets/app_button.dart';
import 'verification_controller.dart';

class VerificationScreen extends StatelessWidget {
  VerificationScreen({super.key});
  final VerificationController controller = Get.put(VerificationController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
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
                      child: Icon(Icons.verified_user_outlined, size: 25),
                    ),
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    "تأكيد رمز الاستعادة",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "أدخل رمز التحقق المرسل إلى بريدك الإلكتروني",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 15, color: Colors.grey.shade600),
                  ),
                  const SizedBox(height: 40),
                  OtpTextField(
                    numberOfFields: 6,
                    fieldWidth: 42,
                    borderColor: AppColors.primaryColor,
                    focusedBorderColor: AppColors.primaryColor,
                    cursorColor: AppColors.primaryColor,
                    showFieldAsBox: true,
                    onCodeChanged: controller.updateCode,
                    onSubmit: controller.submitCode,
                  ),
                  const SizedBox(height: 35),
                  Obx(
                    () => AppButton(
                      text: "",
                      onPressed: controller.isLoading.value
                          ? () {}
                          : controller.verifyCodeAndProceed,
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
                              "تأكيد",
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
