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
    return Padding(
      padding:  EdgeInsets.symmetric(
        horizontal: w * 0.044, // 16
        vertical: w * 0.028,
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.left,
              style:  TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: w * 0.036,
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                title,
                style:  TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize:  w * 0.042,
                ),
              ),
            ],
          ),
           SizedBox(width: w * 0.036),
          Container(
            width: w * 0.097,
            height: w * 0.097,
            decoration: BoxDecoration(
              color: const Color(0xffF2F7F6),
              borderRadius: BorderRadius.circular( w * 0.035),
            ),
            child: Icon(
              icon,
              color: AppColors.primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}