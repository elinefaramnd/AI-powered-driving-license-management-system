import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import '../../../app_theme/app_colors.dart';
import '../../modules/fines/fine_model.dart';

class FineInfoCard extends StatelessWidget {
  final FineModel fine;

  const FineInfoCard({super.key, required this.fine});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;

    return Container(
      padding: EdgeInsets.all(w * .045),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(w * .04),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildInfoRow(
            context,
            icon: Icons.receipt_long_outlined,
            title: "fine_number".tr,
            value: '#${fine.id}',
          ),

          _buildDivider(),

          _buildInfoRow(
            context,
            icon: Icons.warning_amber_outlined,
            title: "fine_reason".tr,
            value: fine.reason,
          ),

          _buildDivider(),

          _buildInfoRow(
            context,
            icon: Icons.calendar_today_outlined,
            title: "fine_date".tr,
            value: _formatDate(fine.createdAt),
          ),

          if (fine.paidAt != null) ...[
            _buildDivider(),
            _buildInfoRow(
              context,
              icon: Icons.check_circle_outline,
              title: "paid_at".tr,
              value: _formatDate(fine.paidAt),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildInfoRow(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String value,
  }) {
    final w = MediaQuery.of(context).size.width;

    return Row(
      children: [
        Container(
          width: w * .105,
          height: w * .105,
          decoration: BoxDecoration(
            color: AppColors.primaryColor.withOpacity(.09),
            borderRadius: BorderRadius.circular(w * .03),
          ),
          child: Icon(icon, color: AppColors.primaryColor, size: w * .055),
        ),

        SizedBox(width: w * .035),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(color: Colors.grey[600], fontSize: w * .032),
              ),
              SizedBox(height: w * .01),
              Text(
                value,
                style: TextStyle(
                  fontSize: w * .038,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDivider() {
    return const Divider(height: 24);
  }

  String _formatDate(String? value) {
    if (value == null || value.isEmpty) {
      return '-';
    }

    try {
      final date = DateTime.parse(value);

      return '${date.year}-'
          '${date.month.toString().padLeft(2, '0')}-'
          '${date.day.toString().padLeft(2, '0')}';
    } catch (_) {
      return value;
    }
  }
}
