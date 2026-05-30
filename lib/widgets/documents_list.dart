import 'package:flutter/material.dart';
import 'package:project_2/widgets/upload_button.dart';

import '../app_theme/app_colors.dart';
import 'document_row.dart';

class DocumentsList extends StatelessWidget {
  final dynamic controller;

  const DocumentsList({required this.controller});

  bool _isUploaded(dynamic doc) {
    return controller.uploadedIds.contains(doc["id"]) ||
        doc["latest_document"] != null;
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: controller.documents.length,
      itemBuilder: (_, index) {
        final doc = controller.documents[index];
        final uploaded = _isUploaded(doc);

        return Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 10,
          ),
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(22),
            border: Border.all(
              color: uploaded
                  ? AppColors.primaryColor
                  : Colors.grey.shade300,
              width: 2,
            ),
          ),
          child: Column(
            children: [
              DocumentRow(doc: doc, uploaded: uploaded),
              const SizedBox(height: 20),
              UploadButton(
                controller: controller,
                doc: doc,
                uploaded: uploaded,
              ),
            ],
          ),
        );
      },
    );
  }
}