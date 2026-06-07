import 'package:flutter/material.dart';

import 'document_file_info.dart';
import 'document_header.dart';
import 'document_hint.dart';
import 'document_icon_box.dart';

class DocumentCard extends StatelessWidget {
  final dynamic doc;
  final dynamic controller;
  final bool uploaded;

  const DocumentCard({
    super.key,
    required this.doc,
    required this.controller,
    required this.uploaded,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final w = size.width;
    final h = size.height;
    final latest = doc["latest_document"];

    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: w * 0.041,
        vertical: h * 0.0035,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: w * 0.041,
        vertical: h * 0.014,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(w * 0.038),
        border: Border.all(
          color: Colors.white,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.04),
            blurRadius:  w * 0.025,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Expanded(
                child: DocumentHeader(
                  doc: doc,
                  controller: controller,
                  uploaded: uploaded,
                ),
              ),

              DocumentIconBox(
                code: doc["code"],
                name: doc["name"],
              ),
            ],
          ),

           SizedBox(height:  h * 0.014),

          if (uploaded)
            DocumentFileInfo(latest: latest),

          if (!uploaded)
            DocumentHint(code: doc["code"]),
        ],
      ),
    );
  }
}