import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import '../../app_theme/app_colors.dart';

class CenterCard extends StatelessWidget {
  final String testName;
  final String centerName;

  const CenterCard({
    super.key,
    required this.testName,
    required this.centerName,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isRtl = Directionality.of(context) == TextDirection.rtl;
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: size.width * .04,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: size.width * .04,
        vertical: size.height * .018,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(size.width * 0.05),
      ),
      child: Row(
        children: [
          Expanded(
            child: Row(
              children: [
                Icon(
                  Icons.location_on_outlined,
                  color: AppColors.gold,
                  size: size.width * 0.06,
                ),
                Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    Text(
                      centerName,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: size.width * .036,
                      ),
                    ),
                    SizedBox(height: size.height * 0.005),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                    "test_center".tr,
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: size.width * .03,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            width: 1,
            height:  size.height * 0.05,
            color: Colors.grey.shade300,
          ),
          SizedBox(width: size.width * 0.01),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.menu_book_rounded,
                  color: AppColors.gold,
                  size: size.width * 0.06,
                ),
                SizedBox(width:size.width * .03 ,),
                Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    Text(
                      testName,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: size.width * .036,
                      ),
                    ),
                    SizedBox(height: size.height * 0.005),
                    Text(
                      "test_type".tr,
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: size.width * .03,
                      ),
                    ),
                  ],
                ),


              ],
            ),
          ),
        ],
      ),
    );
  }
}