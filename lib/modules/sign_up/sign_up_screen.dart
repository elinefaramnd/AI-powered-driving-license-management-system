import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:project_2/modules/logout/logout_controller.dart';
import 'package:project_2/modules/sign_up/sign_up_controller.dart';
import '../../app_theme/app_colors.dart';
import '../../widgets/outlined_textField_widget.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final SignUpController controller = Get.put(SignUpController());
  final LogOutController LogoutController =Get.put(LogOutController());
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        width: double.infinity,
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
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const SizedBox(height: 67),
                  Center(child: Image.asset("assets/images/logo.png",width: 70,height: 70,)),
                  const SizedBox(height: 35),
                  Center(
                    child: const Text(
                      "إنشاء حساب جديد",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w800,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        "ادخل بياناتك للوصول إلى خدمات رخص القيادة الرقمية بسلاسة وأمان",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("الاسم الكامل"),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: CustomTextField2(
                      controller: controller.nameController,
                      hintText: 'ادخل اسمك الثلاثي',
                      suffixIcon: Icons.person_outline,
                    ),
                  ),
                  Obx(() => controller.nameError.value.isNotEmpty
                      ? Padding(
                    padding: const EdgeInsets.only(right: 8, top: 4),
                    child: Text(
                      controller.nameError.value,
                      style: const TextStyle(color: Colors.red, fontSize: 12),
                    ),
                  )
                      : const SizedBox()),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("البريد الإلكتروني"),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: CustomTextField2(
                      controller: controller.emailController,
                      hintText: 'example@gmail.com',
                      suffixIcon: Icons.email_outlined,
                      keyboardType: TextInputType.emailAddress,
                    ),
                  ),
                  Obx(() => controller.emailError.value.isNotEmpty
                      ? Padding(
                    padding: const EdgeInsets.only(right: 8, top: 4),
                    child: Text(
                      controller.emailError.value,
                      style: const TextStyle(color: Colors.red, fontSize: 12),
                    ),
                  )
                      : const SizedBox()),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("رقم الهاتف"),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: CustomTextField2(
                      controller: controller.phoneController,
                      hintText: '0936000000',
                      suffixIcon: Icons.phone_outlined,
                      keyboardType: TextInputType.phone,
                    ),
                  ),
                  Obx(() => controller.phoneError.value.isNotEmpty
                      ? Padding(
                    padding: const EdgeInsets.only(right: 8, top: 4),
                    child: Text(
                      controller.phoneError.value,
                      style: const TextStyle(color: Colors.red, fontSize: 12),
                    ),
                  )
                      : const SizedBox()),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("كلمة المرور"),
                  ),
                  GetBuilder<SignUpController>(
                    builder: (controller) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: CustomTextField2(
                        controller: controller.passwordController,
                        hintText: '........',
                        hintFontSize: 22,
                        prefixIcon: IconButton(
                          icon: Icon(
                            controller.obscurePassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: AppColors.primaryColor,
                          ),
                          onPressed: controller.togglePasswordVisibility,
                        ),
                        obscureText: controller.obscurePassword,
                        suffixIcon: Icons.lock_outline,
                      ),
                    ),
                  ),
                  Obx(() => controller.passwordError.value.isNotEmpty
                      ? Padding(
                    padding: const EdgeInsets.only(right: 8, top: 4),
                    child: Text(
                      controller.passwordError.value,
                      style: const TextStyle(color: Colors.red, fontSize: 12),
                    ),
                  )
                      : const SizedBox()),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("تأكيد كلمة المرور"),
                  ),
                  GetBuilder<SignUpController>(
                    builder: (controller) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: CustomTextField2(
                        controller: controller.confirmPasswordController,
                        hintText: '........',
                        hintFontSize: 22,
                        prefixIcon: IconButton(
                          icon: Icon(
                            controller.obscureConfirmPassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: AppColors.primaryColor,
                          ),
                          onPressed:
                          controller.toggleConfirmPasswordVisibility,
                        ),
                        obscureText: controller.obscureConfirmPassword,
                        suffixIcon: Icons.lock_reset,
                      ),
                    ),
                  ),
                  Obx(() => controller.confirmPasswordError.value.isNotEmpty
                      ? Padding(
                    padding: const EdgeInsets.only(right: 8, top: 4),
                    child: Text(
                      controller.confirmPasswordError.value,
                      style: const TextStyle(color: Colors.red, fontSize: 12),
                    ),
                  )
                      : const SizedBox()),
                  SizedBox(height: 30,),
                  Obx(
                        () => Container(
                      width: double.infinity,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: AppColors.primaryColor,
                      ),
                      child: ElevatedButton(
                        onPressed: controller.isLoading.value
                            ? null
                            : () => controller.signUp(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
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
                          "إنشاء حساب جديد",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(child: Divider(color: Colors.grey.shade300)),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          "أو",
                          style: TextStyle(color: Colors.grey.shade600),
                        ),
                      ),
                      Expanded(child: Divider(color: Colors.grey.shade300)),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Center(
                    child: Container(
                      width: 40,
                      height: 40,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 10,
                          ),
                        ],
                      ),
                      child: Image.asset(
                        "assets/images/google.png",
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                 Row(mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                     TextButton(
                       onPressed: () {
                         Get.toNamed('/signIn');
                       },
                       child: const Text(
                         "تسجيل الدخول",
                         style: TextStyle(color: AppColors.primaryColor),
                       ),
                     ),
                     Text("لديك حساب بالفعل؟"),
                   ],
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