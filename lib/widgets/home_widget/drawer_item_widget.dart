import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app_theme/app_colors.dart';
import '../../modules/home_page/home_controller.dart';

class DrawerItemWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  final int index;
  final HomeController controller;
  final VoidCallback? onTap;

  const DrawerItemWidget({
    super.key,
    required this.icon,
    required this.title,
    required this.index,
    required this.controller,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Obx(
      () => Container(
        margin: EdgeInsets.symmetric(
          horizontal: size.width * 0.03,
          vertical: size.height * 0.005,
        ),
        decoration: BoxDecoration(
          color: controller.selectedIndex.value == index
              ? AppColors.primary
              : Colors.transparent,
          borderRadius: BorderRadius.circular(size.width * 0.025),
        ),

        child: ListTile(
          onTap: () {
            controller.selectMenu(index);
            if (onTap != null) {
              onTap!();
            }
          },
          leading: Icon(icon, color: Colors.white, size: size.width * 0.055),
          title: Text(
            title,
            style: TextStyle(
              color: Colors.white70,
              fontSize: size.width * 0.038,
            ),
          ),
        ),
      ),
    );
  }
}
