import 'package:flutter/material.dart';

class ResultInfoBlock extends StatelessWidget {
  final Size size;
  final String title;
  final String value;
  final IconData icon;

  const ResultInfoBlock({
    super.key,
    required this.size,
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final font = size.width * 0.033;

    return Container(
      padding: EdgeInsets.all(size.width * 0.03),
      decoration: BoxDecoration(
        color: const Color(0xffFAFAFA),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: Colors.black54,
            size: size.width * 0.05,
          ),
          SizedBox(width: size.width * 0.03),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: font,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: size.height * 0.005),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: font,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}