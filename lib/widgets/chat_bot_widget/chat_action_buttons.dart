import 'package:flutter/material.dart';
import '../../app_theme/app_colors.dart';

class ChatActionButtons extends StatelessWidget {
  final Size size;
  final String acceptLabel;
  final String rejectLabel;
  final VoidCallback onAccept;
  final VoidCallback onReject;

  const ChatActionButtons({
    super.key,
    required this.size,
    required this.acceptLabel,
    required this.rejectLabel,
    required this.onAccept,
    required this.onReject,
  });

  static const Color darkGreen = Color(0xFF004D40);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: size.height * 0.018),
      padding: EdgeInsets.only(top: size.height * 0.014),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: AppColors.gold.withOpacity(0.30), width: 1),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: _buildActionButton(
              label: acceptLabel,
              icon: Icons.check_circle_rounded,
              color: darkGreen,
              onTap: onAccept,
              filled: true,
            ),
          ),

          SizedBox(width: size.width * 0.025),

          Expanded(
            child: _buildActionButton(
              label: rejectLabel,
              icon: Icons.cancel_rounded,
              color: Colors.red.shade600,
              onTap: onReject,
              filled: false,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required String label,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
    required bool filled,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: size.width * 0.025,
          vertical: size.height * 0.012,
        ),
        decoration: BoxDecoration(
          color: filled ? color : Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: color.withOpacity(filled ? 0 : 0.55),
            width: 1.2,
          ),
          boxShadow: filled
              ? [
                  BoxShadow(
                    color: color.withOpacity(0.20),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ]
              : null,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: size.width * 0.043,
              color: filled ? Colors.white : color,
            ),

            SizedBox(width: size.width * 0.015),

            Flexible(
              child: Text(
                label,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: filled ? Colors.white : color,
                  fontSize: size.width * 0.030,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
