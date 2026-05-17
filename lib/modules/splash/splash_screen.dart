import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'splash_controller.dart';

class SplashScreen extends StatelessWidget {

  SplashScreen({super.key});

  final SplashController controller =
  Get.put(SplashController());

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: const Color(0xffF8FAF9),

      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomRight,

            colors: [Color(0xffEDF3F1),
              Color(0xffEDF3F1)],
          ),
        ),
        child: Center(

          child: Column(

            mainAxisAlignment: MainAxisAlignment.center,

            children: [

              Container(

                width: 120,
                height: 120,

                decoration: BoxDecoration(

                  borderRadius: BorderRadius.circular(30),


                ),

                child: Image.asset("assets/images/logo.png")
              ),

              const SizedBox(height: 25),

              const Text(

                "سيرتك",

                style: TextStyle(

                  fontSize: 42,

                  fontWeight: FontWeight.bold,

                  color: Color(0xff013220),
                ),
              ),

              const Text(

                "SYRTAK",

                style: TextStyle(

                  fontSize: 22,

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