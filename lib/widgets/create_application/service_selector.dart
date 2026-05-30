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
    final controller = Get.find<ApplicationController>();
    return Obx(
      () => SizedBox(
        height: size.height * .17,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          reverse: true,
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
                    vertical: size.height * .02,
                    horizontal: size.width * .03,
                  ),
                  decoration: BoxDecoration(
                    color: selected ? const Color(0xffF3FBF8) : Colors.white,
                    borderRadius: BorderRadius.circular(size.width * .045),
                    border: Border.all(
                      color: selected
                          ? AppColors.primary
                          : Colors.grey.shade300,
                      width: selected ? 2 : 1,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: size.width * .11,
                        height: size.width * .11,
                        decoration: BoxDecoration(
                          color: AppColors.primary.withOpacity(.12),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          getIcon(e["code"]),
                          color: AppColors.primary,
                          size: size.width * .05,
                        ),
                      ),
                      SizedBox(height: size.height * .015),
                      Text(
                        e["name"],
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: size.width * .031,
                          color: selected ? AppColors.primary : Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            });
          },
        ),
      ),
    );
  }
}
