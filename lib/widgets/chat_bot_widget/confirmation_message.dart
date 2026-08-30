import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import '../../app_theme/app_colors.dart';
import '../../modules/chat_bot/chat_bot_controller.dart';
import '../../modules/chat_bot/chat_message.dart';
import 'chat_bot_avatars.dart';

class ConfirmationMessage extends StatelessWidget {
  final ChatMessage message;
  final Size size;
  final ChatController controller;
  const ConfirmationMessage({
    super.key,
    required this.message,
    required this.size,
    required this.controller,
  });
  static const Color textDark = Color(0xFF202624);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: size.height * 0.020),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          ChatBotAvatar(size: size),
          SizedBox(width: size.width * 0.018),
          Expanded(
            child: Container(
              constraints: BoxConstraints(maxWidth: size.width * 0.82),
              padding: EdgeInsets.fromLTRB(
                size.width * 0.035,
                size.height * 0.020,
                size.width * 0.035,
                size.height * 0.014,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(22),
                border: Border.all(
                  color: Colors.grey.withOpacity(0.10),
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.055),
                    blurRadius: 18,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: size.width * 0.115,
                        height: size.width * 0.115,
                        decoration: BoxDecoration(
                          color: AppColors.gold.withOpacity(0.08),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: AppColors.gold.withOpacity(0.16),
                          ),
                        ),
                        child: Icon(
                          Icons.description_outlined,
                          color: AppColors.primaryColor,
                          size: size.width * 0.060,
                        ),
                      ),
                      SizedBox(width: size.width * 0.025),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(top: size.height * 0.004),
                          child: Text(
                            message.text.tr,
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              color: textDark,
                              fontSize: size.width * 0.035,
                              fontWeight: FontWeight.w600,
                              height: 1.55,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: size.height * 0.018),

                  CustomPaint(
                    size: const Size(double.infinity, 1),
                    painter: DashedLinePainter(
                      color: AppColors.gold.withOpacity(0.35),
                    ),
                  ),
                  SizedBox(height: size.height * 0.016),
                  Row(
                    children: [
                      Expanded(
                        child: _buildConfirmButton(
                          label: "تأكيد",
                          icon: Icons.check_circle_outline_rounded,
                          backgroundColor: AppColors.primaryColor,
                          foregroundColor: Colors.white,
                          borderColor: AppColors.primaryColor,
                          onTap: () {
                            controller.acceptPrompt();
                          },
                        ),
                      ),
                      SizedBox(width: size.width * 0.025),
                      Expanded(
                        child: _buildConfirmButton(
                          label: "رفض",
                          icon: Icons.cancel_outlined,
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.red.shade700,
                          borderColor: Colors.red.shade300,
                          onTap: () {
                            controller.rejectPrompt();
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: size.height * 0.008),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      _formatTime(message.timestamp),
                      style: TextStyle(
                        color: Colors.grey.shade500,
                        fontSize: size.width * 0.024,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildConfirmButton({
    required String label,
    required IconData icon,
    required Color backgroundColor,
    required Color foregroundColor,
    required Color borderColor,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Container(
          height: size.height * 0.052,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: borderColor, width: 1.2),
            boxShadow: backgroundColor == AppColors.primaryColor
                ? [
                    BoxShadow(
                      color: AppColors.primaryColor.withOpacity(0.18),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : null,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: foregroundColor, size: size.width * 0.047),
              SizedBox(width: size.width * 0.012),
              Text(
                label,
                style: TextStyle(
                  color: foregroundColor,
                  fontSize: size.width * 0.032,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  String _formatTime(DateTime time) {
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }
}
class DashedLinePainter extends CustomPainter {
  final Color color;
  DashedLinePainter({required this.color});
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1;
    const dashWidth = 5.0;
    const dashSpace = 5.0;
    double startX = 0;
    while (startX < size.width) {
      canvas.drawLine(Offset(startX, 0), Offset(startX + dashWidth, 0), paint);

      startX += dashWidth + dashSpace;
    }
  }
  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
