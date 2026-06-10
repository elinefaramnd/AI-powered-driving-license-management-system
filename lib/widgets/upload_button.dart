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
    print("uploaded = $uploaded");
    return SizedBox(
      height: 42,
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: uploaded ? Colors.white : AppColors.primaryColor,

          foregroundColor: uploaded ? AppColors.primaryColor : Colors.white,

          side: BorderSide(
            color: uploaded ? AppColors.primaryColor : Colors.transparent,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        onPressed: controller.submitted.value
            ? null
            : () async {
                await controller.uploadDocument(doc["id"]);
              },
        child: Text(uploaded ? "استبدال الملف" : "رفع الملف"),
      ),
    );
  }
}
