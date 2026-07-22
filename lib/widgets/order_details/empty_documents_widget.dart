import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class EmptyDocumentsWidget extends StatelessWidget {
  const EmptyDocumentsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: h * 0.037,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(w * 0.04),
        border: Border.all(
          color: const Color(0xffE9ECEF),
        ),
      ),
      child: Column(
        children: [
          Icon(
            Icons.folder_off_outlined,
            size: w * 0.125,
            color: Colors.grey.shade400,
          ),
           SizedBox(height:  h * 0.015),
           Text(
             "no_uploaded_documents".tr,
            style: TextStyle(
              fontSize: w * 0.04,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height:  h * 0.007),
          Text(
            "upload_required_documents".tr,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize:  w * 0.033,
            ),
          ),
        ],
      ),
    );
  }
}