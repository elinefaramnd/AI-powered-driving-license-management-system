import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app_theme/app_colors.dart';
import '../../modules/sign_in/sign_in_controller.dart';

class SignInButton extends StatelessWidget {

  final SignInController controller;

  const SignInButton({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {

    final screenWidth =
        MediaQuery.of(context).size.width;

    final screenHeight =
        MediaQuery.of(context).size.height;

    return Obx(

          () => Container(

        width: double.infinity,

        height: screenHeight * 0.065,

        decoration: BoxDecoration(

          borderRadius:
          BorderRadius.circular(
            screenWidth * 0.04,
          ),

          color:
          AppColors.primaryColor,
        ),

        child: ElevatedButton(

          onPressed:
          controller.isLoading.value

              ? null

              : () => controller.signIn(
            context,
          ),

          style:
          ElevatedButton.styleFrom(

            backgroundColor:
            Colors.transparent,

            shadowColor:
            Colors.transparent,

            shape:
            RoundedRectangleBorder(

              borderRadius:
              BorderRadius.circular(
                screenWidth * 0.08,
              ),
            ),
          ),

          child:
          controller.isLoading.value

              ? SizedBox(

            width:
            screenWidth * 0.055,

            height:
            screenWidth * 0.055,

            child:
            const CircularProgressIndicator(

              color: Colors.white,
              strokeWidth: 2,
            ),
          )

              : Text(

            "تسجيل الدخول",

            style: TextStyle(
              color: Colors.white,

              fontSize:
              screenWidth * 0.043,

              fontWeight:
              FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}