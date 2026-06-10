import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'splash_controller.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});

  final SplashController controller = Get.put(SplashController());

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xffF8FAF9),

      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomRight,

            colors: [Color(0xffEDF3F1), Color(0xffEDF3F1)],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              Container(
                width: size.width * 0.32,
                height: size.width * 0.32,

                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(size.width * 0.075),
                ),

                child: Image.asset("assets/images/logo.png"),
              ),

              SizedBox(height: size.height * 0.03),

               Text(
                "سيرتك",

                style: TextStyle(
                  fontSize: size.width * 0.105,

                  fontWeight: FontWeight.bold,

                  color: Color(0xff013220),
                ),
              ),

               Text(
                "SYRTAK",

                style: TextStyle(
                  fontSize: size.width * 0.055,

                  fontWeight: FontWeight.w700,

                  letterSpacing: 1,

                  color: Color(0xff013220),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
