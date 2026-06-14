import 'package:flutter/material.dart';
import 'package:project_2/app_theme/app_colors.dart';
import 'package:project_2/modules/contact_us/contact_us_model.dart';

class ContactUsHeroBanner extends StatelessWidget {
  final double w;
  final double h;
  final ContactUsModel info;
  const ContactUsHeroBanner({super.key, required this.w, required this.h, required this.info});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: w * 0.055, vertical: h * 0.03),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.primary, AppColors.darkGreen],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.35),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                info.title,
                textDirection: TextDirection.rtl,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: w * 0.06,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: w * 0.025),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.15),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.support_agent_rounded,
                    color: Colors.white, size: 26),
              ),
            ],
          ),
          SizedBox(height: h * 0.012),
          Container(height: 1, color: Colors.white.withOpacity(0.2)),
          SizedBox(height: h * 0.012),
          Text(
            info.description,
            textDirection: TextDirection.rtl,
            textAlign: TextAlign.right,
            style: TextStyle(
              color: Colors.white.withOpacity(0.88),
              fontSize: w * 0.036,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}
