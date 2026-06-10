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
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.06),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
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
                      child: Icon(Icons.verified_user_outlined, size: size.width * 0.062,),
                    ),
                  ),
                  SizedBox(height: size.height * 0.039),
                   Text(
                    "تأكيد رمز الاستعادة",
                    style: TextStyle(fontSize: size.width * 0.06, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "أدخل رمز التحقق المرسل إلى بريدك الإلكتروني",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: size.width * 0.037, color: Colors.grey.shade600),
                  ),
                  SizedBox(height: size.height * 0.06),
                  OtpTextField(
                    numberOfFields: 6,
                    fieldWidth: size.width * 0.12,
                    borderColor: AppColors.primaryColor,
                    focusedBorderColor: AppColors.primaryColor,
                    cursorColor: AppColors.primaryColor,
                    showFieldAsBox: true,
                    onCodeChanged: controller.updateCode,
                    onSubmit: controller.submitCode,
                  ),
                  SizedBox(height: size.height * 0.043),
                  Obx(
                        () => AppButton(
                      text: "",
                      onPressed: controller.isLoading.value
                          ? () {}
                          : controller.verifyCodeAndProceed,
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
                        "تأكيد",
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
