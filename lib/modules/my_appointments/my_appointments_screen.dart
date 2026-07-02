import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../app_theme/app_colors.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/my_appointments_widget/appointment_card.dart';
import '../../widgets/my_appointments_widget/appointment_header.dart';
import 'my_appointments_controller.dart';

class MyAppointmentsScreen extends StatelessWidget {
  MyAppointmentsScreen({super.key});

  final controller = Get.put(AppointmentsController());

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const CustomAppBar(
        title: "مواعيدي",
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (controller.appointments.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.event_busy,
                    size: size.width * 0.2,
                    color: Colors.grey.shade400,
                  ),
                  SizedBox(height:size.height * 0.02),
                  Text(
                    "لا يوجد مواعيد حالياً",
                    style: TextStyle(
                      fontSize: size.width * 0.045,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            );
          }

          return ListView(
            padding: EdgeInsets.all(size.width * .04),
            children: [
              const AppointmentHeader(),
              SizedBox(height: size.height * .02),
              ...controller.appointments.map((item) {
                final isCompleted =
                    controller.getStatus(item) == "completed";

                return AppointmentCard(
                  item: item,
                  controller: controller,
                  completed: isCompleted,
                );
              }).toList(),
            ],
          );
        }),
      ),
    );
  }}
