import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../app_theme/app_colors.dart';
import '../../widgets/app_button.dart';
import '../../widgets/outlined_textField_widget.dart';
import 'update_profile_controller.dart';

class UpdateProfileScreen extends StatelessWidget {

  UpdateProfileScreen({super.key});

  final UpdateProfileController controller =
  Get.put(UpdateProfileController());

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("تعديل المعلومات"),
        centerTitle: true,
      ),

      body: Padding(

        padding: const EdgeInsets.all(24),

        child: SingleChildScrollView(

          child: Column(

            crossAxisAlignment:
            CrossAxisAlignment.end,

            children: [

              const SizedBox(height: 20),

              const Text("الاسم"),

              const SizedBox(height: 8),

              CustomTextField2(
                controller: controller.nameController,
                hintText: "ادخل الاسم",
                suffixIcon: Icons.person,
              ),

              const SizedBox(height: 20),

              const Text("المحافظة"),

              const SizedBox(height: 8),

              Obx(
                    () => DropdownSearch<String>(

                  selectedItem:
                  controller.selectedGovernorate.value,

                  items: (filter, loadProps) =>
                  controller.provinces,

                  popupProps: PopupProps.menu(

                    showSearchBox: true,

                    searchFieldProps: TextFieldProps(

                      cursorColor: AppColors.primaryColor,

                      decoration: InputDecoration(

                        hintText: "ابحث عن المحافظة...",

                        prefixIcon: const Icon(Icons.search),

                        border: OutlineInputBorder(
                          borderRadius:
                          BorderRadius.circular(12),
                        ),

                        focusedBorder: OutlineInputBorder(

                          borderRadius:
                          BorderRadius.circular(12),

                          borderSide: const BorderSide(
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ),
                    ),
                  ),

                  decoratorProps: DropDownDecoratorProps(

                    decoration: InputDecoration(

                      hintText: "اختر المحافظة",

                      border: OutlineInputBorder(
                        borderRadius:
                        BorderRadius.circular(14),
                      ),

                      focusedBorder: OutlineInputBorder(

                        borderRadius:
                        BorderRadius.circular(14),

                        borderSide: BorderSide(
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ),
                  ),

                  onSelected: (value) {

                    controller.selectedGovernorate.value =
                        value ?? "";

                    controller.governorateController.text =
                        value ?? "";
                  },
                ),
              ),

              const SizedBox(height: 20),

              const Text("العنوان"),

              const SizedBox(height: 8),

              CustomTextField2(
                controller: controller.addressController,
                hintText: "ادخل العنوان",
                suffixIcon: Icons.home,
              ),

              const SizedBox(height: 35),

              Obx(
                    () => AppButton(

                  text: "",

                  onPressed:
                  controller.isLoading.value
                      ? () {}
                      : controller.updateProfile,

                  child:
                  controller.isLoading.value

                      ? const SizedBox(
                    width: 22,
                    height: 22,
                    child:
                    CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  )

                      : const Text(
                    "حفظ التعديلات",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}