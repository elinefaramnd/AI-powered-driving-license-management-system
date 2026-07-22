import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../configuration/http_helpers.dart';
import 'application_controller.dart';

class ReviewPage extends StatelessWidget {
  ReviewPage({super.key});
  final ApplicationController controller = Get.find<ApplicationController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:Text("review_application".tr),),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Text("${"service_id".tr}: ${controller.serviceTypeId.value}"),

            const SizedBox(height: 10),

            Text("${"license_id".tr}: ${controller.licenseTypeId.value}"),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,

              child: ElevatedButton(
                onPressed: () async {
                  try {
                    final response = await HttpHelper.postData(
                      url:
                          "applications/${controller.applicationId.value}/submit",
                    );

                    final data = jsonDecode(response.body);

                    if (response.statusCode == 200 ||
                        response.statusCode == 201) {
                      Get.snackbar(
                        "success".tr,
                        "application_sent".tr,
                      );
                    } else {
                      Get.snackbar(
                        "error".tr,
                        data["message"] ?? "submission_failed".tr,
                      );
                    }
                  } catch (e) {
                    Get.snackbar("خطأ", e.toString());
                  }
                },

                child: Text("submit_application".tr),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
