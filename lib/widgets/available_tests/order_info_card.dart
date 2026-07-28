import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../app_theme/app_colors.dart';
import '../../modules/appointment/AvailableTestsController.dart';
import '../../modules/home_page/home_controller.dart';

class OrderInfoCard extends StatelessWidget {
  const OrderInfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final homeController = Get.find<HomeController>();
    final availableController = Get.find<AvailableTestsController>();
    final iconSize = size.width * 0.14;
    final radius = size.width * 0.04;
    final dividerHeight = size.height * 0.07;

    return Container(
      padding: EdgeInsets.all(size.width * 0.055),
      decoration: _box(radius),
      child: Row(
        children: [
          _icon(iconSize, radius),
          SizedBox(width: size.width * 0.03),
          _divider(dividerHeight),
          SizedBox(width: size.width * 0.03),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _rich(context, "application_number".tr,
                  homeController.currentApplicationNumber.value.isEmpty
                      ? "-"
                      : homeController.currentApplicationNumber.value,),
                _rich(context,  "current_status".tr, homeController.getCurrentStatusText(),),
                _rich(context, "current_available_test".tr,  availableController.getCurrentAvailableTest(),),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _icon(double size, double radius) => Container(
    width: size,
    height: size,
    decoration: BoxDecoration(
      color: AppColors.primaryColor.withOpacity(.08),
      borderRadius: BorderRadius.circular(radius),
    ),
    child: Icon(Icons.description_outlined,
        color: AppColors.primaryColor, size: size * 0.5),
  );
  Widget _divider(double height) =>
      Container(width: 1, height: height, color: Colors.grey.shade300);
  Widget _rich(BuildContext context, String a, String b) {
    final size = MediaQuery.of(context).size;
    final isRtl = Get.locale?.languageCode == "ar";
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: a,
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: isRtl?size.width * 0.036:size.width * 0.032,
            ),
          ),
          WidgetSpan(child: SizedBox(width: size.width * 0.01)),
          TextSpan(
            text: b,
            style: TextStyle(
              color: AppColors.primaryColor,
              fontWeight: FontWeight.bold,
              fontSize: size.width * 0.035,
            ),
          ),
        ],
      ),
    );
  }
  BoxDecoration _box(double radius) => BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(radius),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(.04),
        blurRadius: 10,
        offset: const Offset(0, 4),
      ),
    ],
  );
}