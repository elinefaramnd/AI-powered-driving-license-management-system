import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_2/widgets/outlined_textField_widget.dart';
import '../../app_theme/app_colors.dart';
import '../../widgets/app_button.dart';
import 'complete_profile_controller.dart';
class CompleteProfileScreen extends StatelessWidget {
  CompleteProfileScreen({super.key});
  final CompleteProfileController controller =
  Get.put(CompleteProfileController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.end,
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
                  const SizedBox(height: 20,),

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
                  Obx(() => controller.nameError.value.isNotEmpty
                      ? Padding(
                    padding: const EdgeInsets.only(top: 4, right: 8),
                    child: Text(
                      controller.nameError.value,
                      style: const TextStyle(
                        color: Colors.red,
                        fontSize: 12,
                      ),
                    ),
                  )
                      : const SizedBox()),
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
                  Obx(() => controller.nationalIdError.value.isNotEmpty
                      ? Padding(
                    padding: const EdgeInsets.only(top: 4, right: 8),
                    child: Text(
                      controller.nationalIdError.value,
                      style: const TextStyle(
                        color: Colors.red,
                        fontSize: 12,
                      ),
                    ),
                  )
                      : const SizedBox()),
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
                  Obx(() => controller.birthDateError.value.isNotEmpty
                      ? Padding(
                    padding: const EdgeInsets.only(top: 4, right: 8),
                    child: Text(
                      controller.birthDateError.value,
                      style: const TextStyle(
                        color: Colors.red,
                        fontSize: 12,
                      ),
                    ),
                  )
                      : const SizedBox()),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("المحافظة"),
                  ),
                  Obx(
                        () => DropdownSearch<String>(
                      items: (filter, loadProps) => controller.provinces,
                      selectedItem: controller.selectedGovernorate.value,
                      popupProps: PopupProps.menu(
                        showSearchBox: true,
                      ),
                      onSelected: (value) {
                        controller.selectedGovernorate.value = value ?? '';
                        controller.governorateController.text = value ?? '';
                        print(value);
                      },
                    ),
                  ),
                  Obx(() => controller.governorateError.value.isNotEmpty
                      ? Padding(
                    padding: const EdgeInsets.only(top: 4, right: 8),
                    child: Text(
                      controller.governorateError.value,
                      style: const TextStyle(
                        color: Colors.red,
                        fontSize: 12,
                      ),
                    ),
                  )
                      : const SizedBox()),
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
                  Obx(() => controller.addressError.value.isNotEmpty
                      ? Padding(
                    padding: const EdgeInsets.only(top: 4, right: 8),
                    child: Text(
                      controller.addressError.value,
                      style: const TextStyle(
                        color: Colors.red,
                        fontSize: 12,
                      ),
                    ),
                  )
                      : const SizedBox()),
                  SizedBox(height: 20,),
                  Obx(() => AppButton(
                      text: "",
                      onPressed: controller.isLoading.value
                          ? () {}
                          : controller.completeProfile,

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
                        "حفظ و متابعة",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20,)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}