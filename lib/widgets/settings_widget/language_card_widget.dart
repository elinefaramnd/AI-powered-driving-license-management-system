import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import '../../app_theme/app_colors.dart';
import '../../lang/controllers/language_controller.dart';
import '../../modules/settings_support/models/settings_model.dart';
import '../../modules/settings_support/settings_controller.dart';

class LanguageCardWidget extends StatelessWidget {
  final double screenWidth;
  final double screenHeight;
  final List<LanguageOption> languages;
  final Preferences? preferences;
  final SettingsController controller;

  const LanguageCardWidget({
    super.key,
    required this.screenWidth,
    required this.screenHeight,
    required this.languages,
    required this.preferences,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final isArabic = Get.locale?.languageCode == "ar";
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
      child: Container(
        padding: EdgeInsets.all(screenWidth * 0.04),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              textDirection:
              isArabic ? TextDirection.rtl : TextDirection.ltr,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE8F5E9),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    Icons.language,
                    color: Colors.grey.shade700,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 8),
                 Text(
                  'language'.tr,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                Text(
                  'choose_app_language'.tr,
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
            SizedBox(height: screenHeight * 0.015),
            Row(
              textDirection:
              isArabic ? TextDirection.rtl : TextDirection.ltr,
              children: languages.map((lang) {
                final isSelected = preferences?.language == lang.code;
                return Expanded(
                  child: GestureDetector(
                    onTap: () {
                      if (!isSelected) {
                        controller.updatePreferences(
                          language: lang.code,
                          theme: preferences?.theme ?? 'system',
                        );
                        Get.find<LanguageController>().changeLanguage(lang.code);
                      }
                    },
                    child: Container(
                      margin: EdgeInsets.only(
                        left: isArabic
                            ? (lang.code == 'en' ? 8 : 0)
                            : (lang.code == 'ar' ? 8 : 0),
                        right: isArabic
                            ? (lang.code == 'ar' ? 8 : 0)
                            : (lang.code == 'en' ? 8 : 0),
                      ),
                      padding: EdgeInsets.symmetric(
                        vertical: screenHeight * 0.018,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? const Color(0xFFE8F5F1)
                            : Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(12),
                        border: isSelected
                            ? Border.all(
                                color: AppColors.primaryColor,
                                width: 1.5,
                              )
                            : null,
                      ),
                      child: Column(
                        children: [
                          Text(
                            lang.name,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: isSelected
                                  ? AppColors.primaryColor
                                  : Colors.grey.shade700,
                            ),
                          ),
                          if (isSelected)
                            Padding(
                              padding: const EdgeInsets.only(top: 4),
                              child: Icon(
                                Icons.check_circle,
                                color: AppColors.primaryColor,
                                size: 18,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
