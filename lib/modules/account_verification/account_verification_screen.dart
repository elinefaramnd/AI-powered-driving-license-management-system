import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import '../../app_theme/app_colors.dart';
import 'account_verification_controller.dart';

class OtpVerificationScreen extends StatelessWidget {
  OtpVerificationScreen({super.key});

  final EmailVerificationController controller = Get.put(
    EmailVerificationController(),
  );

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

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
          child: Column(
            children: [
              SizedBox(height: size.height * 0.12),

              Center(
                child: Container(
                  width: size.width * 0.13,
                  height: size.width * 0.13,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(size.width * 0.08),
                    color: AppColors.primaryColor,
                  ),
                  child: Icon(
                    Icons.mark_email_read_outlined,
                    color: Colors.white,
                    size: size.width * 0.08,
                  ),
                ),
              ),

              SizedBox(height: size.height * 0.055),

              Text(
                "تحقق من البريد الإلكتروني",
                style: TextStyle(
                  fontSize: size.width * 0.06,
                  fontWeight: FontWeight.w800,
                ),
              ),

              SizedBox(height: size.height * 0.015),

              Text(
                "أدخل رمز التحقق المرسل إلى بريدك الإلكتروني",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: size.width * 0.039,
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.w500,
                ),
              ),

              SizedBox(height: size.height * 0.012),

              Text(
                controller.email,
                style: TextStyle(
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: size.width * 0.039,
                ),
              ),

              SizedBox(height: size.height * 0.055),

              OtpTextField(
                numberOfFields: 6,
                borderColor: AppColors.primaryColor,
                focusedBorderColor: AppColors.primaryColor,
                showFieldAsBox: true,
                fieldWidth: size.width * 0.12,
                cursorColor: AppColors.primaryColor,
                onSubmit: (code) {
                  controller.updateCode(code);
                },
              ),

              SizedBox(height: size.height * 0.055),

              Container(
                width: size.width * 0.70,
                height: size.height * 0.065,
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(size.width * 0.04),
                ),
                child: ElevatedButton(
                  onPressed: () {
                    controller.verifyCodeAndProceed();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                  ),
                  child: Obx(() {
                    return controller.isLoading.value
                        ? const CircularProgressIndicator(color: Colors.white,)
                        : Text(
                            "تحقق الآن",
                            style: TextStyle(
                              fontSize: size.width * 0.04,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          );
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
