import 'package:flutter/material.dart';
import 'document_card.dart';

class DocumentsList extends StatelessWidget {
  final dynamic controller;
  const DocumentsList({
    super.key,
    required this.controller,
  });

  bool _isUploaded(dynamic doc) {
    final latest = doc["latest_document"];
    return controller.uploadedIds.contains(doc["id"]) ||
        (latest != null &&
            latest is Map &&
            latest.isNotEmpty);
  }
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final w = size.width;
    final h = size.height;
    return ListView.builder(
      itemCount: controller.documents.length,
      itemBuilder: (_, index) {
        final doc = controller.documents[index];
        return DocumentCard(
          doc: doc,
          controller: controller,
          uploaded: _isUploaded(doc),
        );
      },
    );
  }
}