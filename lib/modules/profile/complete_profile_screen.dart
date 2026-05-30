import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_2/widgets/outlined_textField_widget.dart';
import '../../app_theme/app_colors.dart';
import '../../widgets/profile/complete_profileButton.dart';
import '../../widgets/profile/dropdown_widget.dart';
import '../../widgets/profile/profile_error_text.dart';
import 'complete_profile_controller.dart';

class CompleteProfileScreen extends StatelessWidget {
  CompleteProfileScreen({super.key});
  final CompleteProfileController controller = Get.put(CompleteProfileController(),);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const SizedBox(height: 50),
                  Center(
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: Icon(Icons.text_snippet_outlined, size: 25),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: const Text(
                      "اكمال الملف الشخصي",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Center(
                    child: Text(
                      "اكمل بياناتك الأساسية لتتمكن من استخدام رخص القيادة",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("الاسم الكامل"),
                  ),
                  CustomTextField2(
                    controller: controller.nameController,
                    hintText: 'ادخل اسمك كما هو في الوثيقة الرسمية',
                    suffixIcon: Icons.email_outlined,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  ProfileErrorText(error: controller.nameError),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("الرقم الوطني"),
                  ),
                  CustomTextField2(
                    controller: controller.nationalNumController,
                    hintText: '',
                    suffixIcon: Icons.badge_outlined,
                    keyboardType: TextInputType.number,
                  ),
                  ProfileErrorText(error: controller.nationalIdError),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("تاريخ الميلاد"),
                  ),
                  GestureDetector(
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime(2000),
                        firstDate: DateTime(1950),
                        lastDate: DateTime.now(),
                        builder: (context, child) {
                          return Theme(
                            data: Theme.of(context).copyWith(
                              colorScheme: const ColorScheme.light(
                                primary: AppColors.primaryColor,
                                onPrimary: Colors.white,
                                onSurface: Colors.black,
                              ),
                              dialogBackgroundColor: Colors.white,
                            ),
                            child: child!,
                          );
                        },
                      );
                      if (pickedDate != null) {
                        controller.birthDateController.text =
                            "${pickedDate.toIso8601String().split('T')[0]}";
                      }
                    },
                    child: AbsorbPointer(
                      child: CustomTextField2(
                        controller: controller.birthDateController,
                        hintText: 'dd/mm/yyyy',
                        suffixIcon: Icons.calendar_today,
                        keyboardType: TextInputType.none,
                      ),
                    ),
                  ),
                  ProfileErrorText(error: controller.birthDateError),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("المحافظة"),
                  ),
                  const GovernorateDropdown(),
                  ProfileErrorText(error: controller.governorateError),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("العنوان"),
                  ),
                  CustomTextField2(
                    controller: controller.addressController,
                    hintText: 'ادخل العنوان',
                    suffixIcon: Icons.email_outlined,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  ProfileErrorText(error: controller.addressError),
                  SizedBox(height: 20),
                  const CompleteProfileButton(),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
