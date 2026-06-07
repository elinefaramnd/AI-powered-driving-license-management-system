import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../app_theme/app_colors.dart';
import '../../widgets/uploading_documents/bottom_section.dart';
import '../../widgets/uploading_documents/documents_list.dart';
import '../../widgets/uploading_documents/remaining_docs.dart';
import 'upload_documents_controller.dart';
class UploadDocumentsPage extends StatelessWidget {
  const UploadDocumentsPage({super.key});
  @override
  Widget build(BuildContext context) {
    print("GET ARGUMENT => ${Get.arguments}");
    print("TYPE => ${Get.arguments.runtimeType}");
    final controller = Get.put(UploadDocumentsController(Get.arguments));
    return Scaffold(
      backgroundColor: AppColors.background,
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
            Expanded(child: DocumentsList(controller: controller)),
            BottomSection(controller: controller),
          ],
        );
      }),
    );
  }
}
