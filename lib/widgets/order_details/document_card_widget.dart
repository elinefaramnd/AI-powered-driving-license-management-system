import 'package:flutter/material.dart';
import '../../app_theme/app_colors.dart';

class DocumentItemWidget extends StatelessWidget {
  final Map<String, dynamic> document;
  const DocumentItemWidget({super.key, required this.document});
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final w = size.width;
    final h = size.height;
    return Container(
      margin: EdgeInsets.only(bottom: h * 0.005),
      padding: EdgeInsets.symmetric(
        horizontal: w * 0.035,
        vertical: h * 0.006,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(w * 0.04),
        border: Border.all(color: const Color(0xffE9ECEF)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: w * 0.025,
            offset: Offset(0, h * 0.005),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: w * 0.105,
            height: w * 0.13,
            decoration: BoxDecoration(
              color: const Color(0xffE9F7EF),
              borderRadius: BorderRadius.circular(w * 0.03),
            ),
            child: Icon(
              Icons.picture_as_pdf_outlined,
              size: w * 0.05,
              color: AppColors.primaryColor,
            ),
          ),
           SizedBox(width: w * 0.03),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  document["required_document"]?["name"] ?? "-",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: w * 0.035,
                  ),
                ),

                SizedBox(height: h * 0.004),

                Text(
                  document["original_name"] ?? "",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.grey.shade600, fontSize: w * 0.03),
                ),
              ],
            ),
          ),
          SizedBox(width: w * 0.02),
          Container(
            padding: EdgeInsets.all(w * 0.01),
            decoration: BoxDecoration(
              color: Color(0xffE9F7EF),
              borderRadius: BorderRadius.circular(w * 0.05),
            ),
            child: Icon(
              Icons.check_circle,
              color: AppColors.primaryColor,
              size: w * 0.045,
            ),
          ),
        ],
      ),
    );
  }
}
