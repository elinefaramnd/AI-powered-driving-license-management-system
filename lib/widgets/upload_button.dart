
import 'package:flutter/material.dart';

import '../app_theme/app_colors.dart';

class UploadButton extends StatelessWidget {
  final dynamic controller;
  final dynamic doc;
  final bool uploaded;

  const UploadButton({
    required this.controller,
    required this.doc,
    required this.uploaded,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: controller.submitted.value
              ? Colors.grey.shade400
              : AppColors.primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        onPressed: controller.submitted.value
            ? null
            : () async {
          await controller.uploadDocument(doc["id"]);
        },
        child: Text(
          uploaded ? "تغيير" : "رفع",
          style: TextStyle(
            color: controller.submitted.value
                ? Colors.white70
                : Colors.white,
          ),
        ),
      ),
    );
  }
}