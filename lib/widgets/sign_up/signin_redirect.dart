import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../app_theme/app_colors.dart';

class SignInRedirect extends StatelessWidget {
  const SignInRedirect({super.key});
  @override
  Widget build(BuildContext context) {
    final isRtl = Directionality.of(context) == TextDirection.rtl;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("already_have_account".tr),
        TextButton(
          onPressed: () {
            Get.toNamed('/signIn');
          },
          child: Text(
            "login".tr,
            style: TextStyle(color: AppColors.primaryColor),
          ),
        ),
      ]

    );
  }
}
