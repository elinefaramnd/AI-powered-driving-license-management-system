import 'package:flutter/material.dart';
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
                Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.end,
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
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "مركز الاختبار",
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: size.width * .03,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Icon(
                  Icons.location_on_outlined,
                  color: AppColors.gold,
                  size: size.width * 0.06,
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
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.end,
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
                      "نوع الاختبار",
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: size.width * .03,
                      ),
                    ),
                  ],
                ),
                SizedBox(width:size.width * .03 ,),
                Icon(
                  Icons.menu_book_rounded,
                  color: AppColors.gold,
                  size: size.width * 0.06,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}