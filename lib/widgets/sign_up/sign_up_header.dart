import 'package:flutter/material.dart';

class SignUpHeader extends StatelessWidget {
  const SignUpHeader({super.key});
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Column(
      children: [
        SizedBox(height: screenHeight * 0.08),
        Center(
          child: Image.asset(
            "assets/images/logo.png",
            width: screenWidth * 0.18,
            height: screenWidth * 0.18,
          ),
        ),
        SizedBox(height: screenHeight * 0.04),
        Center(
          child: Text(
            "إنشاء حساب جديد",
            style: TextStyle(
              fontSize: screenWidth * 0.065,
              fontWeight: FontWeight.w800,
              color: Colors.black,
            ),
          ),
        ),
        SizedBox(height: screenHeight * 0.01),
        Align(
          alignment: Alignment.center,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.02,
            ),
            child: Text(
              "ادخل بياناتك للوصول إلى خدمات رخص القيادة الرقمية بسلاسة وأمان",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: screenWidth * 0.039,
                color: Colors.grey,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ],
    );
  }
}