import 'package:flutter/material.dart';

class DocumentItemWidget extends StatelessWidget {
  final Map<String, dynamic> document;
  const DocumentItemWidget({super.key, required this.document});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xffF7F7F7),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: Colors.green.withOpacity(.08),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.image_outlined,
              size: 18,
              color: Colors.green,
            ),
          ),

          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  document["required_document"]?["name"] ?? "-",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  document["original_name"] ?? "",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Colors.grey, fontSize: 11),
                ),
              ],
            ),
          ),

          const SizedBox(width: 6),

          const Icon(Icons.check_circle, color: Colors.green, size: 18),
        ],
      ),
    );
  }
}
