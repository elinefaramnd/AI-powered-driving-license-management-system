import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../app_theme/app_colors.dart';
import '../modules/fines/fine_model.dart';
import '../modules/fines/fines_controller.dart';

class FineCard extends GetView<FinesController> {
  final FineModel fine;
  const FineCard({super.key, required this.fine});
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
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
                  color: const Color(0xffFDEAEA),
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Text(
                  fine.status == "unpaid" ? "غير مدفوعة" : "مدفوعة",
                  style: TextStyle(
                    color: fine.status == "unpaid" ? Colors.red : Colors.green,
                    fontWeight: FontWeight.bold,
                    fontSize: size.width * .035,
                  ),
                ),
              ),
              const Spacer(flex: 3),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  fine.reason,
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
                "${fine.amount.toStringAsFixed(2)} ل.س",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                  fontSize: size.width * .045,
                ),
              ),
              Text(
                "المبلغ",
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: size.width * .045,
                ),
              ),
            ],
          ),

          SizedBox(height: size.height * .02),
          SizedBox(
            width: size.width * .6,
            height: size.height * .065,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: AppColors.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {},
              child: Text(
                "ادفع الآن",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: size.width * .045,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
