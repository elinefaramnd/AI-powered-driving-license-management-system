import 'package:flutter/material.dart';

class DocumentHint extends StatelessWidget {
  final String code;

  const DocumentHint({
    super.key,
    required this.code,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final w = size.width;
    final h = size.height;
    return Row(
      mainAxisAlignment:
      MainAxisAlignment.end,
      children: [

        Expanded(
          child: Text(
            _hint(code),
            textAlign: TextAlign.right,
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: w * 0.03,
            ),
          ),
        ),

         SizedBox(width:  w * 0.015),

        Icon(
          Icons.info_outline,
          size:  w * 0.041,
          color: Colors.orange.shade700,
        ),
      ],
    );
  }

  String _hint(String code) {
    switch (code) {
      case "personal_photo":
        return "يجب أن تكون الصورة حديثة بخلفية بيضاء وواضحة";

      case "national_id_copy":
        return "يجب أن تكون صورة الهوية واضحة";

      case "medical_report":
        return "يجب أن يكون التقرير الطبي معتمداً وساري المفعول";

      case "blood_donation_certificate":
        return "يجب أن تكون شهادة التبرع بالدم صادرة من جهة معتمدة";

      default:
        return "يرجى التأكد من وضوح المستند قبل الرفع";
    }
  }
}