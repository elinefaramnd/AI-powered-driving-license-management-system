import 'package:get/get.dart';

class OnboardingController extends GetxController {

  var currentPage = 0.obs;

  final List<Map<String, String>> onboardingData = [

    {
      'image': 'assets/images/onboarding1.jpg',

      'title':
      'Get your driving license easier than ever',

      'description':
      'Our app simplifies every step of the driving license process to give you a smooth and stress-free experience',
    },

    {
      'image': 'assets/images/onboarding2.jpg',

      'title':
      'Fast, secure and simple payments',

      'description':
      'Pay your application fees safely and quickly with an easy payment experience designed for your convenience',
    },

    {
      'image': 'assets/images/onboarding3.png',

      'title':
      'AI assistant ready to help you anytime',

      'description':
      'Our smart AI chatbot answers your questions instantly and guides you through every step of your journey',
    },
  ];

  void nextPage() {

    if (currentPage.value < onboardingData.length - 1) {

      currentPage.value++;

    } else {

      Get.offAllNamed('/signIn');
    }
  }
}