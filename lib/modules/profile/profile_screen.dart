import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app_theme/app_colors.dart';
import '../../widgets/build_profile_item.dart';
import 'profile_controller.dart';

class ProfileScreen extends StatelessWidget {

  ProfileScreen({super.key});

  final ProfileController controller =
  Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          final user = controller.userData;
          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 40),
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor
                          .withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.person,
                      size: 35,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    user["name"] ?? "",
                    style: const TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    user["email"] ?? "",
                    style: TextStyle(
                      color: Colors.grey.shade600,
                    ),
                  ),
                  const SizedBox(height: 35),
                  buildProfileItem(
                    title: "الرقم الوطني",
                    value: user["national_id"] ?? "",
                    icon: Icons.badge_outlined,
                  ),

                  buildProfileItem(
                    title: "تاريخ الميلاد",
                    value: user["birth_date"] ?? "",
                    icon: Icons.calendar_month,
                  ),
                  buildProfileItem(
                    title: "رقم الهاتف",
                    value: user["phone"] ?? "",
                    icon: Icons.phone,
                  ),
                  buildProfileItem(
                    title: "المحافظة",
                    value: user["governorate"] ?? "",
                    icon: Icons.location_on_outlined,
                  ),

                  buildProfileItem(
                    title: "العنوان",
                    value: user["address"] ?? "",
                    icon: Icons.home_outlined,
                  ),
                  const SizedBox(height: 25),

                  SizedBox(

                    width: double.infinity,
                    height: 55,

                    child: ElevatedButton(

                      onPressed: () {Get.toNamed("/updatePro",
                          arguments: user);},

                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                        AppColors.primaryColor,

                        shape: RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.circular(14),
                        ),
                      ),

                      child: const Text(
                        "تعديل المعلومات",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

}