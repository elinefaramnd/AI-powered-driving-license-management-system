import 'package:flutter/material.dart';
class LockedTestCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final String line1;
  final String line2;
  const LockedTestCard({
    super.key,
    required this.title,
    required this.icon,
    required this.line1,
    required this.line2,
  });
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.all(size.width * 0.035),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(size.width * 0.045),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: size.width * 0.135,
                height: size.width * 0.16,
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(size.width * 0.035),
                ),
                child: Icon(icon, size: size.width * 0.08, color: Colors.grey.shade600),
              ),
              Positioned(
                bottom: -2,
                right: -2,
                child: Container(
                  width: size.width * 0.048,
                  height: size.width * 0.048,
                  decoration: const BoxDecoration(
                    color: Colors.grey,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.lock, size: size.width * 0.025, color: Colors.white),
                ),
              ),
            ],
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: size.width * 0.023),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: size.width * 0.038,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: size.width * 0.015),
                  Container(
                    padding: EdgeInsets.all(size.width * 0.012),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(size.width * 0.02),),
                    child: Text(
                      line1,
                      style: TextStyle(
                        fontSize: size.width * 0.027,
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ),
                  SizedBox(height: size.width * 0.015),
                  Text(
                    line2,
                    maxLines: 1,
                    style: TextStyle(fontSize: size.width * 0.028, color: Colors.grey.shade600),
                  ),
                ],
              ),
            ),
          ),
          Container(
            constraints: BoxConstraints(maxWidth: size.width * 0.22),
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.011, vertical: size.width * 0.015),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(size.width * 0.02),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.lock_outline, size: size.width * 0.037, color: Colors.grey),
                SizedBox(width: size.width * 0.01),
                Text(
                  "غير متاح حالياً",
                  style: TextStyle(fontSize: size.width * 0.027, color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
