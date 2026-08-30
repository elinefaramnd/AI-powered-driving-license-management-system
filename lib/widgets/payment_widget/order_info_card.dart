import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import '../../../app_theme/app_colors.dart';

class OrderInfoCard extends StatelessWidget {
  final int applicationId;
  final String status;

  const OrderInfoCard({
    super.key,
    required this.applicationId,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    final w=size.width;
    final h=size.height;
    final isRtl=Directionality.of(context)==TextDirection.rtl;
    return Container(
      padding: EdgeInsets.all(w * .045),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(w * .035),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
      "application_number".tr,
                    style: TextStyle(
                      fontSize: w * .035,
                      color: AppColors.Gray[900],
                    ),
                  ),
                   SizedBox(height: w * .015),
                  Text(
                    'APP-2026-${applicationId.toString().padLeft(6, '0')}',
                    style:  TextStyle(
                      fontSize: w * .037,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            
              const Spacer(),
              
              Container(
                padding:  EdgeInsets.symmetric(horizontal: w * .03, vertical: w * .02),
                decoration: BoxDecoration(
                  color: AppColors.gold.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(w * .025),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.access_time,
                      size: w * .038,
                      color: AppColors.darkGreen,
                    ),
                    SizedBox(width: w * .01),
                    Text(
                      _getStatusLabel(status),
                      style:  TextStyle(
                        fontSize: w * .032,
                        color: AppColors.darkGreen,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              ],
          ),
          const SizedBox(height: 20),
          Divider(
            color: Colors.grey[200],
            height: 1,
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Container(
                      width: w * .085,
                      height: w * .085,
                      decoration: BoxDecoration(
                        color: AppColors.gold.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(
                        Icons.description_outlined,
                        size: w * .049,
                        color: AppColors.darkGreen,
                      ),
                    ),
                     SizedBox(width: w * .025),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                    "fee_type".tr,
                          style: TextStyle(
                            fontSize: w * .035,
                            color: Colors.grey[900],
                          ),
                        ),
                         SizedBox(height: w * .017),
                         Text(
                          "application_fee".tr,
                          style: TextStyle(
                            fontSize: w * .033,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                width: 1,
                height: 40,
                color: Colors.grey[300],
                margin: const EdgeInsets.symmetric(horizontal: 16),
              ),
              Expanded(
                child: Row(
                  children: [
                    Container(
                      width: w * .085,
                      height: w * .085,
                      decoration: BoxDecoration(
                        color: AppColors.gold.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(
                        Icons.calendar_today_outlined,
                        size: w * .045,
                        color: AppColors.darkGreen,
                      ),
                    ),
                    SizedBox(width: w * .025),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                    "creation_date".tr,
                          style: TextStyle(
                            fontSize: w * .035,
                            color: Colors.grey[900],
                          ),
                        ),
                        SizedBox(height: w * .017),
                        Text(
                          _formatDate(DateTime.now()),
                          style:  TextStyle(
                            fontSize: w * .033,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    final isArabic = Get.locale?.languageCode == "ar";

    const monthsAr = [
      'يناير',
      'فبراير',
      'مارس',
      'إبريل',
      'مايو',
      'يونيو',
      'يوليو',
      'أغسطس',
      'سبتمبر',
      'أكتوبر',
      'نوفمبر',
      'ديسمبر',
    ];

    const monthsEn = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];

    if (isArabic) {
      return '${date.day} ${monthsAr[date.month - 1]} ${date.year}';
    } else {
      return '${date.day}${monthsEn[date.month - 1]} ${date.year}  ';
    }
  }

  String _getStatusLabel(String status) {
    switch (status) {
      case 'payment_pending':
        return "waiting_payment".tr;
      case 'pending':
        return "pending".tr;
      case 'approved':
        return "approved".tr;
      case 'rejected':
        return "rejected".tr;
      case 'completed':
        return "completed".tr;
      case 'under_review':
        return "under_review".tr;
      default:
        return "appointment_pending".tr;
    }
  }
}
