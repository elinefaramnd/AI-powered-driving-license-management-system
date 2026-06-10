import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../app_theme/app_colors.dart';
import '../../modules/appointment/AvailableTestsController.dart';
import '../../modules/appointment_slots/appointment_slots_page.dart';

class MainTestCard extends StatelessWidget {
  final dynamic availableTest;
  const MainTestCard({super.key, required this.availableTest});
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final controller = Get.find<AvailableTestsController>();
    final state = controller.getTestState(availableTest["code"]);

    final icon = controller.getIcon(availableTest["code"]);
    final title = controller.getArabicName(availableTest["code"]);
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: size.width * 0.04,
        vertical: size.width * 0.035,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(size.width * 0.055),
        border: Border.all(color: AppColors.primaryColor, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: size.width * 0.15,
                height: size.width * 0.15,
                decoration: BoxDecoration(
                  color: AppColors.primaryColor.withOpacity(.08),
                  borderRadius: BorderRadius.circular(size.width * 0.03),
                ),
                child: Icon(icon, color: AppColors.primaryColor),
              ),
              SizedBox(width: size.width * 0.03),
              Container(
                width: 1,
                height: size.width * 0.12,
                color: Colors.grey.shade300,
              ),
              SizedBox(width: size.width * 0.03),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: size.width * 0.0355,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: size.width * 0.005),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: size.width * 0.025,
                        vertical: size.width * 0.005,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor.withOpacity(.08),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        "متاح للحجز",
                        style: TextStyle(
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.w600,
                          fontSize: size.width * 0.033,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: size.width * 0.005),
          Text(
            state["text"],
            style: TextStyle(
              color: Colors.grey.shade700,
              fontSize: size.width * 0.034,
            ),
          ),

          SizedBox(height: size.width * 0.012),
          Divider(color: Colors.grey.shade300),
          SizedBox(height: size.width * 0.008),
          Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: size.width * 0.02,
                      ),
                      child: const Text("عدد المحاولات :"),
                    ),
                    SizedBox(width: size.width * 0.008),
                    const Text(
                      "0 / 3",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Container(
                width: 1,
                height: size.width * 0.07,
                color: Colors.grey.shade300,
              ),
              Expanded(
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: size.width * 0.0355,
                      ),
                      child: const Text("آخر نتيجة :"),
                    ),
                    const Text(
                      "لا يوجد",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: size.width * 0.01),
          SizedBox(
            width: double.infinity,
            height: size.width * 0.135,
            child: ElevatedButton.icon(
              onPressed: () async {
                final result = await Get.to(
                  () => AppointmentSlotsPage(
                    testTypeId: availableTest["test_type_id"],
                    applicationId: controller.applicationId,
                  ),
                );

                if (result == true) {
                  await controller.loadTests();
                }
              },
              icon: const Icon(Icons.calendar_month, color: Colors.white),
              label: const Text(
                "عرض المواعيد المتاحة",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(size.width * 0.035),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
