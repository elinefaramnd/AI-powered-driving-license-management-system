 import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app_theme/app_colors.dart';
import '../../widgets/customField.dart';
import '../../widgets/outlined_textField_widget.dart';
import 'sign_in_controller.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});
  final SignInController controller = Get.put(SignInController());
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomRight,
            colors: [
              Color(0xffeaf8f3),
              Color(0xffFEFEFE)],
          ),
        ),

        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const SizedBox(height: 67),
                 Center(child: Image.asset("assets/images/logo.png",width: 70,height: 70,)),
                  const SizedBox(height: 35),
                    Center(
                      child: const Text(
                        "مرحباً بعودتك",
                        style: TextStyle(
                          fontSize: 25,

                          fontWeight: FontWeight.w800,

                          color: Colors.black,
                        ),

                      ),
                    ),


                  const SizedBox(height: 8),

                  Center(
                    child: Text(
                     "سجل دخولك للوصول لميزات سيرتك",
                      style: TextStyle(fontSize: 15, color: Colors.grey.shade600,fontWeight: FontWeight.w700),
                    ),
                  ),

                  const SizedBox(height: 25),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("البريد الإلكتروني"),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: CustomTextField2(
                      controller: controller.emailController,
                      hintText: 'example@gmail.com',
                      suffixIcon: Icons.email_outlined,
                      keyboardType: TextInputType.emailAddress,
                    ),
                  ),
                  Obx(() => controller.emailError.value.isNotEmpty
                      ? Padding(
                    padding: const EdgeInsets.only(right: 8, top: 4),
                    child: Text(
                      controller.emailError.value,
                      style: const TextStyle(color: Colors.red, fontSize: 12),
                    ),
                  )
                      : const SizedBox()),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("كلمة المرور"),
                  ),
                  Obx(() => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: CustomTextField2(
                      controller: controller.passwordController,
                      hintText: '.........',
                        hintFontSize: 25,
                      prefixIcon: IconButton(
                        icon: Icon(
                          controller.obscurePassword.value
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: AppColors.primaryColor,
                        ),
                        onPressed: controller.togglePassword,
                      ),
                      obscureText: controller.obscurePassword.value,
                      suffixIcon: Icons.lock_reset
                    ),
                  )),
                  Obx(() => controller.passwordError.value.isNotEmpty
                      ? Padding(
                    padding: const EdgeInsets.only(right: 8, top: 4),
                    child: Text(
                      controller.passwordError.value,
                      style: const TextStyle(color: Colors.red, fontSize: 12),
                    ),
                  )
                      : const SizedBox()),
                  Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      Get.toNamed('/forgetPass');
                    },

                    child: const Text(
                      "نسيت كلمة المرور؟",
                      style: TextStyle(
                        color: Color(0xff0D5C46),
                      ),
                    ),
                  ),
                ),

                  const SizedBox(height: 12),
                  Obx(() => Container(
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: AppColors.primaryColor,
                    ),
                    child: ElevatedButton(
                      onPressed: controller.isLoading.value
                          ? null
                          : () => controller.signIn(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: controller.isLoading.value
                          ? const SizedBox(
                        width: 22,
                        height: 22,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                          : const Text(
                        "تسجيل الدخول",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  )),

                  const SizedBox(height: 20),

                  Row(
                    children: [
                      Expanded(child: Divider(color: Colors.grey.shade300)),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),

                        child: Text(
                          "أو",
                          style: TextStyle(color: Colors.grey.shade600),
                        ),
                      ),

                      Expanded(child: Divider(color: Colors.grey.shade300)),
                    ],
                  ),

                  const SizedBox(height: 15),

                  Center(
                    child: Container(
                      width: 40,
                      height: 40,

                      padding: const EdgeInsets.all(8),

                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        shape: BoxShape.circle,

                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 10,
                          ),
                        ],
                      ),

                      child: Image.asset(
                        "assets/images/google.png",
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () {
                          Get.toNamed('/signUp');
                        },
                        child: const Text(
                         "إنشاء حساب جديد",
                          style: TextStyle(color: AppColors.primaryColor),
                        ),
                      ),
                      Text("ليس لديك حساب؟",),

                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget socialButton(IconData icon) {
    return Container(
      width: 52,
      height: 52,

      decoration: BoxDecoration(
        color: Colors.white,

        shape: BoxShape.circle,

        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10),
        ],
      ),

      child: Icon(icon),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../../widgets/customField.dart';
// import 'sign_in_controller.dart';
//
// class SignInScreen extends StatelessWidget {
//   SignInScreen({super.key});
//
//   final SignInController controller = Get.put(SignInController());
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//         body: Container(
//         width: double.infinity,
// decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topCenter,
//             end: Alignment.bottomRight,
//
//             colors: [Color(0xffeff8f4),
//               Color(0xfff4f5f5),
//               Color(0xfff5f6f6)],
//           ),
//         ),
//       child: SafeArea(
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 24),
//
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//
//               children: [
//                 const SizedBox(height: 60),
//
//                 Center(
//                   child: Image.asset(
//                     "assets/images/logo.png",
//                     width: 110,
//                     height: 110,
//                   ),
//                 ),
//
//                 const SizedBox(height: 30),
//
//                 const Center(
//                   child: Text(
//                     "مرحباً بعودتك",
//                     style: TextStyle(
//                       fontSize: 27,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.black,
//                     ),
//                   ),
//                 ),
//
//                 const SizedBox(height: 10),
//
//                 Center(
//                   child: Text(
//                     "سجل دخولك للوصول لميزات سيرتك",
//                     style: TextStyle(
//                       fontSize: 15,
//                       color: Colors.grey.shade600,
//                     ),
//                   ),
//                 ),
//
//                 const SizedBox(height: 40),
//
//                 customField(
//                   hint: "أدخل الايميل",
//                   controller: controller.emailController,
//                   icon: Icons.email_outlined,
//                 ),
//
//                 const SizedBox(height: 18),
//
//                 Obx(
//                       () => customField(
//                     hint: "أدخل كلمة المرور",
//                     controller: controller.passwordController,
//                     isPassword: true,
//                     obscure: controller.obscureText.value,
//                     onTap: controller.togglePassword,
//                     icon: Icons.lock_outline,
//                   ),
//                 ),
//
//                 Align(
//                   alignment: Alignment.centerRight,
//                   child: TextButton(
//                     onPressed: () {
//                       Get.toNamed('/forgetPass');
//                     },
//
//                     child: const Text(
//                       "نسيت كلمة المرور؟",
//                       style: TextStyle(
//                         color: Color(0xff0D5C46),
//                       ),
//                     ),
//                   ),
//                 ),
//
//                 const SizedBox(height: 20),
//
//             Container(
//                     width: double.infinity,
//                     height: 50,
//
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(30),
//
//                       gradient: const LinearGradient(
//                         begin: Alignment.centerLeft,
//                         end: Alignment.centerRight,
//
//                         colors: [Color(0xff0B5D46), Color(0xff013220)],
//                       ),
//                     ),
//
//                     child: ElevatedButton(
//                       onPressed: controller.signIn,
//
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.transparent,
//
//                         shadowColor: Colors.transparent,
//
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(30),
//                         ),
//                       ),
//
//                       child: const Text(
//                         "تسجيل الدخول",
//
//                         style: TextStyle(
//                           color: Colors.white,
//
//                           fontSize: 17,
//
//                           fontWeight: FontWeight.w700,
//                         ),
//                       ),
//                     ),
//                   ),
//
//                 const SizedBox(height: 25),
//
//                 Row(
//                   children: [
//                     Expanded(
//                       child: Divider(color: Colors.grey.shade300),
//                     ),
//
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 10),
//
//                       child: Text(
//                         "أو",
//                         style: TextStyle(
//                           color: Colors.grey.shade600,
//                         ),
//                       ),
//                     ),
//
//                     Expanded(
//                       child: Divider(color: Colors.grey.shade300),
//                     ),
//                   ],
//                 ),
//
//                 const SizedBox(height: 10),
//
//                 Center(
//                   child: Container(
//                     width: 45,
//                     height: 45,
//
//                     padding: const EdgeInsets.all(12),
//
//                     decoration: BoxDecoration(
//                       color: Colors.grey.shade100,
//
//                       shape: BoxShape.circle,
//                     ),
//
//                     child: Image.asset("assets/images/OIP.png"),
//                   ),
//                 ),
//
//                 const SizedBox(height: 5),
//
//                 Center(
//                   child: TextButton(
//                     onPressed: () {
//                       Get.toNamed('/signUp');
//                     },
//
//                     child: const Text(
//                       "إنشاء حساب جديد",
//                       style: TextStyle(
//                         color: Color(0xff0D5C46),
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     ));
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:project_2/modules/sign_in/sign_in_controller.dart';
//
// class SignInScreen extends StatelessWidget{
//   SignInScreen({super.key});
//
//   final SignInController controller = Get.put(SignInController());
//   @override
//   Widget build(BuildContext context){
//     return Scaffold(
//       body: SafeArea(
//         child: Column(
//           mainAxisAlignment:MainAxisAlignment.start,
//           children: [
//             SizedBox(height: 50,),
//             Center(child: Image.asset("assets/images/logo.png",width: 110,height: 110,)),
//             SizedBox(height: 10,),
//           Text("سجل دخولك",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
//         Text(" اهلا بك",style: TextStyle(fontSize: 25,fontWeight: FontWeight.w400),),
//           SizedBox(height: 38,),
//           Padding(
//             padding: const EdgeInsets.only(right: 230.0),
//             child: Text("البريد الالكتروني"),
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 10.0),
//             child: TextField(
//                 decoration: InputDecoration(
//                     border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(15))
//                     ,hintText:" ادخل البريد الالكتروني",
//                 focusedBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(15),
//                     borderSide: BorderSide(
//                       color: Colors.grey,
//                 )),
//
//
//             ),
//           ),),
//
//             Padding(
//               padding: const EdgeInsets.only(right: 250.0),
//               child: Text("كلمة المرور"),
//             ),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal:  10.0),
//             child: TextField(decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),hintText: "  ادخل كلمة المرور",suffixIcon: IconButton(onPressed: (){}, icon:Icon(Icons.remove_red_eye_outlined),color: Color(0xff988561),)),),
//           ),
//
//           Padding(
//             padding: const EdgeInsets.only(left: 230.0),
//             child: Text("نسيت كلمة المرور؟",style: TextStyle(color: Color(0xffAFA280)),),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(17.0),
//             child: Container(width: double.infinity,
//               height: 50,
//               child: ElevatedButton(onPressed: (){}, child: Text("تسجيل الدخول"), style: ElevatedButton.styleFrom(
//                 shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(15),
//                         ),
//                 backgroundColor: Color(0xff224E37), // لون الزر
//                 foregroundColor: Color(0xff988561),
//                 // لون النص
//               ),),
//             ),
//           ),
//         Row(
//                   children: [
//                     Expanded(
//                       child: Divider(color: Colors.grey.shade300),
//                     ),
//
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 10),
//
//                       child: Text(
//                         "أو",
//                         style: TextStyle(
//                           color: Colors.grey.shade600,
//                         ),
//                       ),
//                     ),
//
//                     Expanded(
//                       child: Divider(color: Colors.grey.shade300),
//                     ),
//                   ],
//                 ),
//
//             const SizedBox(height: 24),
//         Container(
//           width: 55,
//           height: 55,
//
//           padding: const EdgeInsets.all(14),
//
//           decoration: BoxDecoration(
//             color: Colors.white,
//
//             shape: BoxShape.circle,
//
//             border: Border.all(
//               color: const Color(0xffD9C08B),
//             ),
//
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black.withOpacity(0.04),
//                 blurRadius: 12,
//               ),
//             ],
//           ),
//
//           child: Image.asset('assets/images/OIP.png'),
//         ),
//
//             const SizedBox(height: 5),
//
//             /// SIGN UP
//             Row(
//               mainAxisAlignment:
//               MainAxisAlignment.center,
//
//               children: [
//                 TextButton(
//                   onPressed: () {
//                     Get.toNamed('/signUp');
//                   },
//
//                   child: const Text(
//                     "إنشاء حساب",
//
//                     style: TextStyle(
//                       color: Color(0xffB8945B),
//                       fontWeight:
//                       FontWeight.bold,
//                     ),
//                   ),
//                 ),
//                 Text(
//                   "ليس لديك حساب؟",
//
//                   style: TextStyle(
//                     color:
//                     Colors.grey.shade700,
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//
//
//       ),
//     );
//   }
// }
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:project_2/app_theme/app_colors.dart';
// import 'package:project_2/modules/sign_in/sign_in_controller.dart';
//
// import '../../helpers/customer_clipper.dart';
// import '../../widgets/custom_text_field.dart';
// import '../sign_up/sign_up_screen.dart';

// class SignInScreen extends StatelessWidget {
//   const SignInScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     SignInController controller = Get.find();
//     return DefaultTabController(
//       length: 2,
//       child: Scaffold(
//         resizeToAvoidBottomInset: true,
//         backgroundColor: Colors.white,
//         body: LayoutBuilder(
//           builder: (context, constraints) {
//             return SingleChildScrollView(
//               padding: EdgeInsets.zero,
//               child: ConstrainedBox(
//                 constraints: BoxConstraints(minHeight: constraints.maxHeight),
//                 child: IntrinsicHeight(
//                   child: Stack(
//                     children: [
//                       ClipPath(
//                         clipper: DiagonalClipper(),
//                         child: Container(
//                           height: 300,
//                           color: AppColors.primaryColor,
//                           child: Align(
//                             alignment: const Alignment(-0.3, -0.3),
//                             child: Row(
//                               mainAxisSize: MainAxisSize.min,
//                               children: [
//                                 Image.asset(
//                                   'assets/images/download.png',
//                                   height: 40,
//                                   width: 40,
//                                 ),
//                                 const SizedBox(width: 8,),
//                                 Text(
//                                   'SYRTAK',
//                                   style: TextStyle(
//                                     fontSize: 32,
//                                     color: Colors.white,
//                                     fontStyle: FontStyle.italic,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                       Positioned(
//                         top: 180,
//                         left: 0,
//                         right: 0,
//                         child: Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 35),
//                           child: Material(
//                             elevation: 8,
//                             borderRadius: BorderRadius.circular(20),
//                             child: Container(
//                               padding: const EdgeInsets.all(20),
//                               decoration: BoxDecoration(
//                                 color: Colors.white,
//                                 borderRadius: BorderRadius.circular(20),
//                               ),
//                               child: Column(
//                                 children: [
//                                   TabBar(
//                                     labelColor: AppColors.primaryColor,
//                                     unselectedLabelColor: Colors.grey,
//                                     labelStyle: TextStyle(
//                                       fontSize: 18,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                     indicatorColor: AppColors.primaryColor,
//                                     indicatorWeight: 2,
//                                     tabs: [
//                                       Tab(text: 'Sign in'),
//                                       Tab(text: 'Sign Up'),
//                                     ],
//                                   ),
//                                   const SizedBox(height: 20),
//                                   AnimatedBuilder(
//                                     animation: DefaultTabController.of(
//                                       context,
//                                     )!.animation!,
//                                     builder: (context, _) {
//                                       final tabIndex = DefaultTabController.of(
//                                         context,
//                                       )!.index;
//                                       final screenHeight = MediaQuery.of(
//                                         context,
//                                       ).size.height;
//
//                                       final height = tabIndex == 0
//                                           ? screenHeight * 0.45
//                                           : screenHeight * 0.58;
//
//                                       return SizedBox(
//                                         height: height,
//                                         child: TabBarView(
//                                           children: [
//                                             GetBuilder<SignInController>(
//                                               builder: (controller) {
//                                                 return SingleChildScrollView(
//                                                   padding:
//                                                       const EdgeInsets.only(
//                                                         bottom: 100,
//                                                       ),
//                                                   child: Column(
//                                                     crossAxisAlignment:
//                                                         CrossAxisAlignment
//                                                             .start,
//                                                     children: [
//                                                       CustomTextField(
//                                                         label: 'Email',
//                                                         hintText: 'enter your email',
//                                                         controller: controller
//                                                             .emailController,
//                                                         icon: Icons.email,
//                                                       ),
//                                                       Obx(
//                                                         () => CustomTextField(
//                                                           label: 'Password',
//                                                           hintText: 'enter your password',
//                                                           controller: controller
//                                                               .passwordController,
//                                                           icon: Icons.lock,
//                                                           obscure: controller
//                                                               .obscurePassword
//                                                               .value,
//                                                           suffixIcon: IconButton(
//                                                             icon: Icon(
//                                                               controller.obscurePassword.value
//                                                                   ? Icons.visibility_off
//                                                                   :
//                                                               Icons.visibility,
//                                                               color: Colors
//                                                                   .grey[700],
//                                                               size: 22,
//                                                             ),
//                                                             onPressed: () {controller.togglePassword();},
//                                                           ),
//                                                         ),
//                                                       ),
//                                                       Align(
//                                                         alignment: Alignment
//                                                             .bottomRight,
//                                                         child: TextButton(
//                                                           onPressed: () {
//                                                             Get.toNamed(
//                                                               '/forgetPass',
//                                                             );
//                                                           },
//                                                           child: Text(
//                                                             'Forget Password',
//                                                             style: TextStyle(
//                                                               color:AppColors.primaryColor,
//                                                               fontSize: 14,
//                                                             ),
//                                                           ),
//                                                         ),
//                                                       ),
//                                                       const SizedBox(
//                                                         height: 10,
//                                                       ),
//                                                       SizedBox(
//                                                         width: double.infinity,
//                                                         height: 45,
//                                                         child: ElevatedButton(
//                                                           onPressed: () {},
//                                                           style: ElevatedButton.styleFrom(
//                                                             backgroundColor:
//                                                             AppColors.primaryColor,
//                                                             shape: RoundedRectangleBorder(
//                                                               borderRadius:
//                                                                   BorderRadius.circular(
//                                                                     25,
//                                                                   ),
//                                                             ),
//                                                           ),
//                                                           child: Text(
//                                                             'Sign in',
//                                                             style: TextStyle(
//                                                               fontSize: 16,
//                                                               color:
//                                                                   Colors.white,
//                                                             ),
//                                                           ),
//                                                         ),
//                                                       ),
//                                                     ],
//                                                   ),
//                                                 );
//                                               },
//                                             ),
//                                             SignUpScreen(),
//                                           ],
//                                         ),
//                                       );
//                                     },
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
