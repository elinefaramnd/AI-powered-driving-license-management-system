import 'package:flutter/material.dart';
import 'package:project_2/app_theme/app_colors.dart';
import '../../modules/privacy_policy/privacy_policy_controller.dart';

const List<IconData> _sectionIcons = [
  Icons.info_outline,
  Icons.list_alt_outlined,
  Icons.bar_chart_outlined,
  Icons.people_outline,
  Icons.shield_outlined,
  Icons.upload_file_outlined,
  Icons.credit_card_outlined,
  Icons.person_outline,
  Icons.update_outlined,
  Icons.headset_mic_outlined,
];

IconData _iconForIndex(int index) {
  if (index < _sectionIcons.length) return _sectionIcons[index];
  return Icons.article_outlined;
}

class PrivacyPolicySectionCard extends StatelessWidget {
  final double w;
  final double h;
  final int index;
  final String heading;
  final String content;
  final bool isExpanded;
  final PrivacyPolicyController controller;

  const PrivacyPolicySectionCard({
    super.key,
    required this.w,
    required this.h,
    required this.index,
    required this.heading,
    required this.content,
    required this.isExpanded,
    required this.controller,
  });

 

  

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeInOut,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(14),
        child: InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: () => controller.toggleSection(index),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: w * 0.04,
              vertical: h * 0.016,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  children: [
                    AnimatedRotation(
                      duration: const Duration(milliseconds: 250),
                      turns: isExpanded ? 0.25 : 0,
                      child: Icon(
                        Icons.arrow_back_ios,
                        size: 16,
                        color: Colors.grey.shade500,
                      ),
                    ),
                    SizedBox(width: w * 0.02),
                    Expanded(
                      flex: 8,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            heading,
                            textDirection: TextDirection.rtl,
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              fontSize: w * 0.042,
                              fontWeight: FontWeight.bold,
                              color: AppColors.darkGreen,
                            ),
                          ),
                          if (!isExpanded) ...[
                            SizedBox(height: h * 0.005),
                            Text(
                              content,
                              textDirection: TextDirection.rtl,
                              textAlign: TextAlign.right,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: w * 0.034,
                                color: Colors.grey.shade600,
                                height: 1.5,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                    SizedBox(width: w * 0.025),
                    Container(
                      padding: const EdgeInsets.all(9),
                      decoration: BoxDecoration(
                        color: AppColors.lightGreenBg,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(
                        _iconForIndex(index),
                        color: AppColors.mediumGreen,
                        size: w * 0.055,
                      ),
                    ),
                  ],
                ),
                if (isExpanded) ...[
                  SizedBox(height: h * 0.012),
                  Divider(color: Colors.grey.shade100, thickness: 1),
                  SizedBox(height: h * 0.008),
                  Text(
                    content,
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontSize: w * 0.038,
                      color: Colors.grey.shade700,
                      height: 1.75,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
