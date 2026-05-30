import 'package:flutter/material.dart';

class SignInHeader extends StatelessWidget {

  const SignInHeader({super.key});

  @override
  Widget build(BuildContext context) {

    final screenWidth =
        MediaQuery.of(context).size.width;

    final screenHeight =
        MediaQuery.of(context).size.height;

    return Column(
      children: [

        SizedBox(
          height: screenHeight * 0.08,
        ),

        Center(
          child: Image.asset(
            "assets/images/logo.png",

            width: screenWidth * 0.18,
            height: screenWidth * 0.18,
          ),
        ),

        SizedBox(
          height: screenHeight * 0.04,
        ),

        Center(
          child: Text(
            "مرحباً بعودتك",

            style: TextStyle(
              fontSize: screenWidth * 0.065,
              fontWeight: FontWeight.w800,
              color: Colors.black,
            ),
          ),
        ),

        SizedBox(
          height: screenHeight * 0.01,
        ),

        Center(
          child: Text(
            "سجل دخولك للوصول لميزات سيرتك",

            style: TextStyle(
              fontSize: screenWidth * 0.039,
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }
}