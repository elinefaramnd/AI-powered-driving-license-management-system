import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
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
            "submit_new_application".tr,
            style: TextStyle(
              fontSize: size.width * .06,
              fontWeight: FontWeight.w700,
              color: AppColors.primary,
            ),
          ),

          SizedBox(height: size.height * .01),

          Text(
            "submit_new_application_description".tr,
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
