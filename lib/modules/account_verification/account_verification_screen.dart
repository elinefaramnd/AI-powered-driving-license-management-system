import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';

import '../../app_theme/app_colors.dart';
import 'account_verification_controller.dart';

class OtpVerificationScreen extends StatelessWidget {

  OtpVerificationScreen({super.key});

  final EmailVerificationController controller =
  Get.put(EmailVerificationController());

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomRight,

            colors: [
              Color(0xffeaf8f3),
              Color(0xffFEFEFE)],
          ),
        ),

        child: SafeArea(

          child: Column(
            children: [

              const SizedBox(height: 70),

              /// LOGO
              Center(
                child:Container( width:50,height: 50,decoration:BoxDecoration(borderRadius: BorderRadius.circular(30),color: AppColors.primaryColor),
                    child: Icon(Icons.mark_email_read_outlined,color: Colors.white,size: 30,))
              ),

              const SizedBox(height: 45),

              /// TITLE
              const Text(
                "تحقق من البريد الإلكتروني",

                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w800,
                ),
              ),

              const SizedBox(height: 12),

              /// DESCRIPTION
              Text(
                "أدخل رمز التحقق المرسل إلى بريدك الإلكتروني",

                textAlign: TextAlign.center,

                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.w500,
                ),
              ),

              const SizedBox(height: 10),

              /// EMAIL
              Text(
                controller.email,

                style: const TextStyle(
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),

              const SizedBox(height: 45),

              /// OTP
              OtpTextField(

                numberOfFields: 6,

                borderColor: AppColors.primaryColor,

                focusedBorderColor:
                AppColors.primaryColor,

                showFieldAsBox: true,

                fieldWidth: 42,
                cursorColor: AppColors.primaryColor,
                onSubmit: (code) {

                  controller.updateCode(code);
                },
              ),

              const SizedBox(height: 45),

              /// VERIFY BUTTON
              Container(

                width: 270,
                height: 55,

                decoration: BoxDecoration(
                  color: AppColors.primaryColor,

                  borderRadius:
                  BorderRadius.circular(15),
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

                        ? const CircularProgressIndicator(
                      color: Colors.white,
                    )

                        : const Text(
                      "تحقق الآن",

                      style: TextStyle(
                        fontSize: 17,
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