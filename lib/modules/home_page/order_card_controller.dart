import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_2/modules/my_licenses/my_licenses_screen.dart';
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
              AppSnackbar.show("warning".tr, _message());
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
        "next_step".tr,
            style: TextStyle(
              color: AppColors.primaryColor,
              fontWeight: FontWeight.bold,
              fontSize: Get.locale?.languageCode == "ar" ? width * .039:width * .036,
            ),
          ),
          SizedBox(height: height * .01),
          Text(text, style: TextStyle(fontSize: width * .034)),
          SizedBox(height: height * .02),
          button,
        ],
      );
    }

    if (incompleteProfile) {
      return section(
        text: "complete_profile_first_step".tr,
        button: OrderActionButton(
          onPressed: home.openCompleteProfile,
          text: "complete_profile".tr,
          icon: Icons.person_outline,
          color: AppColors.primaryColor,
          width: width * .5,
          height: height * .055,
        ),
      );
    }
    if (uncanUseServices) {
      return section(
        text: "update_profile_message".tr,
        button: OrderActionButton(
          onPressed: uncanUseServices
              ? home.openUpdateProfile
              : () {
                  AppSnackbar.show("warning".tr, _message());
                },
          text: "edit_profile".tr,
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
        text: "upload_documents_message".tr,
        button: _actionButton(
          onPressed: home.openUploadDocuments,
          text: "complete_request".tr,
          icon: Icons.upload_file,
          width: width,
          height: height,
          buttonWidth: .5,
        ),
      );
    }
    if (!hasApplication) {
      return section(
        text: "create_request_message".tr,
        button: _actionButton(
          onPressed: home.openNewApplication,
          text: "create_request".tr,
          icon: Icons.add_circle_outline,
          width: width,
          height: height,
        ),
      );
    }
    if (status == "documents_under_review") {
      return section(
        text: "documents_under_review_message".tr,
        button: SizedBox(
          width: width * .47,
          height: height * .055,
          child: ElevatedButton.icon(
            onPressed: canUseServices
                ? home.openOrderInfo
                : () {
                    AppSnackbar.show("warning".tr, _message());
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
            label: Text(
              "view_request".tr,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      );
    }
    if (status == "documents_rejected") {
      return section(
        text: "documents_rejected_message".tr,
        button: _actionButton(
          onPressed: home.openUploadDocuments,
          text: "reupload_documents".tr,
          icon: Icons.upload_file,
          width: width,
          height: height,
          buttonWidth: .5,
        ),
      );
    }
    if (status == "payment_pending") {
      return section(
        text: "payment_pending_message".tr,
        button: _actionButton(
          onPressed: () {
            Get.to(
              () => PaymentScreen(applicationId: home.applicationId.value),
            );
          },
          text: "pay_fees".tr,
          icon: Icons.credit_card_outlined,
          width: width,
          height: height,
        ),
      );
    }
    if (status == "appointment_pending") {
      return section(
        text: "appointment_pending_message".tr,
        button: _actionButton(
          onPressed: () {
            if (home.applicationId.value > 0) {
              Get.toNamed(
                '/available_tests_page',
                arguments: home.applicationId.value,
              );
            }
          },
          text: "book_appointment".tr,
          icon: Icons.calendar_month_outlined,
          width: width,
          height: height,
        ),
      );
    }
    if (status == "in_testing") {
      return section(
        text:
        "testing_stage_message".tr,
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
            label: Text(
              "view_details".tr,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      );
    }
    if (status == "waiting_retest") {
      return section(
        text: "waiting_retest_message".tr,
        button: _actionButton(
          onPressed: () {
            if (home.applicationId.value > 0) {
              Get.toNamed(
                'available_tests_page',
                arguments: home.applicationId.value,
              );
            }
          },
          text: "retest".tr,
          icon: Icons.refresh,
          width: width,
          height: height,
        ),
      );
    }
    if (status == "approved") {
      return section(
        text: "license_waiting_message".tr,
        button: OrderActionButton(
          onPressed: canUseServices
              ? () {
            Get.toNamed("/my_licenses");
          }
              : () {
            AppSnackbar.show("تنبيه", _message());
          },
          text: "waiting_license".tr,
          icon: Icons.check,
          color: canUseServices ? AppColors.primaryColor : Colors.grey.shade400,
          width: width * .47,
          height: height * .055,
        ),
      );
    }
    if (status == "license_issued") {
      return section(
        text: "license_issued_message".tr,
        button: OrderActionButton(
          onPressed: canUseServices
              ? () {
            Get.toNamed("/my_licenses");
          }
              : () {
            AppSnackbar.show("تنبيه", _message());
          },
          text: "license_issued".tr,
          icon: Icons.badge_outlined,
          color: canUseServices
              ? AppColors.primaryColor
              : Colors.grey.shade400,
          width: width * .47,
          height: height * .055,
        ),
      );
    }
    if (status == "completed") {
      return section(
        text: "unblock_license".tr,
        button: _actionButton(
          onPressed: () {
            Get.to(
                  () => MyLicensesScreen(),
            );
          },
          text: "view_license".tr,
          icon: Icons.credit_card_outlined,
          width: width,
          height: height,
        ),
      );
    }
    return const SizedBox();
  }

  String _message() {
    final status = profileStatus.value;

    if (status == "pending_review") {
      return "account_under_review".tr;
    } else if (status == "rejected") {
      return "profile_rejected".tr;
    } else {
      return "complete_profile_first".tr;
    }
  }
}
