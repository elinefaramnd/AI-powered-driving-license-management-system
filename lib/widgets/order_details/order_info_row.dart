import 'package:flutter/material.dart';
import '../../../app_theme/app_colors.dart';

class OrderInfoRow extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const OrderInfoRow({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final isRtl = Directionality.of(context) == TextDirection.rtl;
    return Padding(
      padding:  EdgeInsets.symmetric(
        horizontal: w * 0.044, // 16
        vertical: w * 0.028,
      ),
      child: Row(
        children: [
          Container(
            width: w * 0.085,
            height: w * 0.085,
            decoration: BoxDecoration(
              color: const Color(0xffF2F7F6),
              borderRadius: BorderRadius.circular( w * 0.035),
            ),
            child: Icon(
              icon,
              color: AppColors.primaryColor,
              size: w * 0.055,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style:  TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize:isRtl? w * 0.042:w * 0.039,
                ),
              ),
            ],
          ),
           SizedBox(width: w * 0.036),
          Expanded(
            child: Text(
              value,
              textAlign: isRtl ? TextAlign.left : TextAlign.right,
              style:  TextStyle(
                fontWeight: FontWeight.w500,
                fontSize:isRtl? w * 0.036:w * 0.033,
              ),
            ),
          ),
        ],
      ),
    );
  }
}