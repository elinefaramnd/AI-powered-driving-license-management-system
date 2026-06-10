import 'package:flutter/material.dart';

class OrderActionButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final IconData icon;
  final Color color;
  final double width;
  final double height;

  const OrderActionButton({
    super.key,
    required this.onPressed,
    required this.text,
    required this.icon,
    required this.color,
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,

      child: ElevatedButton(
        onPressed: onPressed,

        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          elevation: 0,

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),

        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            Icon(icon, color: Colors.white, size: width * .1),

            const SizedBox(width: 8),

            Text(
              text,

              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
