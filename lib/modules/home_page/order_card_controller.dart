import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_2/widgets/app_snackbar.dart';
import '../../app_theme/app_colors.dart';
import '../../widgets/home_widget/order_action_button.dart';
import '../payment/payment_screen.dart';
import 'home_controller.dart';

class OrderCardController extends GetxController {
  final home = Get.find<HomeController>();
  final profileStatus = Get.find<HomeController>().profileStatus;
  bool get canUseServices => profileStatus.value == "approved";
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
          onPressed: canUseServices
              ? home.openUploadDocuments
              : () {
            AppSnackbar.show(
              "تنبيه",
              _message(),
            );
          },
          text: "تكملة الطلب",
          icon: Icons.upload_file,
          color: canUseServices
              ? AppColors.primaryColor
              : Colors.grey.shade400,
          width: width * .5,
          height: height * .055,
        ),
      );
    }
    if (!hasApplication) {
      return section(
        text: "ابدأ بإنشاء طلب جديد وستظهر هنا حالة الطلب والخطوات القادمة",
        button: OrderActionButton(
          onPressed: canUseServices
              ?  home.openNewApplication
              : () {
            AppSnackbar.show(
              "تنبيه",
              _message(),
            );
          },
          text: "إنشاء طلب",
          icon: Icons.add_circle_outline,
          color: canUseServices
              ? AppColors.primaryColor
              : Colors.grey.shade400,
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
            onPressed: canUseServices
                ?  home.openOrderDetails
                : () {
              AppSnackbar.show(
                "تنبيه",
                _message(),
              );
            },

            style: ElevatedButton.styleFrom(
              backgroundColor: canUseServices
            ? AppColors.primaryColor
                : Colors.grey.shade400,
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
        button: OrderActionButton(
          onPressed: () {
            canUseServices
                ?
            Get.to(
                  () => PaymentScreen(
                applicationId: home.applicationId.value,
              ),
            ):() {
              AppSnackbar.show(
                "تنبيه",
                _message(),
              );
            };
          },
          text: "دفع الرسوم",
          icon: Icons.credit_card_outlined,
          color: canUseServices
              ? AppColors.primaryColor
              : Colors.grey.shade400,
          width: width * .47,
          height: height * .055,
        ),
      );
    }if (status == "appointment_pending") {
      return section(
        text: "تمت الموافقة على طلبك، يمكنك الآن حجز موعد الاختبار",
        button: OrderActionButton(
          onPressed: () {
        if (home.applicationId.value > 0) {
          canUseServices
              ? Get.toNamed(
            '/available_tests_page',
            arguments: home.applicationId.value,
          ):() {
            AppSnackbar.show(
              "تنبيه",
              _message(),
            );
          };}
          },
          text: "حجز موعد",
          icon: Icons.calendar_month_outlined,
          color: canUseServices
              ? AppColors.primaryColor
              : Colors.grey.shade400,
          width: width * .47,
          height: height * .055,
        ),
      );
    }
    if (status == "in_testing") {
      return section(
        text: "مرحلة الاختبارات مفعّلة لديك، يمكنك حجز موعد اختبار أو متابعة المواعيد الحالية حسب حالتها.",        button: SizedBox(
          width: width * .47,
          height: height * .055,
          child: ElevatedButton.icon(
            onPressed: canUseServices
                ?  home.openOrderDetails
                : () {
              AppSnackbar.show(
                "تنبيه",
                _message(),
              );
            },

            style: ElevatedButton.styleFrom(
              backgroundColor: canUseServices
            ? AppColors.primaryColor
                : Colors.grey.shade400,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(width * .03),
              ),
            ),
            icon: const Icon(Icons.schedule_outlined, color: Colors.white),
            label: const Text(
              "عرض التفاصيل",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      );
    }
    return const SizedBox();
  }
  String _message() {
    final status = profileStatus.value;

    if (status == "pending_review") {
      return "الحساب قيد المراجعة حالياً";
    } else if (status == "rejected") {
      return "تم رفض الملف، يرجى تعديله";
    } else {
      return "يرجى إكمال الملف الشخصي أولاً";
    }
  }
}
