import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app_theme/app_colors.dart';
import '../../widgets/profile/build_profile_item.dart';
import 'profile_controller.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  final ProfileController controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.primaryColor),
          onPressed: () => Get.back(),
        ),
      ),
      body: SafeArea(
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }
          final user = controller.userData;
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: screenHeight * 0.012),
                  Container(
                    width: screenWidth * 0.15,
                    height: screenWidth * 0.15,
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.person,
                      size: screenWidth * 0.09,
                      color: AppColors.primaryColor,
                    ),
                  ),
                   SizedBox(height:screenHeight * 0.025),
                  Text(
                    user["name"] ?? "",
                    style: TextStyle(
                      fontSize: screenWidth * 0.052,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.007),
                  Text(
                    user["email"] ?? "",
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                   SizedBox(height: screenHeight * 0.06),
                  buildProfileItem(
                    context: context,
                    title: "الرقم الوطني",
                    value: user["national_id"] ?? "",
                    icon: Icons.badge_outlined,
                  ),

                  buildProfileItem(
                    context: context,
                    title: "تاريخ الميلاد",
                    value: user["birth_date"] ?? "",
                    icon: Icons.calendar_month,
                  ),
                  buildProfileItem(
                    context: context,
                    title: "رقم الهاتف",
                    value: user["phone"] ?? "",
                    icon: Icons.phone,
                  ),
                  buildProfileItem(
                    context: context,
                    title: "المحافظة",
                    value: user["governorate"] ?? "",
                    icon: Icons.location_on_outlined,
                  ),

                  buildProfileItem(
                    context: context,
                    title: "العنوان",
                    value: user["address"] ?? "",
                    icon: Icons.home_outlined,
                  ),
                   SizedBox(height: screenHeight * 0.03),

                  SizedBox(
                    width: double.infinity,
                    height: 55,

                    child: ElevatedButton(
                      onPressed: () {
                        Get.toNamed("/updatePro", arguments: user);
                      },

                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColor,

                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),

                      child:  Text(
                        "تعديل المعلومات",
                        style: TextStyle(color: Colors.white, fontSize: screenWidth * 0.04, ),
                      ),
                    ),
                  ),

                   SizedBox(height: screenHeight * 0.035),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
