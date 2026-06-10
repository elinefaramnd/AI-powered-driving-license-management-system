import 'package:flutter/material.dart';

import '../../app_theme/app_colors.dart';

class DocumentFileInfo extends StatelessWidget {
  final dynamic latest;

  const DocumentFileInfo({super.key, required this.latest});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final w = size.width;
    final h = size.height;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: w * 0.025, vertical: h * 0.003),
      decoration: BoxDecoration(
        color: const Color(0xffF8FAF9),
        borderRadius: BorderRadius.circular(w * 0.03),
        border: Border.all(color: const Color(0xffE3E8ED)),
      ),
      child: Row(
        children: [
          Container(
            width: w * 0.082,
            height: w * 0.082,
            decoration: const BoxDecoration(
              color: Color(0xffE8F5EC),
              shape: BoxShape.circle,
            ),
            child:  Icon(
              Icons.check,
              color: AppColors.primaryColor,
              size: w * 0.046,
            ),
          ),

           SizedBox(width: w * 0.05),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  latest?["original_name"] ?? "ملف مرفوع",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style:  TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: w * 0.035,
                  ),
                ),

                Text(
                  "تم الرفع بنجاح",
                  style: TextStyle(color: Colors.grey.shade600, fontSize:  w * 0.029),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
