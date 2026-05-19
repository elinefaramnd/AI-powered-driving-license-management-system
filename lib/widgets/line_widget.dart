import 'package:flutter/material.dart';

class LineWidget extends StatelessWidget {
  const LineWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 28),
        child: Container(
          height: 1.5,
          color: Colors.grey.shade300,
        ),
      ),
    );
  }
}