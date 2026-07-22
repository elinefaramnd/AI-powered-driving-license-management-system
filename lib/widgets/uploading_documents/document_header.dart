import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import '../../app_theme/app_colors.dart';

class DocumentHeader extends StatelessWidget {
  final dynamic doc;
  final dynamic controller;
  final bool uploaded;

  const DocumentHeader({
    super.key,
    required this.doc,
    required this.controller,
    required this.uploaded,
  });
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isRtl = Directionality.of(context) == TextDirection.rtl;
    final w = size.width;
    final h = size.height;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(top: h * .006,
                  right: isRtl ? h * .007 : 0,
                  left: isRtl ? 0 : h * .007,),
                child: Text(
                  doc["name"],
                  textAlign:  isRtl ? TextAlign.right : TextAlign.left,
                  style: TextStyle(
                    fontSize: w * 0.036,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                  horizontal: w * 0.03,
                  vertical: h * 0.005
              ),
              decoration: BoxDecoration(
                color: uploaded
                    ? const Color(0xffE8F5EC)
                    : const Color(0xffF9F3DD),
                borderRadius: BorderRadius.circular(w * 0.05),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    uploaded
                        ? Icons.check_circle
                        : Icons.error_outline,
                    size:  w * 0.036,
                    color: uploaded
                        ? AppColors.primaryColor
                        : const Color(0xffB08A42),
                  ),
                  SizedBox(width: w * 0.01),
                  Text(
                    uploaded  ? "uploaded".tr: "required".tr,
                    style: TextStyle(
                      color: uploaded
                          ? AppColors.primaryColor
                          : const Color(0xffB08A42),
                      fontWeight: FontWeight.bold,
                      fontSize: w * 0.031,
                    ),
                  ),


                ],
              ),
            ),
          ],
        ),

         SizedBox(height:  h * 0.014),
        Row(
          mainAxisAlignment:
          MainAxisAlignment.spaceBetween,
          children: [
            Transform.translate(
              offset: Offset( isRtl ? -w * .02 : w * .02,
                -h * .012,),
              child: Text(
                "PDF,JPG,JPEG,PNG",
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: w * 0.03,
                ),
              ),
            ),
            SizedBox(
              width: w * 0.37,
              height: 35,
              child: ElevatedButton.icon(
                onPressed: () async {
                  await controller.uploadDocument(
                    doc["id"],
                  );
                },
                iconAlignment: IconAlignment.start,
                icon: Icon(
                  uploaded ? Icons.sync_alt
                      : Icons.upload,
                  size: w * 0.04,
                ),
                label: Text(
                  uploaded ? "replace_file".tr : "upload_file".tr,
                  style: TextStyle(
                    fontSize: w * 0.037,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(w * 0.02),
                  ),
                  backgroundColor: uploaded ? Colors.white
                      : AppColors.primaryColor,
                  foregroundColor: uploaded ? AppColors.primaryColor
                      : Colors.white,
                  side: uploaded ? const BorderSide(
                    color:
                    AppColors.primaryColor,
                  )
                      : BorderSide.none,
                ),
              ),
            ),

          ],
        ),
      ],
    );
  }
}