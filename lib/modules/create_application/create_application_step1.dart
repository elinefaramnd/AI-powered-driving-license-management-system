import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../app_theme/app_colors.dart';
import '../../widgets/create_application/application_header.dart';
import '../../widgets/create_application/service_selector.dart';
import '../../widgets/create_application/license_selector.dart';
import '../../widgets/create_application/submit_button.dart';
import 'application_controller.dart';
class CreateApplicationStep1 extends StatelessWidget {
  CreateApplicationStep1({super.key});
  final controller = Get.put(ApplicationController());
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xffF7F7F4),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        iconTheme: IconThemeData(color: AppColors.primary),
        title: Text(
          "طلب إصدار جديد",
          style: TextStyle(
            color: AppColors.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.pageLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        return SingleChildScrollView(
          padding: EdgeInsets.all(size.width * .05),
          child: Container(
            padding: EdgeInsets.all(size.width * .05),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(28),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(.06),
                  blurRadius: 18,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                ApplicationHeader(size: size),
                SizedBox(height: size.height * .015),
                Divider(),
                SizedBox(height: size.height * .015),
                Align(
                  alignment: Alignment.centerRight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "نوع الخدمة",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: size.width * .05,
                        ),
                      ),
                      SizedBox(width: size.width * .01),
                      Text(
                        "1.",
                        style: TextStyle(
                          fontSize: size.width * .05,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: size.height * .015),
                ServiceSelector(size: size),
                SizedBox(height: size.height * .015),
                Align(
                  alignment: Alignment.centerRight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text("نوع الرخصة",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: size.width * .05,
                        ),
                      ),
                      SizedBox(width: size.width * .01),
                      Text(
                        "2.",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: size.width * .05,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: size.height * .02),
                LicenseSelector(size: size),
                const SizedBox(height: 45),
                SubmitButton(size: size),
                const SizedBox(height: 15),
                Center(
                  child: Text(
                    "جميع البيانات محمية وآمنة 🔒",
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
