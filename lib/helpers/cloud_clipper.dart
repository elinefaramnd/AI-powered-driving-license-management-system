import 'package:flutter/material.dart';

import '../app_theme/app_colors.dart';

class CloudClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(size.width * 0.18, size.height * 0.25);
    path.quadraticBezierTo(
      0,
      size.height * 0.22,
      size.width * 0.05,
      size.height * 0.50,
    );
    path.quadraticBezierTo(
      size.width * 0.02,
      size.height * 0.82,
      size.width * 0.28,
      size.height * 0.78,
    );
    path.lineTo(size.width * 0.20, size.height * 0.95);
    path.lineTo(size.width * 0.33, size.height * 0.78);
    path.quadraticBezierTo(
      size.width * 0.52,
      size.height,
      size.width * 0.72,
      size.height * 0.78,
    );
    path.quadraticBezierTo(
      size.width,
      size.height * 0.80,
      size.width * 0.95,
      size.height * 0.45,
    );
    path.quadraticBezierTo(
      size.width * 0.95,
      size.height * 0.10,
      size.width * 0.70,
      size.height * 0.18,
    );
    path.quadraticBezierTo(
      size.width * 0.60,
      -5,
      size.width * 0.42,
      size.height * 0.12,
    );
    path.quadraticBezierTo(
      size.width * 0.28,
      -2,
      size.width * 0.18,
      size.height * 0.25,
    );
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
class CloudBorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final path = CloudClipper().getClip(size);

    final paint = Paint()
      ..color = AppColors.gold
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}