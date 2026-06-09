import 'package:flutter/material.dart';
import 'payment_status_helper.dart';

class PaymentStatusCard extends StatelessWidget {
  final String status;

  const PaymentStatusCard({
    super.key,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    final statusColor = PaymentStatusHelper.getColor(status);
    final statusIcon = PaymentStatusHelper.getIcon(status);
    final statusText = PaymentStatusHelper.getText(status);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: statusColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(
            statusIcon,
            color: statusColor,
            size: 24,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              statusText,
              style: TextStyle(
                color: statusColor,
                fontWeight: FontWeight.w600,
                fontSize: 15,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
