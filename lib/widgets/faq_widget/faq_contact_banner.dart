import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FaqContactBanner extends StatelessWidget {
  final double w;
  final double h;

  const FaqContactBanner({super.key, required this.w, required this.h});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(w * 0.05, h * 0.015, w * 0.05, h * 0.02),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 12,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: SizedBox(
        width: double.infinity,
        height: h * 0.065,
        child: ElevatedButton(
          onPressed: () => Get.toNamed('/contact_us'),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF042E2B),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            elevation: 0,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.headset_mic_rounded, color: Colors.white, size: 20),
              SizedBox(width: w * 0.02),
              Text(
                'لم تجد إجابتك؟ تواصل معنا',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: w * 0.042,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
