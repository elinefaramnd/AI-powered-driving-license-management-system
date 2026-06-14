import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_2/app_theme/app_colors.dart';
import 'package:project_2/modules/send_message/send_message_controller.dart';
import 'send_message_styled_field.dart';

class SendMessageFormCard extends StatelessWidget {
  final double w;
  final double h;
  final SendMessageController controller;
  const SendMessageFormCard({super.key, required this.w, required this.h, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(w * 0.05),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SendMessageFieldLabel(w: w, label: 'الاسم الكامل', icon: Icons.person_outline_rounded),
          SizedBox(height: h * 0.008),
          SendMessageStyledField(
            controller: controller.nameController,
            hint: 'أدخل اسمك الكامل',
            keyboardType: TextInputType.name,
            w: w,
            readOnly: true,
          ),
          SizedBox(height: h * 0.02),
          SendMessageFieldLabel(w: w, label: 'البريد الإلكتروني', icon: Icons.email_outlined),
          SizedBox(height: h * 0.008),
          SendMessageStyledField(
            controller: controller.emailController,
            hint: 'example@email.com',
            keyboardType: TextInputType.emailAddress,
            w: w,
            isLtr: true,
            readOnly: true,
          ),
          SizedBox(height: h * 0.02),
          SendMessageFieldLabel(w: w, label: 'رقم الهاتف', icon: Icons.phone_outlined),
          SizedBox(height: h * 0.008),
          SendMessageStyledField(
            controller: controller.phoneController,
            hint: '011-0000000',
            keyboardType: TextInputType.phone,
            w: w,
            isLtr: true,
            readOnly: true,
          ),
          SizedBox(height: h * 0.02),
          SendMessageFieldLabel(w: w, label: 'الموضوع', icon: Icons.subject_rounded),
          SizedBox(height: h * 0.008),
          SendMessageStyledField(
            controller: controller.subjectController,
            hint: 'موضوع رسالتك',
            keyboardType: TextInputType.text,
            w: w,
          ),
          SizedBox(height: h * 0.02),
          SendMessageFieldLabel(w: w, label: 'الرسالة', icon: Icons.message_outlined),
          SizedBox(height: h * 0.008),
          SendMessageStyledField(
            controller: controller.messageController,
            hint: 'اكتب رسالتك هنا...',
            keyboardType: TextInputType.multiline,
            w: w,
            maxLines: 5,
          ),
          SizedBox(height: h * 0.03),
          Obx(() => SizedBox(
                width: double.infinity,
                height: h * 0.065,
                child: ElevatedButton(
                  onPressed: controller.isLoading.value ? null : controller.sendMessage,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    disabledBackgroundColor: AppColors.primary.withOpacity(0.6),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 0,
                  ),
                  child: controller.isLoading.value
                      ? const SizedBox(
                          width: 22,
                          height: 22,
                          child: CircularProgressIndicator(
                              color: Colors.white, strokeWidth: 2.5),
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.send_rounded,
                                color: Colors.white, size: 20),
                            SizedBox(width: w * 0.025),
                            Text(
                              'إرسال الرسالة',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: w * 0.042,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                ),
              )),
        ],
      ),
    );
  }
}
