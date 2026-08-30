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
          Transform.scale(
            scale: 1.2,
            child: Image.asset(
              "assets/images/submit_an_application.jpg",
              width: size.width * .5,
              height: size.height * .15,
              fit: BoxFit.contain,
            ),
          ),
          SizedBox(height: size.height * .012),
          Text(
            "submit_new_application".tr,
            style: TextStyle(
              fontSize: size.width * .045,
              fontWeight: FontWeight.w700,
              color: AppColors.primaryColor,
            ),
          ),
          SizedBox(height: size.height * .008),
          Text(
            "submit_new_application_description".tr,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: size.width * .031,
            ),
          ),
        ],
      ),
    );
  }
}
