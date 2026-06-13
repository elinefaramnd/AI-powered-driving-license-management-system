import 'package:flutter/material.dart';
import 'package:project_2/app_theme/app_colors.dart';
import '../../modules/privacy_policy/privacy_policy_controller.dart';

class PrivacyPolicyErrorWidget extends StatelessWidget {
  final double w;
  final PrivacyPolicyController controller;

  const PrivacyPolicyErrorWidget({
    super.key,
    required this.w,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, color: Colors.red, size: 48),
          const SizedBox(height: 12),
          Text(
            controller.errorMessage.value,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: w * 0.04, color: Colors.grey.shade700),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: controller.fetchPrivacyPolicy,
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.mediumGreen),
            child: const Text('إعادة المحاولة',
                style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
