import 'package:flutter/material.dart';

class ResultFooter extends StatelessWidget {
  final Size size;

  const ResultFooter({
    super.key,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    final smallFont = size.width * 0.03;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.lock,
          size: size.width * 0.04,
          color: Colors.grey,
        ),
        SizedBox(width: size.width * 0.015),
        Text(
          "بياناتك محمية وآمنة وفق أعلى المعايير",
          style: TextStyle(
            fontSize: smallFont,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}