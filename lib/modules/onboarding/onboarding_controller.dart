import 'package:get/get.dart';

class OnboardingController extends GetxController {
  var currentPage = 0.obs;

  final List<Map<String, String>> onboardingData = [
    {
      'image': 'assets/images/onboarding1.gif',

      'title': 'احصل على رخصة القيادة بسهولة أكثر من أي وقت مضى',

      'description':
          'يبسط تطبيقنا كل خطوة من خطوات عملية الحصول على رخصة القيادة ليمنحك تجربة سلسة وخالية من التوتر',
    },

    {
      'image': 'assets/images/onboarding2.gif',

      'title': 'مدفوعات سريعة وآمنة وبسيطة',

      'description':
          'ادفع رسوم طلبك بأمان وسرعة من خلال تجربة دفع سهلة مصممة لراحتك',
    },

    {
      'image': 'assets/images/onboarding3.gif',

      'title': 'مساعد الذكاء الاصطناعي جاهز لمساعدتك في أي وقت',

      'description':
          'يجيب روبوت الدردشة الذكي الخاص بنا على أسئلتك على الفور ويرشدك خلال كل خطوة من رحلتك',
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
