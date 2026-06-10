import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileErrorText extends StatelessWidget {
  final RxString error;

  const ProfileErrorText({super.key, required this.error});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Obx(
      () => error.value.isNotEmpty
          ? Padding(
              padding: EdgeInsets.only(top: size.height * 0.005,
                right: size.width * 0.02,),

              child: Text(
                error.value,

                style: TextStyle(color: Colors.red,  fontSize: size.width * 0.03,),
              ),
            )
          : const SizedBox(),
    );
  }
}
