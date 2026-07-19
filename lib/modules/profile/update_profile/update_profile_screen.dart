import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_2/widgets/custom_app_bar.dart';
import '../../../app_theme/app_colors.dart';
import '../../../widgets/app_button.dart';
import '../../../widgets/outlined_textField_widget.dart';
import 'update_profile_controller.dart';

class UpdateProfileScreen extends StatelessWidget {
  UpdateProfileScreen({super.key});
  final UpdateProfileController controller =
      Get.find<UpdateProfileController>();
  final args = Get.arguments;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final w = size.width;
    final h = size.height;
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CustomAppBar(title: "edit_information".tr),
      body: Padding(
        padding: EdgeInsets.all(w * 0.061),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment:
            CrossAxisAlignment.start,
            children: [
              if (args != null &&
                  args["mode"] == "rejected" &&
                  args["reason"] != null &&
                  args["reason"].toString().trim().isNotEmpty)
                Center(
                  child: Padding(
                    padding: EdgeInsets.only(bottom: h * 0.01),
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: TextStyle(
                          fontSize: w * 0.038,
                          color: Colors.black87,
                          height: 1.4,
                        ),
                        children: [
                          TextSpan(
                            text: "${"rejected".tr}: ",
                            style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                              fontSize: w * 0.041,
                            ),
                          ),
                          TextSpan(text: args["reason"]),
                        ],
                      ),
                    ),
                  ),
                ),
              SizedBox(height: h * 0.025),
              Text("name".tr),
              SizedBox(height: h * 0.01),
              CustomTextField2(
                controller: controller.nameController,
                hintText: "enter_name".tr,
                suffixIcon: Icons.person,
              ),
              SizedBox(height: h * 0.025),
              Text("governorate".tr),
              SizedBox(height: h * 0.01),
              Obx(
                () => DropdownSearch<String>(
                  selectedItem: controller.selectedGovernorate.value,
                  items: (filter, loadProps) => controller.provinces,
                  popupProps: PopupProps.menu(
                    showSearchBox: true,
                    searchFieldProps: TextFieldProps(
                      cursorColor: AppColors.primaryColor,
                      decoration: InputDecoration(
                        hintText: "search_governorate".tr,
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(w * 0.03),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(w * 0.03),
                          borderSide: const BorderSide(
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                  decoratorProps: DropDownDecoratorProps(
                    decoration: InputDecoration(
                      hintText: "select_governorate".tr,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(w * 0.036),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(w * 0.036),
                        borderSide: BorderSide(color: AppColors.primaryColor),
                      ),
                    ),
                  ),
                  onSelected: (value) {
                    controller.selectedGovernorate.value = value ?? "";
                    controller.governorateController.text = value ?? "";
                  },
                ),
              ),
              SizedBox(height: h * 0.025),
              Text("address".tr),
              SizedBox(height: h * 0.01),
              CustomTextField2(
                controller: controller.addressController,
                hintText: "enter_address".tr,
                suffixIcon: Icons.home,
              ),
              SizedBox(height: h * 0.044),
              Obx(
                () => AppButton(
                  text: "",
                  onPressed: controller.isLoading.value
                      ? () {}
                      : controller.updateProfile,
                  child: controller.isLoading.value
                      ? SizedBox(
                          width: w * 0.056,
                          height: w * 0.056,
                          child: const CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : Text(
                    "save_changes".tr,
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
