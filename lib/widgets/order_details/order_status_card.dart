import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import '../../../app_theme/app_colors.dart';
import '../../modules/my_applications/my_orders/order_model.dart';

class OrderStatusCard extends StatelessWidget {
  final OrderModel order;

  const OrderStatusCard({
    super.key,
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isRtl = Directionality.of(context) == TextDirection.rtl;
    final w = size.width;
    final h = size.height;
    final status = order.status;

    final documents = order.documents;

    final allDocumentsPendingReview =
        documents.isNotEmpty &&
            documents.every(
                  (doc) => doc["status"] == "pending_review",
            );

    final hasRejectedDocument = documents.any(
          (doc) => doc["status"] == "rejected",
    );
    String title;
    String description;
    String statusText;

    if (hasRejectedDocument) {
      title = "documents_rejected".tr;
      description = "documents_rejected_description".tr;
      statusText = "rejected".tr;
    } else if (status == "draft") {
      title = "documents_required".tr;
      description = "documents_required_description".tr;
      statusText = "waiting_for_documents".tr;
    } else if (status == "documents_under_review" &&
        allDocumentsPendingReview) {
      title = "documents_completed".tr;
      description = "documents_completed_description".tr;
      statusText = "under_review".tr;
    } else if (status == "payment_pending") {
      title = "documents_completed".tr;
      description = "documents_completed_description".tr;
      statusText = "waiting_for_payment".tr;
    }  else if (status == "in_testing") {
      title = "in_testing".tr;
      description = "in_testing_description".tr;
      statusText = "in_testing".tr;
    }else if (status == "approved") {
      title = "license_approved".tr;
      description = "license_approved_description".tr;
      statusText = "waiting_for_license".tr;
    } else if (status == "license_issued") {
      title = "license_issued".tr;
      description = "license_issued_description".tr;
      statusText = "license_ready".tr;
    } else {
      title = "documents_completed".tr;
      description = "documents_completed_description".tr;
      statusText = "under_review".tr;
    }

    return Container(
      width: double.infinity,
      height: h * 0.17,
      padding: EdgeInsets.symmetric(
        horizontal: w * 0.05,
        vertical: h * 0.015,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(w * 0.025),
        color: AppColors.primaryColor,
      ),
      child: Row(
        children: [
          Image.asset(
            "assets/images/download1.png",
            width: w * 0.32,
            height: w * 0.32,
            fit: BoxFit.contain,
          ),
          SizedBox(width:  w * 0.038),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 Text(
                   title,
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize:isRtl? w * 0.044:w * 0.04,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                 Text(
                   description,
                   textAlign: isRtl ? TextAlign.right : TextAlign.left,
                  style: TextStyle(
                    color: Colors.white,
                    height: 1.5,
                    fontSize: w * 0.029,
                  ),
                ),
                SizedBox(height:  h * 0.019),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: w * 0.013,
                    vertical: h * 0.0012,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(w * 0.075),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.check_circle,
                        color: AppColors.primaryColor,
                        size: w * 0.05,
                      ),
                      SizedBox(width:  w * 0.013),
                      Text(
                        statusText,
                        style: TextStyle(
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize:isRtl? w * 0.035:w * 0.033,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}