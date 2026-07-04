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
  bool get uncanUseServices => profileStatus.value == "rejected";
  bool get incompleteProfile => profileStatus.value == "incomplete";

  Widget _actionButton({
    required VoidCallback onPressed,
    required String text,
    required IconData icon,
    required double width,
    required double height,
    double buttonWidth = .47,
  }) {
    return OrderActionButton(
      onPressed: canUseServices
          ? onPressed
          : () {
              AppSnackbar.show("تنبيه", _message());
            },
      text: text,
      icon: icon,
      color: canUseServices ? AppColors.primaryColor : Colors.grey.shade400,
      width: width * buttonWidth,
      height: height * .055,
    );
  }

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

    if (incompleteProfile) {
      return section(
        text: "يرجى إكمال بيانات الملف الشخصي أولاً.",
        button: OrderActionButton(
          onPressed: home.openCompleteProfile,
          text: "إكمال الملف",
          icon: Icons.person_outline,
          color: AppColors.primaryColor,
          width: width * .5,
          height: height * .055,
        ),
      );
    }
    if (uncanUseServices) {
      return section(
        text: "يرجى تعديل بيانات الملف الشخصي وإعادة إرسالها للمراجعة",
        button: OrderActionButton(
          onPressed: uncanUseServices
              ? home.openUpdateProfile
              : () {
                  AppSnackbar.show("تنبيه", _message());
                },
          text: "تعديل الملف",
          icon: Icons.upload_file,
          color: canUseServices
              ? AppColors.primaryColor
              : AppColors.primaryColor,
          width: width * .5,
          height: height * .055,
        ),
      );
    }
    if (status == "draft") {
      return section(
        text: "بانتظار رفع الوثائق المطلوبة لإكمال الطلب",
        button: _actionButton(
          onPressed: home.openUploadDocuments,
          text: "تكملة الطلب",
          icon: Icons.upload_file,
          width: width,
          height: height,
          buttonWidth: .5,
        ),
      );
    }
    if (!hasApplication) {
      return section(
        text: "ابدأ بإنشاء طلب جديد وستظهر هنا حالة الطلب والخطوات القادمة",
        button: _actionButton(
          onPressed: home.openNewApplication,
          text: "إنشاء طلب",
          icon: Icons.add_circle_outline,
          width: width,
          height: height,
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
                ? home.openOrderDetails
                : () {
                    AppSnackbar.show("تنبيه", _message());
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
    if (status == "documents_rejected") {
      return section(
        text: "تم رفض بعض الوثائق، يرجى إعادة رفع الوثائق المطلوبة.",
        button: _actionButton(
          onPressed: home.openUploadDocuments,
          text: "إعادة رفع الوثائق",
          icon: Icons.upload_file,
          width: width,
          height: height,
          buttonWidth: .5,
        ),
      );
    }
    if (status == "payment_pending") {
      return section(
        text: "بانتظار دفع الرسوم للانتقال للمرحلة التالية",
        button: _actionButton(
          onPressed: () {
            Get.to(
              () => PaymentScreen(applicationId: home.applicationId.value),
            );
          },
          text: "دفع الرسوم",
          icon: Icons.credit_card_outlined,
          width: width,
          height: height,
        ),
      );
    }
    if (status == "appointment_pending") {
      return section(
        text: "تمت الموافقة على طلبك، يمكنك الآن حجز موعد الاختبار",
        button: _actionButton(
          onPressed: () {
            if (home.applicationId.value > 0) {
              Get.toNamed(
                '/available_tests_page',
                arguments: home.applicationId.value,
              );
            }
          },
          text: "حجز موعد",
          icon: Icons.calendar_month_outlined,
          width: width,
          height: height,
        ),
      );
    }
    if (status == "in_testing") {
      return section(
        text:
            "مرحلة الاختبارات مفعّلة لديك، يمكنك حجز موعد اختبار أو متابعة المواعيد الحالية حسب حالتها.",
        button: SizedBox(
          width: width * .47,
          height: height * .055,
          child: ElevatedButton.icon(
            onPressed: canUseServices
                ? home.openOrderDetails
                : () {
                    AppSnackbar.show("تنبيه", _message());
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
    if (status == "waiting_retest") {
      return section(
        text: "يمكنك إعادة الاختبار وحجز موعد جديد",
        button: _actionButton(
          onPressed: () {
            if (home.applicationId.value > 0) {
              Get.toNamed(
                'available_tests_page',
                arguments: home.applicationId.value,
              );
            }
          },
          text: "إعادة الاختبار",
          icon: Icons.refresh,
          width: width,
          height: height,
        ),
      );
    }
    if (status == "approved") {
      return section(
        text: "تم اجتياز جميع المراحل بنجاح، بانتظار إصدار الرخصة.",
        button: OrderActionButton(
          onPressed: canUseServices
              ? home.openOrderDetails
              : () {
                  AppSnackbar.show("تنبيه", _message());
                },
          text: "بانتظار الرخصة",
          icon: Icons.check,
          color: canUseServices ? AppColors.primaryColor : Colors.grey.shade400,
          width: width * .47,
          height: height * .055,
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
