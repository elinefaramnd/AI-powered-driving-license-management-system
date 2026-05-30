import 'package:flutter/material.dart';
import '../../app_theme/app_colors.dart';

class ApplicationHeader extends StatelessWidget {
  final Size size;
  const ApplicationHeader({super.key, required this.size});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Container(
            width: size.width * .14,
            height: size.width * .14,
            decoration: BoxDecoration(
              color: const Color(0xffF3F5F4),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.description_outlined,
              size: size.width * .06,
              color: AppColors.primary,
            ),
          ),

          SizedBox(height: size.height * .015),

          Text(
            "تقديم طلب جديد",
            style: TextStyle(
              fontSize: size.width * .06,
              fontWeight: FontWeight.w700,
              color: AppColors.primary,
            ),
          ),

          SizedBox(height: size.height * .01),

          Text(
            "يرجى اختيار نوع الخدمة ونوع الرخصة لاستكمال تقديم الطلب",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: size.width * .032,
            ),
          ),
        ],
      ),
    );
  }
}
