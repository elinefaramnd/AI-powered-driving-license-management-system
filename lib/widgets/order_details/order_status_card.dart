import 'package:flutter/material.dart';
import '../../../app_theme/app_colors.dart';

class OrderStatusCard extends StatelessWidget {
  const OrderStatusCard({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final w = size.width;
    final h = size.height;
    return Container(
      width: double.infinity,
      height: h * 0.17,
      padding: EdgeInsets.symmetric(
        horizontal: w * 0.05,
        vertical: h * 0.015,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(w * 0.025),
        color: AppColors.primaryColor,
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                 Text(
                  "المستندات مكتملة",
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: w * 0.044,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                 Text(
                  "تم استلام جميع المستندات بنجاح\nوجارٍ مراجعة طلبك من قبل المختصين",
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: Colors.white,
                    height: 1.5,
                    fontSize: w * 0.029,
                  ),
                ),
                SizedBox(height:  h * 0.019),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: w * 0.013,
                    vertical: h * 0.0012,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(w * 0.075),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "قيد المراجعة",
                        style: TextStyle(
                          color: Color(0xff1B5E20),
                          fontWeight: FontWeight.bold,
                          fontSize: w * 0.035,
                        ),
                      ),
                      SizedBox(width:  w * 0.013),
                      Icon(
                        Icons.check_circle,
                        color: AppColors.primaryColor,
                        size: w * 0.05,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width:  w * 0.038),
          Image.asset(
            "assets/images/download1.png",
            width: w * 0.32,
            height: w * 0.32,
            fit: BoxFit.contain,
          ),
        ],
      ),
    );
  }
}