import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsHeaderWidget extends StatelessWidget {
  final double screenWidth;
  final double screenHeight;

  const SettingsHeaderWidget({
    super.key,
    required this.screenWidth,
    required this.screenHeight,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.05,
        vertical: screenHeight * 0.02,
      ),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios, size: 20),
              onPressed: () => Get.back(),
            ),
          ),
          const Spacer(),
          const Text(
            'الإعدادات',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          SizedBox(width: screenWidth * 0.1),
        ],
      ),
    );
  }
}
