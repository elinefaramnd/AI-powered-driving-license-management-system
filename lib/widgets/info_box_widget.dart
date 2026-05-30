import 'package:flutter/material.dart';

class InfoBoxWidget extends StatelessWidget {
  final String title;

  const InfoBoxWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(child: Text(title)),
    );
  }
}
