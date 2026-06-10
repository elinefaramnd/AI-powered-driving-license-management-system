import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../app_theme/app_colors.dart';
import '../../widgets/order_action_button.dart';
import '../../widgets/payment_widgets/pay_button.dart';
import 'home_controller.dart';

class OrderCardController extends GetxController {
  final home = Get.find<HomeController>();
  Widget buildStep({required double width, required double height}) {
    final status = home.currentApplicationStatus.value;
    final hasApplication = home.hasApplication.value;
    Widget section({required String text, required Widget button}) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "الخطوة التالية",
            style: TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.bold,
              fontSize: width * .039,
            ),
          ),
          SizedBox(height: height * .006),
          Text(text, style: TextStyle(fontSize: width * .034)),
          SizedBox(height: height * .02),
          button,
        ],
      );
    }

    if (status == "draft") {
      return section(
        text: "بانتظار رفع الوثائق المطلوبة لإكمال الطلب",
        button: OrderActionButton(
          onPressed: home.openUploadDocuments,
          text: "تكملة الطلب",
          icon: Icons.upload_file,
          color: AppColors.primaryColor,
          width: width * .5,
          height: height * .055,
        ),
      );
    }
    if (!hasApplication) {
      return section(
        text: "ابدأ بإنشاء طلب جديد وستظهر هنا حالة الطلب والخطوات القادمة",
        button: OrderActionButton(
          onPressed: home.openNewApplication,
          text: "إنشاء طلب",
          icon: Icons.add_circle_outline,
          color: AppColors.primaryColor,
          width: width * .47,
          height: height * .055,
        ),
      );
    }
    if (status == "documents_under_review") {
      return section(
        text: "الوثائق قيد المراجعة حالياً، يمكنك متابعة حالة الطلب.",
        button: SizedBox(
          width: width * .47,
          height: height * .055,
          child: ElevatedButton.icon(
            onPressed: home.openOrderDetails,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(width * .03),
              ),
            ),
            icon: const Icon(Icons.visibility_outlined, color: Colors.white),
            label: const Text(
              "عرض الطلب",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      );
    }
    if (status == "payment_pending") {
      return section(
        text: "بانتظار دفع الرسوم للانتقال للمرحلة التالية",
        button: SizedBox(
          width: width * .47,
          height: height * .055,
          child: PayButton(
            applicationId: home.applicationId.value,
            isEnabled: home.applicationId.value > 0,
          ),
        ),
      );
    }
    return const SizedBox();
  }
}
