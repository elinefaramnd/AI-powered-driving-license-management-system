import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_2/modules/profile/update_profile_screen.dart';
import 'modules/account_verification/account_verification_screen.dart';
import 'modules/forget_password/forget_password_screen.dart';
import 'modules/home_page/home_screen.dart';
import 'modules/onboarding/onboarding_screen.dart';
import 'modules/profile/complete_profile_screen.dart';
import 'modules/profile/profile_screen.dart';
import 'modules/reset_password/reset_password_screen.dart';
import 'modules/sign_in/sign_in_binding.dart';
import 'modules/sign_in/sign_in_screen.dart';
import 'modules/sign_up/sign_up_screen.dart';
import 'modules/splash/splash_screen.dart';
import 'modules/verification/verification_screen.dart';

void main() {
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
          GetPage(name: '/home',page: () => HomeScreen(),),
          GetPage(name: '/completePro',page: () => CompleteProfileScreen(),),
          GetPage(name: '/showPro',page: () => ProfileScreen(),),
          GetPage(name: '/updatePro',page: () => UpdateProfileScreen(),),








        ]

    );
  }
}