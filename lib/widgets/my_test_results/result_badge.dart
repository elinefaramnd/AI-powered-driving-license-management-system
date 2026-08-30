import 'package:flutter/material.dart';

class ResultBadge extends StatelessWidget {
  final Size size;
  final String text;
  final Color mainColor;
  final bool isPassed;
  final bool isFailed;
  final bool isArabic;

  const ResultBadge({
    super.key,
    required this.size,
    required this.text,
    required this.mainColor,
    required this.isPassed,
    required this.isFailed,
    required this.isArabic,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: size.width * 0.04,
        vertical: size.height * 0.009,
      ),
      decoration: BoxDecoration(
        color: mainColor,
        borderRadius: BorderRadius.circular(50),
        boxShadow: [
          BoxShadow(
            color: mainColor.withOpacity(0.25),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        textDirection:
        isArabic ? TextDirection.rtl : TextDirection.ltr,
        children: [
          Icon(
            isPassed
                ? Icons.check
                : isFailed
                ? Icons.close
                : Icons.hourglass_empty,
            color: Colors.white,
            size: size.width * 0.04,
          ),
          SizedBox(width: size.width * 0.015),
          Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontSize: size.width * 0.035,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}