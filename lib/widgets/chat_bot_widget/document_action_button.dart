import 'package:flutter/material.dart';
import '../../app_theme/app_colors.dart';
import '../../modules/chat_bot/chat_bot_controller.dart';

class DocumentActionButton extends StatelessWidget {
  final ChatController controller;
  final String label;
  final String action;
  final Size size;

  const DocumentActionButton({
    super.key,
    required this.controller,
    required this.label,
    required this.action,
    required this.size,
  });
  @override
  Widget build(BuildContext context) {
    final isAgentUpload =
        action == 'choose_agent_document_upload';
    final isManualUpload = action == 'choose_manual_document_upload';
    return SizedBox(
      width: double.infinity,
      height: size.height * 0.050,
      child: Material(
        color: isAgentUpload
            ? AppColors.primaryColor
            : Colors.white,
        borderRadius: BorderRadius.circular(25),
        child: InkWell(
          onTap: () async {
            if (action ==
                'choose_agent_document_upload') {
              await controller.sendMessageToBackend(
                label,
              );
            } else if (action ==
                'choose_manual_document_upload') {
              await controller.sendMessageToBackend(
                label,
              );
            }
          },
          borderRadius: BorderRadius.circular(25),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              border: Border.all(
                color: isAgentUpload
                    ? AppColors.primaryColor
                    : AppColors.primaryColor.withOpacity(0.65),
                width: 1.2,
              ),
              boxShadow: isAgentUpload
                  ? [
                BoxShadow(
                  color: AppColors.primaryColor.withOpacity(0.15),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ]
                  : null,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (isAgentUpload)
                  Icon(
                    Icons.cloud_upload_rounded,
                    color: Colors.white,
                    size: size.width * 0.040,
                  )
                else
                  Icon(
                    Icons.cloud_upload_outlined,
                    color: AppColors.primaryColor,
                    size: size.width * 0.040,
                  ),
                SizedBox(
                  width: size.width * 0.018,
                ),
                Flexible(
                  child: Text(
                    label,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: isAgentUpload
                          ? Colors.white
                          : AppColors.primaryColor,
                      fontSize: size.width * 0.029,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}