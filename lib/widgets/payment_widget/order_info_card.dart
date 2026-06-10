import 'package:flutter/material.dart';
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
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
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
                    'رقم الطلب ',
                    style: TextStyle(
                      fontSize: 13,
                      color: AppColors.Gray[900],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'APP-2026-${applicationId.toString().padLeft(6, '0')}',
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            
              const Spacer(),
              
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.gold.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.access_time,
                      size: 14,
                      color: AppColors.darkGreen,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      _getStatusLabel(status),
                      style: const TextStyle(
                        fontSize: 12,
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
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: AppColors.gold.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(
                        Icons.description_outlined,
                        size: 18,
                        color: AppColors.darkGreen,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'نوع الرسوم',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[900],
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'رسوم تقديم الطلب',
                          style: TextStyle(
                            fontSize: 14,
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
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: AppColors.gold.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(
                        Icons.calendar_today_outlined,
                        size: 18,
                        color: AppColors.darkGreen,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'تاريخ الإنشاء',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[900],
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          _formatDate(DateTime.now()),
                          style: const TextStyle(
                            fontSize: 14,
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
    const months = [
      'يناير', 'فبراير', 'مارس', 'إبريل', 'مايو', 'يونيو',
      'يوليو', 'أغسطس', 'سبتمبر', 'أكتوبر', 'نوفمبر', 'ديسمبر'
    ];
    return '${date.day} ${months[date.month - 1]} ${date.year}';
  }

  String _getStatusLabel(String status) {
    switch (status) {
      case 'payment_pending':
        return 'في انتظار الدفع';
      case 'pending':
        return 'قيد الانتظار';
      case 'approved':
        return 'تمت الموافقة';
      case 'rejected':
        return 'مرفوض';
      case 'completed':
        return 'مكتمل';
      case 'under_review':
        return 'قيد المراجعة';
      default:
        return 'موعد معلق';
    }
  }
}
