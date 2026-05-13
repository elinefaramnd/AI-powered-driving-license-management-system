import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'onboarding_controller.dart';

class OnboardingScreen extends StatelessWidget {

  OnboardingScreen({super.key});

  final OnboardingController controller =
  Get.put(OnboardingController());

  @override
  Widget build(BuildContext context) {

    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(

      backgroundColor: const Color(0xffEEF1FF),

      body: SafeArea(

        child: Obx(() {

          final data =
          controller.onboardingData[controller.currentPage.value];

          return Column(

              children: [

                Expanded(

                  child: Container(

                    width: double.infinity,

                    padding: const EdgeInsets.all(25),

                    decoration: BoxDecoration(

                      color: Colors.white,
                    ),

                    child: Column(

                      children: [

                        SizedBox(height: screenHeight * 0.03),

                        Expanded(

                          flex: 5,

                          child: Image.asset(
                            data['image']!,
                            fit: BoxFit.contain,
                          ),
                        ),

                        SizedBox(height: screenHeight * 0.03),

                        Text(

                          data['title']!,

                          textAlign: TextAlign.center,

                          style: TextStyle(

                            fontSize: screenWidth * 0.065,

                            fontWeight: FontWeight.bold,

                            color: Colors.black,
                          ),
                        ),

                        SizedBox(height: screenHeight * 0.02),

                        Text(

                          data['description']!,

                          textAlign: TextAlign.center,

                          style: TextStyle(

                            fontSize: screenWidth * 0.035,

                            color: Colors.grey.shade600,

                            height: 1.5,
                          ),
                        ),

                        SizedBox(height: screenHeight * 0.04),

                        Row(

                          mainAxisAlignment: MainAxisAlignment.center,

                          children: List.generate(

                            controller.onboardingData.length,

                                (index) => AnimatedContainer(

                              duration:
                              const Duration(milliseconds: 300),

                              margin:
                              const EdgeInsets.symmetric(horizontal: 4),

                              width: controller.currentPage.value == index
                                  ? 18
                                  : 7,

                              height: 7,

                              decoration: BoxDecoration(

                                borderRadius:
                                BorderRadius.circular(20),

                                color:
                                controller.currentPage.value == index
                                    ? const Color(0xff054239)
                                    : Colors.grey.shade300,
                              ),
                            ),
                          ),
                        ),

                        const Spacer(),

                        SizedBox(

                          width: double.infinity,

                          height: 58,

                          child: ElevatedButton(

                            onPressed: controller.nextPage,

                            style: ElevatedButton.styleFrom(

                              backgroundColor:
                              const Color(0xff054239),

                              elevation: 0,

                              shape: RoundedRectangleBorder(

                                borderRadius:
                                BorderRadius.circular(18),
                              ),
                            ),

                            child: Text(

                              controller.currentPage.value ==
                                  controller.onboardingData.length - 1
                                  ? "Get Started"
                                  : "Next",

                              style: const TextStyle(

                                color: Colors.white,

                                fontSize: 18,

                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
          );
        }),
      ),
    );
  }
}