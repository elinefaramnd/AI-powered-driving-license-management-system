import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const CustomAppBar({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      automaticallyImplyLeading: false,

      title: Text(
        title,
        style: TextStyle(
          fontSize: size.width * 0.055,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),

      actions: [
        IconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            Icons.arrow_forward,
            color: Colors.black,
            size: size.width * 0.06,
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}