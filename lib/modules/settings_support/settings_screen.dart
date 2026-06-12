import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'settings_controller.dart';
import '../../widgets/settings_widget/settings_header_widget.dart';
import '../../widgets/settings_widget/account_info_card_widget.dart';
import '../../widgets/settings_widget/language_card_widget.dart';
import '../../widgets/settings_widget/theme_card_widget.dart';
import '../../widgets/settings_widget/settings_action_tile_widget.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({super.key});

  final SettingsController controller = Get.put(SettingsController());

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      body: SafeArea(
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          final account = controller.settings.value?.account;
          final preferences = controller.settings.value?.preferences;
          final languages = controller.settings.value?.availableLanguages ?? [];
          final themes = controller.settings.value?.availableThemes ?? [];

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SettingsHeaderWidget(
                  screenWidth: screenWidth,
                  screenHeight: screenHeight,
                ),

                AccountInfoCardWidget(
                  screenWidth: screenWidth,
                  screenHeight: screenHeight,
                  account: account,
                  controller: controller,
                ),

                SizedBox(height: screenHeight * 0.025),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE8F5E9),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(Icons.tune, color: Colors.grey.shade700, size: 22),
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'التفضيلات',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: screenHeight * 0.015),

                LanguageCardWidget(
                  screenWidth: screenWidth,
                  screenHeight: screenHeight,
                  languages: languages,
                  preferences: preferences,
                  controller: controller,
                ),

                SizedBox(height: screenHeight * 0.015),

                ThemeCardWidget(
                  screenWidth: screenWidth,
                  screenHeight: screenHeight,
                  themes: themes,
                  preferences: preferences,
                  controller: controller,
                ),

                SizedBox(height: screenHeight * 0.025),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE8F5E9),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(Icons.more_horiz, color: Colors.grey.shade700, size: 22),
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'أخرى',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: screenHeight * 0.015),

                ChangePasswordTileWidget(
                  screenWidth: screenWidth,
                  screenHeight: screenHeight,
                ),

                SizedBox(height: screenHeight * 0.012),

              
               
              ],
            ),
          );
        }),
      ),
    );
  }
}
