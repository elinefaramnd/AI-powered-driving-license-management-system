import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../app_theme/app_colors.dart';
import '../../modules/create_application/application_controller.dart';

class ServiceSelector extends StatelessWidget {
  final Size size;
  const ServiceSelector({super.key, required this.size});
  IconData getIcon(String code) {
    switch (code) {
      case "new_license":
        return Icons.note_add_outlined;
      case "renew_license":
        return Icons.autorenew;
      case "lost_replacement":
        return Icons.sync;
      case "damaged_replacement":
        return Icons.description_outlined;
      case "license_unblock":
        return Icons.lock_open_outlined;
      default:
        return Icons.grid_view;
    }
  }
  @override
  Widget build(BuildContext context) {
    final isRtl = Directionality.of(context) == TextDirection.rtl;
    final controller = Get.find<ApplicationController>();
    return Obx(
      () => SizedBox(
        height: size.height * .19,
        child: Directionality(
          textDirection: isRtl ? TextDirection.rtl : TextDirection.ltr,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: controller.services.length,
            separatorBuilder: (_, __) => SizedBox(width: size.width * .03),
            itemBuilder: (_, i) {
              final e = controller.services[i];
              return Obx(() {
                final selected = controller.serviceTypeId.value == e["id"];
                return GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    controller.serviceTypeId.value = e["id"];
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    width: size.width * .34,
                    padding: EdgeInsets.symmetric(
                      vertical: size.height * .012,
                      horizontal: size.width * .025,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(size.width * .025),
                      border: Border.all(
                        color: selected ? AppColors.gold : Colors.grey.shade300,
                        width: selected ? 1.6 : 1,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(.035),
                          blurRadius: 7,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: size.width * .105,
                          height: size.width * .105,
                          decoration: BoxDecoration(
                            color: AppColors.gold.withOpacity(.10),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: AppColors.gold.withOpacity(.35),
                              width: .8,
                            ),
                          ),
                          child: Icon(
                            getIcon(e["code"]),
                            color: AppColors.primaryColor,
                            size: size.width * .048,
                          ),
                        ),
                        SizedBox(height: size.height * .009),
                        Text(
                          e["name"],
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: size.width * .031,
                            color: AppColors.darkGreen,
                          ),
                        ),
                        SizedBox(height: size.height * .008),
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          width: size.width * .052,
                          height: size.width * .052,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: selected
                                ? AppColors.primaryColor
                                : Colors.transparent,
                            border: Border.all(
                              color: selected
                                  ? AppColors.primaryColor
                                  : Colors.grey.shade400,
                              width: 1.2,
                            ),
                          ),
                          child: selected
                              ? Icon(
                                  Icons.check,
                                  color: Colors.white,
                                  size: size.width * .032,
                                )
                              : null,
                        ),
                      ],
                    ),
                  ),
                );
              });
            },
          ),
        ),
      ),
    );
  }
}
