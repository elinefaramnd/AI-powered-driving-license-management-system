import 'package:flutter/material.dart';

class GoogleSignup extends StatelessWidget {
  const GoogleSignup({super.key});
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Divider(
                color: Colors.grey.shade300,
                thickness: screenWidth * 0.003,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.025),
              child: Text(
                "أو",
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: screenWidth * 0.04,
                ),
              ),
            ),
            Expanded(
              child: Divider(
                color: Colors.grey.shade300,
                thickness: screenWidth * 0.003,
              ),
            ),
          ],
        ),
        SizedBox(height: screenHeight * 0.018),
        Center(
          child: Container(
            width: screenWidth * 0.10,
            height: screenWidth * 0.10,
            padding: EdgeInsets.all(screenWidth * 0.02),
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: screenWidth * 0.025,
                ),
              ],
            ),
            child: Image.asset("assets/images/google.png", fit: BoxFit.contain),
          ),
        ),
      ],
    );
  }
}
