import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_2/modules/home_page/chat_bot_controller.dart';
import 'package:project_2/modules/profile/update_profile_screen.dart';
import 'modules/account_verification/account_verification_screen.dart';
import 'modules/appointment/AvailableTestsPage.dart';
import 'modules/chat_bot/chat_bot_controller.dart';
import 'modules/create_application/upload_documents_page.dart';
import 'modules/fines/fines_screen.dart';
import 'modules/forget_password/forget_password_screen.dart';
import 'modules/home_page/home_binding.dart';
import 'modules/home_page/home_screen.dart';
import 'modules/my_applications/my_orders/orders_screen.dart';
import 'modules/my_licenses/my_licenses_screen.dart';
import 'modules/test_results/test_results_screen.dart';
import 'modules/my_applications/order_details/order_details_screen.dart';
import 'modules/onboarding/onboarding_screen.dart';
import 'modules/profile/complete_profile_screen.dart';
import 'modules/profile/profile_screen.dart';
import 'modules/reset_password/reset_password_screen.dart';
import 'modules/sign_in/sign_in_binding.dart';
import 'modules/sign_in/sign_in_screen.dart';
import 'modules/sign_up/sign_up_screen.dart';
import 'modules/splash/splash_screen.dart';
import 'modules/verification/verification_screen.dart';
import 'modules/settings_support/settings_screen.dart';
import 'modules/settings_support/screens/change_password_screen.dart';
import 'modules/privacy_policy/privacy_policy_screen.dart';
import 'modules/privacy_policy/privacy_policy_controller.dart';
import 'modules/contact_us/contact_us_screen.dart';
import 'modules/contact_us/contact_us_controller.dart';
import 'modules/send_message/send_message_screen.dart';
import 'modules/send_message/send_message_controller.dart';

void main() {
  Get.put(ChatBotController());
  Get.put(ChatController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return GetMaterialApp(

      debugShowCheckedModeBanner: false,

      initialRoute: '/',

        getPages: [
          GetPage(name: '/signIn', page: ()=>SignInScreen(),binding: SignInBindings()),
          GetPage(name: '/', page: () => SplashScreen(),),
          GetPage(name: '/onboarding', page: () => OnboardingScreen(),),
          GetPage(name: '/signUp',page: () => SignUpScreen(),),
          GetPage(name: '/forgetPass',page: () => ForgetPasswordScreen(),),
          GetPage(name: '/emailVerify',page: () => VerificationScreen(),),
          GetPage(name: '/resetPass',page: () => ResetPasswordScreen(),),
          GetPage(name: '/accountVerify',page: () => OtpVerificationScreen(),),
          GetPage(name: '/home',page: () => HomeScreen(),binding: HomeBinding(),),
          GetPage(name: '/completePro',page: () => CompleteProfileScreen(),),
          GetPage(name: '/showPro',page: () => ProfileScreen(),),
          GetPage(name: '/updatePro',page: () => UpdateProfileScreen(),),
          GetPage(name: '/upload_documents',page: () => UploadDocumentsPage(),),
          GetPage(name: '/order_screen',page: () => OrdersScreen(),),
          GetPage(name: '/order_details',page: () => OrderDetailsScreen(),),
          GetPage(name: '/fines_screen',page: () => FinesScreen(),),
          GetPage(name: '/my_licenses',page: () => MyLicensesScreen(),),
          GetPage(name: '/test_results',page: () => TestResultsScreen(),),
          GetPage(name: '/available_tests_page',page: () => AvailableTestsPage(),),
          GetPage(name: '/settings',page: () => SettingsScreen(),),
          GetPage(name: '/settings/password',page: () => ChangePasswordScreen(),),
          GetPage(name: '/privacy_policy', page: () => PrivacyPolicyScreen(), binding: BindingsBuilder(() { Get.lazyPut(() => PrivacyPolicyController(), fenix: true); })),
          GetPage(name: '/contact_us', page: () => ContactUsScreen(), binding: BindingsBuilder(() { Get.lazyPut(() => ContactUsController(), fenix: true); })),
          GetPage(name: '/send_message', page: () => const SendMessageScreen(), binding: BindingsBuilder(() { Get.lazyPut(() => SendMessageController(), fenix: true); })),

        ]

    );
  }
}