import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_2/app_theme/app_colors.dart';
import 'package:project_2/widgets/contact_us_widget/contact_us_app_bar.dart';
import 'package:project_2/widgets/contact_us_widget/contact_us_channel_card.dart';
import 'package:project_2/widgets/contact_us_widget/contact_us_error_widget.dart';
import 'package:project_2/widgets/contact_us_widget/contact_us_hero_banner.dart';
import 'package:project_2/widgets/contact_us_widget/contact_us_info_card.dart';
import 'package:project_2/widgets/contact_us_widget/contact_us_section_label.dart';
import 'contact_us_controller.dart';

class ContactUsScreen extends StatelessWidget {
  ContactUsScreen({super.key});

  final ContactUsController controller = Get.isRegistered<ContactUsController>()
      ? Get.find<ContactUsController>()
      : Get.put(ContactUsController());

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final w = size.width;
    final h = size.height;

    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: SafeArea(
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.mediumGreen),
            );
          }

          if (controller.errorMessage.value.isNotEmpty) {
            return ContactUsErrorWidget(
              w: w,
              h: h,
              message: controller.errorMessage.value,
              onRetry: controller.fetchContactInfo,
            );
          }

          final info = controller.contactInfo.value;
          if (info == null) return const SizedBox.shrink();

          return Column(
            children: [
              ContactUsAppBar(w: w),
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: w * 0.045),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        SizedBox(height: h * 0.015),
                        ContactUsHeroBanner(w: w, h: h, info: info),
                        SizedBox(height: h * 0.028),
                        ContactUsSectionLabel(w: w, label: 'معلومات التواصل', icon: Icons.contact_phone_rounded),
                        SizedBox(height: h * 0.014),
                        ContactUsInfoCard(w: w, info: info),
                        SizedBox(height: h * 0.028),
                        ContactUsSectionLabel(w: w, label: 'قنوات التواصل', icon: Icons.hub_rounded),
                        SizedBox(height: h * 0.014),
                        ...info.channels.map(
                          (ch) => Padding(
                            padding: EdgeInsets.only(bottom: h * 0.012),
                            child: ContactUsChannelCard(w: w, h: h, channel: ch),
                          ),
                        ),
                        SizedBox(height: h * 0.028),
                        SizedBox(
                          width: double.infinity,
                          height: h * 0.065,
                          child: ElevatedButton(
                            onPressed: () => Get.toNamed('/send_message'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              elevation: 0,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.send_rounded,
                                    color: Colors.white, size: 20),
                                SizedBox(width: w * 0.025),
                                Text(
                                  'إرسال رسالة',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: w * 0.042,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: h * 0.025),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
