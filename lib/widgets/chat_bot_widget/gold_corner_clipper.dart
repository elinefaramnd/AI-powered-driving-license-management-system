import 'package:flutter/material.dart';

class GoldCornerClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(size.width, 0);
    path.lineTo(0, 0);
    path.lineTo(size.width, size.height);
    path.close();
    return path;
  }
  @override
  bool shouldReclip(
      covariant CustomClipper<Path> oldClipper,
      ) {
    return false;
  }
}