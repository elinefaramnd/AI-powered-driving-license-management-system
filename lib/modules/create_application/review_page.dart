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
      appBar: AppBar(title: const Text("مراجعة الطلب")),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Text("Service ID: ${controller.serviceTypeId.value}"),

            const SizedBox(height: 10),

            Text("License ID: ${controller.licenseTypeId.value}"),

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
                      Get.snackbar("نجح", "تم إرسال الطلب");
                    } else {
                      Get.snackbar("خطأ", data["message"] ?? "فشل الإرسال");
                    }
                  } catch (e) {
                    Get.snackbar("خطأ", e.toString());
                  }
                },

                child: const Text("إرسال الطلب"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
