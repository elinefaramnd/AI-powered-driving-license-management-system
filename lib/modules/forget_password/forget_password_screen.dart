import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../widgets/app_button.dart';
import '../../widgets/outlined_textField_widget.dart';
import 'forget_password_controller.dart';

class ForgetPasswordScreen extends StatelessWidget {
  ForgetPasswordScreen({super.key});
  final ForgetPasswordController controller = Get.put(
    ForgetPasswordController(),
  );
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
                crossAxisAlignment: CrossAxisAlignment.end,
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
                      child: Icon(Icons.lock_outline, size: 30),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Center(
                    child: const Text(
                      "استعادة كلمة المرور",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Center(
                    child: Text(
                      "أدخل بريدك الإلكتروني لإرسال رمز التحقق",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("البريد الالكتروني"),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: CustomTextField2(
                      controller: controller.emailController,
                      hintText: 'ادخل بريدك الإلكتروني',
                      suffixIcon: Icons.email_outlined,
                      keyboardType: TextInputType.emailAddress,
                    ),
                  ),
                  const SizedBox(height: 35),
                  Obx(
                    () => AppButton(
                      text: "",
                      onPressed: controller.isLoading.value
                          ? () {}
                          : controller.sendForgetRequest,
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
                              "ارسال رمز التحقق ",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
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
