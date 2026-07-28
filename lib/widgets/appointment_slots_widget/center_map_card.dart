import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import '../../app_theme/app_colors.dart';

class CenterMapCard extends StatelessWidget {
  final dynamic center;
  final VoidCallback onMapPressed;

  const CenterMapCard({
    super.key,
    required this.center,
    required this.onMapPressed,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isRtl = Directionality.of(context) == TextDirection.rtl;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: size.width * .04),
      decoration: BoxDecoration(
        color: const Color(0xffF2F4F7),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade300, width: .8),
      ),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [


            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.verified_user,
                          color: AppColors.primaryColor,
                          size: size.width * .058,
                        ),
                        SizedBox(width: size.width * .015),
                        Text(
                          center["name"] ?? "",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: size.width * .042,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: size.height * .008),
                    Padding(
                      padding: EdgeInsets.only(right: size.width * .07),
                      child: Text(
                        center["address"] ?? "",
                        textAlign:
                        isRtl ? TextAlign.right : TextAlign.left,
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: size.width * .031,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(width: size.width * .04),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: const DecorationImage(
                  image: AssetImage("assets/images/background.png"),
                  fit: BoxFit.cover,
                  opacity: 0.46,
                ),
              ),
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: size.width * .02,
                  vertical: size.height * .01,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white.withOpacity(0.7),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.location_on,
                      color: AppColors.primaryColor,
                      size: size.width * .08,
                    ),
                    SizedBox(height: size.height * .01),
                    InkWell(
                      onTap: onMapPressed,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: size.width * .03,
                          vertical: size.height * .007,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "view_map".tr,
                              style: TextStyle(
                                color: AppColors.primaryColor,
                                fontWeight: FontWeight.w600,
                                fontSize: size.width * .03,
                              ),
                            ),
                            SizedBox(width: size.width * .01),
                            Icon(
                              Icons.map_outlined,
                              size: size.width * .035,
                              color: AppColors.primaryColor,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
