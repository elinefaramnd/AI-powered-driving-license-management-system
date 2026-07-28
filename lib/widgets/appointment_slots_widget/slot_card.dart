import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import '../../app_theme/app_colors.dart';

class SlotCard extends StatelessWidget {
  final dynamic slot;
  final bool selected;
  final VoidCallback onTap;

  const SlotCard({
    super.key,
    required this.slot,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isRtl = Directionality.of(context) == TextDirection.rtl;
    String startTime = slot["start_time"];
    int hour = int.parse(startTime.split(":")[0]);

    bool isMorning = hour < 12;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: size.height * .015),
        padding: EdgeInsets.all(size.width * .04),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: selected ? AppColors.primaryColor : Colors.grey.shade300,
            width: 2,
          ),
        ),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isRtl
                      ? "${slot["end_time"].substring(0, 5)} - ${slot["start_time"].substring(0, 5)}"
                      : "${slot["start_time"].substring(0, 5)} - ${slot["end_time"].substring(0, 5)}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: size.width * .05,
                  ),
                ),
                SizedBox(height: size.height * .006),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: isMorning
                        ? const Color(0xffEAF7EF)
                        : const Color(0xffFFF4E5),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    textDirection: TextDirection.rtl,
                    children: [
                      Text(
                        isMorning ? "morning_period".tr : "evening_period".tr,
                        style: TextStyle(
                          color: isMorning
                              ? AppColors.primaryColor
                              : AppColors.gold,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Icon(
                        isMorning ? Icons.wb_sunny_rounded : Icons.nightlight_round,
                        size: 14,
                        color: isMorning
                            ? AppColors.primaryColor
                            : AppColors.gold,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    textDirection:
                    isRtl ? TextDirection.rtl : TextDirection.ltr,
                    children: [
                      Text(
                        "${slot["remaining_capacity"]}",
                        style: TextStyle(
                          color: Colors.grey.shade700,
                          fontSize: size.width * .032,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        "available_seats".tr,
                        style: TextStyle(
                          color: Colors.grey.shade700,
                          fontSize: size.width * .032,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: size.height * .006),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(Icons.location_on_outlined,size: size.width *0.053,color: Colors.grey,),
                      Text(
                        slot["center"]["name"],
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: size.width * .035,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(width: size.width * .04),
            Icon(
              selected ? Icons.check_circle : Icons.circle_outlined,
              color: AppColors.primaryColor,
              size: size.width * .07,
            ),
          ],
        ),
      ),
    );
  }
}
