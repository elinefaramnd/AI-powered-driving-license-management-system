import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class DocumentHint extends StatelessWidget {
  final String code;

  const DocumentHint({
    super.key,
    required this.code,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isRtl = Directionality.of(context) == TextDirection.rtl;

    final w = size.width;
    final h = size.height;
    return Row(
      mainAxisAlignment:
      MainAxisAlignment.start,
      children: [
        Icon(
          Icons.info_outline,
          size:  w * 0.041,
          color: Colors.orange.shade700,
        ),
         SizedBox(width:  w * 0.015),
        Expanded(
          child: Text(
            _hint(code),
            textAlign: isRtl?TextAlign.right:TextAlign.left,
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: w * 0.03,
            ),
          ),
        ),
      ]
    );
  }

  String _hint(String code) {
    switch (code) {
      case "personal_photo":
        return "hint_personal_photo".tr;

      case "national_id_copy":
        return "hint_national_id".tr;

      case "medical_report":
        return "hint_medical_report".tr;

      case "blood_donation_certificate":
        return "hint_blood_certificate".tr;

      default:
        return "hint_default_document".tr;
    }
  }
}
