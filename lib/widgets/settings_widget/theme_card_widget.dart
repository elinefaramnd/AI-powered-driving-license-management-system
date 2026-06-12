import 'package:flutter/material.dart';
import '../../app_theme/app_colors.dart';
import '../../modules/settings_support/models/settings_model.dart';
import '../../modules/settings_support/settings_controller.dart';

class ThemeCardWidget extends StatelessWidget {
  final double screenWidth;
  final double screenHeight;
  final List<ThemeOption> themes;
  final Preferences? preferences;
  final SettingsController controller;

  const ThemeCardWidget({
    super.key,
    required this.screenWidth,
    required this.screenHeight,
    required this.themes,
    required this.preferences,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
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
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE8F5E9),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    Icons.dark_mode_outlined,
                    color: Colors.grey.shade700,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 8),
                const Text(
                  'الوضع',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                Text(
                  'اختر مظهر التطبيق',
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
            SizedBox(height: screenHeight * 0.015),
            Row(
              children: themes.asMap().entries.map((entry) {
                final theme = entry.value;
                final isSelected = preferences?.theme == theme.code;

                IconData iconData;
                if (theme.code == 'system') {
                  iconData = Icons.settings_suggest;
                } else if (theme.code == 'dark') {
                  iconData = Icons.dark_mode;
                } else {
                  iconData = Icons.wb_sunny;
                }

                return Expanded(
                  child: GestureDetector(
                    onTap: () {
                      if (!isSelected) {
                        controller.updatePreferences(
                          language: preferences?.language ?? 'ar',
                          theme: theme.code,
                        );
                      }
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      padding: EdgeInsets.symmetric(
                        vertical: screenHeight * 0.02,
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
                          Icon(
                            iconData,
                            color: isSelected
                                ? AppColors.primaryColor
                                : Colors.grey.shade700,
                            size: 28,
                          ),
                          SizedBox(height: screenHeight * 0.01),
                          Text(
                            theme.name,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: isSelected
                                  ? AppColors.primaryColor
                                  : Colors.grey.shade700,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          if (isSelected)
                            Padding(
                              padding: const EdgeInsets.only(top: 4),
                              child: Icon(
                                Icons.check_circle,
                                color: AppColors.primaryColor,
                                size: 16,
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
