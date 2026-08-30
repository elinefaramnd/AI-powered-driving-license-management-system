import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app_theme/app_colors.dart';
import '../../modules/my_transactions/my_transaction_model.dart';

class TransactionCard extends StatelessWidget {
  final MyTransactionModel transaction;
  final VoidCallback onTap;

  const TransactionCard({
    super.key,
    required this.transaction,
    required this.onTap,
  });

  String _formatDate(String? value) {
    if (value == null || value.isEmpty) {
      return '-';
    }

    try {
      final date = DateTime.parse(value).toLocal();

      return '${date.day.toString().padLeft(2, '0')}/'
          '${date.month.toString().padLeft(2, '0')}/'
          '${date.year}';
    } catch (_) {
      return value;
    }
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;

    final isFine = transaction.relatedType == 'fine';

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: w * .035),
        padding: EdgeInsets.all(w * .04),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(w * .04),
          border: Border.all(
            color: Colors.grey.withOpacity(.08),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.045),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: w * .13,
                  height: w * .13,
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor.withOpacity(.09),
                    borderRadius: BorderRadius.circular(w * .035),
                  ),
                  child: Icon(
                    isFine
                        ? Icons.warning_amber_rounded
                        : Icons.description_outlined,
                    color: AppColors.primaryColor,
                    size: w * .065,
                  ),
                ),

                SizedBox(width: w * .035),

                Expanded(
                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [
                      Text(
                        isFine
                            ? 'traffic_fine'.tr
                            : 'application_payment'.tr,
                        style: TextStyle(
                          fontSize: w * .038,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[850],
                        ),
                      ),

                      SizedBox(height: w * .012),

                      Text(
                        transaction.transactionNumber,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: w * .029,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),

                _StatusBadge(
                  text: transaction.statusLabel.isNotEmpty
                      ? transaction.statusLabel
                      : transaction.status,
                ),
              ],
            ),

            SizedBox(height: w * .035),

            Divider(
              height: 1,
              color: Colors.grey.withOpacity(.12),
            ),

            SizedBox(height: w * .03),

            Row(
              children: [
                Expanded(
                  child: _InfoItem(
                    icon: Icons.payments_outlined,
                    label: 'amount'.tr,
                    value:
                    '${transaction.amount.toStringAsFixed(2)} ${transaction.currency}',
                  ),
                ),

                Container(
                  width: 1,
                  height: w * .09,
                  color: Colors.grey.withOpacity(.12),
                ),

                Expanded(
                  child: _InfoItem(
                    icon: Icons.calendar_today_outlined,
                    label: 'payment_date'.tr,
                    value: _formatDate(transaction.paidAt),
                  ),
                ),
              ],
            ),

            SizedBox(height: w * .025),

            Align(
              alignment: AlignmentDirectional.centerEnd,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'view_payment_details'.tr,
                    style: TextStyle(
                      color: AppColors.primaryColor,
                      fontSize: w * .032,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(width: w * .01),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: AppColors.primaryColor,
                    size: w * .035,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoItem({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: w * .025),
      child: Row(
        children: [
          Icon(
            icon,
            size: w * .045,
            color: AppColors.primaryColor,
          ),
          SizedBox(width: w * .018),
          Expanded(
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: w * .027,
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(height: w * .006),
                Text(
                  value,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: w * .03,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  final String text;

  const _StatusBadge({
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: w * .025,
        vertical: w * .012,
      ),
      decoration: BoxDecoration(
        color: Colors.green.withOpacity(.09),
        borderRadius: BorderRadius.circular(w * .05),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: w * .018,
            height: w * .018,
            decoration: const BoxDecoration(
              color: AppColors.primaryColor,
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(width: w * .012),
          Text(
            text,
            style: TextStyle(
              color: AppColors.primaryColor,
              fontSize: w * .027,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}