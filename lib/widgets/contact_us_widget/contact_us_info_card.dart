import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_2/app_theme/app_colors.dart';
import 'package:project_2/modules/contact_us/contact_us_model.dart';
import 'contact_us_clipboard_helper.dart';

class ContactUsInfoCard extends StatelessWidget {
  final double w;
  final ContactUsModel info;
  const ContactUsInfoCard({super.key, required this.w, required this.info});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(w * 0.045),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          _InfoRow(
            w: w,
            icon: Icons.phone_rounded,
            iconColor: const Color(0xFF2E7D32),
            iconBg: const Color(0xFFE8F5E9),
            label: 'الهاتف',
            value: info.phone,
            copyable: true,
          ),
          _InfoDivider(w: w),
          _InfoRow(
            w: w,
            icon: Icons.email_rounded,
            iconColor: const Color(0xFF1565C0),
            iconBg: const Color(0xFFE3F2FD),
            label: 'البريد الإلكتروني',
            value: info.email,
            copyable: true,
          ),
          _InfoDivider(w: w),
          _InfoRow(
            w: w,
            icon: Icons.access_time_rounded,
            iconColor: const Color(0xFFE65100),
            iconBg: const Color(0xFFFFF3E0),
            label: 'ساعات العمل',
            value: info.workingHours,
            copyable: false,
          ),
          _InfoDivider(w: w),
          _InfoRow(
            w: w,
            icon: Icons.location_on_rounded,
            iconColor: const Color(0xFF6A1B9A),
            iconBg: const Color(0xFFF3E5F5),
            label: 'العنوان',
            value: info.address,
            copyable: false,
          ),
        ],
      ),
    );
  }
}

class _InfoDivider extends StatelessWidget {
  final double w;
  const _InfoDivider({required this.w});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: w * 0.03),
      child: Divider(height: 1, color: Colors.grey.shade100),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final double w;
  final IconData icon;
  final Color iconColor;
  final Color iconBg;
  final String label;
  final String value;
  final bool copyable;

  const _InfoRow({
    required this.w,
    required this.icon,
    required this.iconColor,
    required this.iconBg,
    required this.label,
    required this.value,
    required this.copyable,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (copyable)
          GestureDetector(
            onTap: () => copyToClipboard(value),
            child: Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: AppColors.lightGreenBg,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.copy_rounded,
                  color: AppColors.mediumGreen, size: 16),
            ),
          ),
        if (copyable) SizedBox(width: w * 0.02),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                label,
                textDirection: TextDirection.rtl,
                style: TextStyle(
                  fontSize: w * 0.032,
                  color: Colors.grey.shade500,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                value,
                textDirection: TextDirection.rtl,
                textAlign: TextAlign.right,
                softWrap: true,
                style: TextStyle(
                  fontSize: w * 0.038,
                  color: const Color(0xFF1C1C1E),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: w * 0.03),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: iconBg,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: iconColor, size: 22),
        ),
      ],
    );
  }
}
