import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileErrorText extends StatelessWidget {
  final RxString error;

  const ProfileErrorText({super.key, required this.error});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => error.value.isNotEmpty
          ? Padding(
              padding: const EdgeInsets.only(top: 4, right: 8),

              child: Text(
                error.value,

                style: const TextStyle(color: Colors.red, fontSize: 12),
              ),
            )
          : const SizedBox(),
    );
  }
}
