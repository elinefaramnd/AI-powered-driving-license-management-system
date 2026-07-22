import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import '../../app_theme/app_colors.dart';

class RemainingDocs extends StatelessWidget {
  final dynamic controller;
  const RemainingDocs({super.key, required this.controller});
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final w = size.width;
    final h = size.height;
    final total = controller.documents.length;
    final uploaded = controller.uploadedCount;
    final remaining = controller.remaining;
    final percent = total == 0 ? 0 : ((uploaded / total) * 100).round();
    return Container(
      margin: EdgeInsets.symmetric(vertical:w * 0.02,horizontal: w * 0.04),
      padding: EdgeInsets.all(w * 0.015),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(w * 0.025),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(.04), blurRadius: w * 0.025),
        ],
      ),
      child: Row(
        children: [
          SizedBox(
            width: w * 0.22,
            height: w * 0.22,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Transform.scale(
                  scale: 1.7,
                  child: CircularProgressIndicator(
                    value: total == 0 ? 0 : uploaded / total,
                    strokeWidth: w * 0.006,
                    color: AppColors.primaryColor,
                    backgroundColor: Colors.grey.shade300,
                  ),
                ),
                Text(
                  "$percent%",
                  style:  TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: w * 0.052,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: w * 0.025),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "completed_documents"
                      .trParams({
                    "uploaded": "$uploaded",
                    "total": "$total",
                  }),
                  style: TextStyle(
                    fontSize: w * 0.044,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: h * 0.001),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.description_outlined,
                      size: w * 0.032,
                      color: Colors.orange.shade700,
                    ),
                    SizedBox(width: w * 0.015),
                    Text(
                      "remaining_documents".tr
                          .trParams({"count": "$remaining"}),
                      style: TextStyle(
                        fontSize: w * 0.038,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                 SizedBox(height:  h * 0.01),
                Text(
                  textAlign: TextAlign.start,
                  "upload_all_documents".tr,
                  style: TextStyle(color: Colors.grey.shade600, fontSize: w * 0.033),
                ),
              ],
            ),
          ),
          Image.asset(
            "assets/images/document.png",
            width: w * 0.27,
            height: w * 0.27,
            fit: BoxFit.contain,
          ),

        ],
      ),
    );
  }
}
