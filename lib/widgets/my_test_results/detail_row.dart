import 'package:flutter/material.dart';

class DetailRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color valueColor;

  const DetailRow({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    required this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Row(
      children: [
        Icon(
          icon,
          size: size.width * .05,
        ),

        SizedBox(
          width: size.width * .025,
        ),

        Text(
          label,
          style: TextStyle(
            fontSize: size.width * .033,
          ),
        ),

        const Spacer(),

        Flexible(
          child: Text(
            value,
            textAlign: TextAlign.end,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: valueColor,
              fontSize: size.width * .033,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}