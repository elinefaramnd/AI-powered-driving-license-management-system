import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../widgets/app_button.dart';
import '../../widgets/outlined_textField_widget.dart';
import 'forget_password_controller.dart';

class ForgetPasswordScreen extends StatelessWidget {
  ForgetPasswordScreen({super.key});
  final ForgetPasswordController controller =
  Get.find<ForgetPasswordController>();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final w = size.width;
    final h = size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: w * 0.06),
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
                      child: Icon(Icons.lock_outline, size: w * 0.075,),
                    ),
                  ),
                  SizedBox(height: h * 0.04),
                  Center(
                    child: Text(
                      'recover_password'.tr,
                      style: TextStyle(
                        fontSize: w * 0.06,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  SizedBox(height: h * 0.012),
                  Center(
                    child: Text(
                      "recover_password_description".tr,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: w * 0.041,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ),
                  SizedBox(height: h * 0.045),
                  Padding(
                    padding: EdgeInsets.all(w * 0.02),
                    child: Text("email_label".tr),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: w * 0.02),
                    child: CustomTextField2(
                      controller: controller.emailController,
                      hintText: "enter_email_hint".tr,
                      suffixIcon: Icons.email_outlined,
                      keyboardType: TextInputType.emailAddress,
                    ),
                  ),
                  SizedBox(height: h * 0.045),
                  Obx(
                    () => AppButton(
                      text: "",
                      onPressed: controller.isLoading.value
                          ? () {}
                          : controller.sendForgetRequest,
                      child: controller.isLoading.value
                          ?  SizedBox(
                        width: w * 0.055,
                        height: w * 0.055,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            )
                          :  Text(
                        "send_verification_code".tr,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: w * 0.04,
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
