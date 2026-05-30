import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../app_theme/app_colors.dart';
import '../../widgets/bottom_section.dart';
import '../../widgets/documents_list.dart';
import '../../widgets/remaining_docs.dart';
import 'upload_documents_controller.dart';

class UploadDocumentsPage extends StatelessWidget {
  const UploadDocumentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    print("GET ARGUMENT => ${Get.arguments}");
    print("TYPE => ${Get.arguments.runtimeType}");

    final controller =
    Get.put(UploadDocumentsController(Get.arguments));

    return Scaffold(
      backgroundColor: const Color(0xffF4F4F4),

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "رفع الوثائق",
          style: TextStyle(
            color: AppColors.primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: Obx(() {
        if (controller.loading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return Column(
          children: [
            RemainingDocs(controller: controller),

            Expanded(
              child: DocumentsList(controller: controller),
            ),

            BottomSection(controller: controller),
          ],
        );
      }),
    );
  }
}


