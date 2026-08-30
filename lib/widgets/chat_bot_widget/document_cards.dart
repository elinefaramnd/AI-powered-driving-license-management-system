import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_2/widgets/chat_bot_widget/required_document_card.dart';
import '../../app_theme/app_colors.dart';
import '../../modules/chat_bot/chat_bot_controller.dart';
import 'document_action_button.dart';

class DocumentCards extends StatelessWidget {
  final ChatController controller;
  final List<Map<String, dynamic>> documents;
  final List<Map<String, dynamic>> buttons;
  final Size size;

  const DocumentCards({
    super.key,
    required this.controller,
    required this.documents,
    required this.buttons,
    required this.size,
  });
  @override
  Widget build(BuildContext context) {
    final isArabic = Get.locale?.languageCode == 'ar';
    return Directionality(
      textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
      child: Container(
        margin: EdgeInsets.only(top: size.height * 0.018),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: size.height * 0.01),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 1,
                    color: AppColors.gold.withOpacity(0.35),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.025),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'chatbot_required_documents'.tr,
                        textAlign: isArabic ? TextAlign.right : TextAlign.left,
                        style: TextStyle(
                          color: AppColors.primaryColor,
                          fontSize: size.width * (isArabic ? 0.035 : 0.030),
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      SizedBox(width: size.width * 0.018),
                      Icon(
                        Icons.description_outlined,
                        color: AppColors.gold,
                        size: size.width * 0.045,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 1,
                    color: AppColors.gold.withOpacity(0.35),
                  ),
                ),
              ],
            ),
            SizedBox(height: size.height * 0.012),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: documents.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: size.width * 0.025,
                mainAxisSpacing: size.height * 0.014,
                childAspectRatio: 0.8,
              ),
              itemBuilder: (context, index) {
                final document = documents[index];
                final label = document['label']?.toString() ?? '';
                final status = document['status']?.toString() ?? '';
                final selectionToken =
                    document['selection_token']?.toString() ?? '';
                return RequiredDocumentCard(
                  controller: controller,
                  label: label,
                  status: status,
                  selectionToken: selectionToken,
                  size: size,
                );
              },
            ),
            SizedBox(height: size.height * 0.018),
            ...buttons.map((button) {
              final label = button['label']?.toString() ?? '';
              final action = button['action']?.toString() ?? '';
              return Padding(
                padding: EdgeInsets.only(bottom: size.height * 0.012),
                child: DocumentActionButton(
                  controller: controller,
                  label: label,
                  action: action,
                  size: size,
                ),
              );
            }),
            Container(
              margin: EdgeInsets.only(top: size.height * 0.002),
              padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.025,
                vertical: size.height * 0.010,
              ),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.75),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: Text(
                      'chatbot_documents_privacy'.tr,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: size.width * (isArabic ? 0.023 : 0.020),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(width: size.width * 0.015),
                  Icon(
                    Icons.shield_outlined,
                    color: AppColors.primaryColor,
                    size: size.width * 0.035,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
