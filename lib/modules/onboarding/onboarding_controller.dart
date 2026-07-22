import 'package:get/get.dart';

class OnboardingController extends GetxController {
  var currentPage = 0.obs;

  final List<Map<String, String>> onboardingData = [
    {
      'image': 'assets/images/onboarding1.gif',

      'title': 'onboarding_title_1',

      'description':
      'onboarding_desc_1',
    },

    {
      'image': 'assets/images/onboarding2.gif',
      'title': 'onboarding_title_2',
      'description': 'onboarding_desc_2',
    },

    {
      'image': 'assets/images/onboarding3.gif',
      'title': 'onboarding_title_3',
      'description': 'onboarding_desc_3',
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
