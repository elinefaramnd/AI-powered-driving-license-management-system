import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app_theme/app_colors.dart';

class TransactionDetailsCard extends StatelessWidget {
  final Map<String, dynamic> data;

  const TransactionDetailsCard({
    super.key,
    required this.data,
  });

  String _formatDate(String? value) {
    if (value == null || value.isEmpty) {
      return '-';
    }

    try {
      final date = DateTime.parse(value).toLocal();

      return '${date.day.toString().padLeft(2, '0')}/'
          '${date.month.toString().padLeft(2, '0')}/'
          '${date.year}  '
          '${date.hour.toString().padLeft(2, '0')}:'
          '${date.minute.toString().padLeft(2, '0')}';
    } catch (_) {
      return value;
    }
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;

    final purpose = data['purpose'] ?? {};
    final related = data['related'] ?? {};
    final detail = data['detail'] ?? {};

    final isFine = related['type'] == 'fine';

    return SingleChildScrollView(
      padding: EdgeInsets.all(w * .045),
      child: Column(
        children: [
          _buildAmountHeader(w),
          SizedBox(height: w * .04),
          _buildMainInfo(
            context,
            purpose,
            related,
          ),
          SizedBox(height: w * .04),
          if (isFine && detail['fine'] != null)
            _buildFineDetails(
              context,
              Map<String, dynamic>.from(detail['fine']),
            ),
          if (!isFine)
            _buildApplicationDetails(
              context,
              related,
            ),
        ],
      ),
    );
  }

  Widget _buildAmountHeader(double w) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(w * .055),
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.circular(w * .05),
      ),
      child: Column(
        children: [
          Icon(
            Icons.check_circle_outline_rounded,
            color: Colors.white,
            size: w * .12,
          ),
          SizedBox(height: w * .025),
          Text(
            '${data['amount'] ?? '0'} ${data['currency'] ?? ''}',
            style: TextStyle(
              color: Colors.white,
              fontSize: w * .07,
              fontWeight: FontWeight.bold,
            ),
          ),

          SizedBox(height: w * .015),

          Text(
            data['status_label'] ??
                data['status'] ??
                '',
            style: TextStyle(
              color: Colors.white.withOpacity(.85),
              fontSize: w * .035,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMainInfo(
      BuildContext context,
      Map<String, dynamic> purpose,
      Map<String, dynamic> related,
      ) {
    final w = MediaQuery.of(context).size.width;

    return _SectionCard(
      title: 'transaction_information'.tr,
      icon: Icons.receipt_long_outlined,
      children: [
        _InfoRow(
          title: 'payment_number'.tr,
          value: data['payment_number'] ?? '-',
        ),
        _InfoRow(
          title: 'payment_type'.tr,
          value: purpose['label'] ?? '-',
        ),
        _InfoRow(
          title: 'payment_method'.tr,
          value: data['provider'] ?? '-',
        ),
        _InfoRow(
          title: 'created_at'.tr,
          value: _formatDate(data['created_at']),
        ),
        _InfoRow(
          title: 'paid_at'.tr,
          value: _formatDate(data['paid_at']),
        ),
      ],
    );
  }

  Widget _buildFineDetails(
      BuildContext context,
      Map<String, dynamic> fine,
      ) {
    return _SectionCard(
      title: 'fine_information'.tr,
      icon: Icons.warning_amber_outlined,
      children: [
        _InfoRow(
          title: 'fine_number'.tr,
          value: '#${fine['id'] ?? '-'}',
        ),
        _InfoRow(
          title: 'fine_reason'.tr,
          value: fine['reason'] ?? '-',
        ),
        _InfoRow(
          title: 'fine_amount'.tr,
          value:
          '${fine['amount'] ?? '0'} ${fine['currency'] ?? ''}',
        ),
        _InfoRow(
          title: 'fine_status'.tr,
          value: fine['status'] ?? '-',
        ),
      ],
    );
  }

  Widget _buildApplicationDetails(
      BuildContext context,
      Map<String, dynamic> related,
      ) {
    return _SectionCard(
      title: 'application_information'.tr,
      icon: Icons.description_outlined,
      children: [
        _InfoRow(
          title: 'application_number'.tr,
          value: related['application_number'] ?? '-',
        ),
        _InfoRow(
          title: 'service_type'.tr,
          value: related['service_type_code'] ?? '-',
        ),
        _InfoRow(
          title: 'fee_type'.tr,
          value: related['fee_code'] ?? '-',
        ),
      ],
    );
  }
}

class _SectionCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final List<Widget> children;

  const _SectionCard({
    required this.title,
    required this.icon,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(w * .04),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(w * .04),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: AppColors.primaryColor,
                size: w * .055,
              ),
              SizedBox(width: w * .02),
              Text(
                title,
                style: TextStyle(
                  fontSize: w * .04,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          SizedBox(height: w * .025),

          ...children,
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String title;
  final String value;

  const _InfoRow({
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: w * .022,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 4,
            child: Text(
              title,
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: w * .032,
              ),
            ),
          ),
          SizedBox(width: w * .03),
          Expanded(
            flex: 6,
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: TextStyle(
                fontSize: w * .032,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}