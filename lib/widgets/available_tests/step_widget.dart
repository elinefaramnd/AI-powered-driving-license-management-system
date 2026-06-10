import 'package:flutter/material.dart';
import '../../app_theme/app_colors.dart';
class StepWidget extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool active;
  final bool done;
  const StepWidget({
    super.key,
    required this.title,
    required this.icon,
    required this.active,
    required this.done,
  });
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Expanded(
      child: Column(
        children: [
          SizedBox(
            height: size.width * 0.12,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: size.width * 0.11,
                  height: size.width * 0.11,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: active
                        ? AppColors.primaryColor.withOpacity(.12)
                        : Colors.white,
                    border: Border.all(
                      color: active
                          ? AppColors.primaryColor
                          : Colors.grey.shade300,
                    ),
                  ),
                  child: Icon(
                    icon,
                    size: size.width * 0.055,
                    color: active ? AppColors.primaryColor : Colors.grey,
                  ),
                ),
                Positioned(
                  bottom: -2,
                  right: -2,
                  child: Container(
                    width: size.width * 0.045,
                    height: size.width * 0.045,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: done
                          ? AppColors.primaryColor
                          : Colors.grey.shade400,
                    ),
                    child: Icon(
                      done ? Icons.check : Icons.lock,
                      size: size.width * 0.027,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: size.width * 0.015),
          Text(
            title,
            style: TextStyle(
              fontSize: size.width * 0.025,
              color: active ? AppColors.primaryColor : Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }
}
