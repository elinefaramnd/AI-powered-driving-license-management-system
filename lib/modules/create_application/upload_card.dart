import 'dart:io';

import 'package:flutter/material.dart';

import '../../../app_theme/app_colors.dart';

class UploadCard extends StatelessWidget {
  final String title;

  final File? file;

  final VoidCallback onUpload;

  const UploadCard({
    super.key,
    required this.title,
    required this.file,
    required this.onUpload,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 18),

      padding: const EdgeInsets.all(18),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius: BorderRadius.circular(22),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.04),

            blurRadius: 14,

            offset: const Offset(0, 6),
          ),
        ],
      ),

      child: Row(
        children: [
          Container(
            width: 60,

            height: 60,

            decoration: BoxDecoration(
              color: const Color(0xffF4F4F2),

              borderRadius: BorderRadius.circular(16),
            ),

            child: file == null
                ? Icon(Icons.description_outlined, color: AppColors.primary)
                : ClipRRect(
                    borderRadius: BorderRadius.circular(16),

                    child: Image.file(file!, fit: BoxFit.cover),
                  ),
          ),

          const SizedBox(width: 18),

          Expanded(
            child: Text(
              title,

              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),

          InkWell(
            onTap: onUpload,

            child: Container(
              padding: const EdgeInsets.all(12),

              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(.08),

                borderRadius: BorderRadius.circular(14),
              ),

              child: Icon(Icons.upload, color: AppColors.primary),
            ),
          ),
        ],
      ),
    );
  }
}
