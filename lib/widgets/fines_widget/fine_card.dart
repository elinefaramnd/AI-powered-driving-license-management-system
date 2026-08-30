import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../app_theme/app_colors.dart';
import '../../modules/fines/fine_model.dart';
import '../../modules/fines/fines_controller.dart';

class FineCard extends GetView<FinesController> {
  final FineModel fine;
  const FineCard({super.key, required this.fine});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isPaid = fine.status == 'paid' || fine.status == 'completed';
    return Container(
      margin: EdgeInsets.only(bottom: size.height * .018),
      padding: EdgeInsets.all(size.width * .045),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: size.width * .04,
                  vertical: size.height * .008,
                ),
                decoration: BoxDecoration(
                  color: isPaid
                      ? AppColors.primaryColor.withOpacity(.10)
                      : const Color(0xffFDEAEA),
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Text(
                  isPaid ? "paid".tr : "unpaid".tr,
                  style: TextStyle(
                    color: isPaid ? AppColors.primaryColor : Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: size.width * .035,
                  ),
                ),
              ),
              const Spacer(flex: 3),
              Expanded(
                flex: 4,
                child: Text(
                  fine.reason,
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: size.width * .047,
                  ),
                ),
              ),
              const Spacer(flex: 1),
              Container(
                width: size.width * .11,
                height: size.width * .11,
                decoration: BoxDecoration(
                  color: const Color(0xffFBF3F1),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(
                  Icons.directions_car,
                  color: Colors.red,
                  size: size.width * .08,
                ),
              ),
            ],
          ),
          SizedBox(height: size.height * .015),
          Divider(height: size.height * .05),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${fine.amount.toStringAsFixed(2)} ${"currency".tr}",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                  fontSize: size.width * .045,
                ),
              ),

              Text(
                "amount".tr,
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: size.width * .045,
                ),
              ),
            ],
          ),
          SizedBox(height: size.height * .02),
          SizedBox(
            width: double.infinity,
            height: size.height * .055,
            child: OutlinedButton.icon(
              onPressed: () {
                Get.toNamed('/fine_details', arguments: fine.id);
              },
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.primaryColor,
                side: BorderSide(color: AppColors.primaryColor, width: 1.2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
              icon: Icon(Icons.visibility_outlined, size: size.width * .045),
              label: Text(
                "view_details".tr,
                style: TextStyle(
                  fontSize: size.width * .035,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
