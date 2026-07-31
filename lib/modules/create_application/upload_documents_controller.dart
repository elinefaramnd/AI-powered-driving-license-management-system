import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import '../../app/controllers/app_update_controller.dart';
import '../../configuration/http_helpers.dart';
import '../../helpers/document_picker_service.dart';
import '../../widgets/app_snackbar.dart';
import '../home_page/home_controller.dart';

class UploadDocumentsController extends GetxController {
  final int applicationId;
  UploadDocumentsController(this.applicationId);
  RxBool loading = false.obs;
  RxBool submitted = false.obs;
  RxList documents = [].obs;
  RxSet<int> uploadedIds = <int>{}.obs;
  RxMap<int, File?> uploadedFiles = <int, File?>{}.obs;
  RxList rejectedDocuments = [].obs;
  final box = GetStorage();
  int get uploadedCount {
    return documents.where((doc) {
      final latest = doc["latest_document"];
      return uploadedIds.contains(doc["id"]) ||
          (latest != null && latest is Map && latest.isNotEmpty);
    }).length;
  }
  int get remaining {
    return documents.length - uploadedCount;
  }
  bool get canSubmit {
    return remaining == 0 && documents.isNotEmpty;
  }
  @override
  void onInit() {
    super.onInit();
    getRequiredDocuments();
  }
  Future<void> getRequiredDocuments() async {
    try {
      loading.value = true;
      final response = await HttpHelper.gettData(
        url: "applications/$applicationId/required-documents",
      );
      print("APPLICATION ID = $applicationId");
      print(response.body);
      final data = jsonDecode(response.body);
      documents.value = data["data"];
    } catch (e) {
      Get.snackbar("upload_error".tr, e.toString());
      print(e.toString());
    } finally {
      loading.value = false;
    }
    final details = await HttpHelper.gettData(
      url: "applications/$applicationId",
    );

    final app = jsonDecode(details.body)["data"];

    rejectedDocuments.value = app["documents"];
  }
  Future<void> uploadDocument(int requiredId) async {
    try {
      final file = await DocumentPickerService.pick();
      if (file == null) {
        return;
      }
      loading.value = true;
      uploadedFiles[requiredId] = file;
      final token = box.read("token");
      var request = http.MultipartRequest(
        "POST",
        Uri.parse("${baseurl}applications/$applicationId/documents"),
      );
      request.headers.addAll({
        "Accept": "application/json",
        if (token != null) "Authorization": "Bearer $token",
      });
      request.fields["required_document_id"] = requiredId.toString();
      request.files.add(await http.MultipartFile.fromPath("file", file.path));
      final response = await request.send();
      final responseBody = await response.stream.bytesToString();
      print("STATUS: ${response.statusCode}");
      print("BODY: $responseBody");
      print("HEADERS: ${response.headers}");
      if (response.statusCode == 200 || response.statusCode == 201) {
        uploadedIds.add(requiredId);
        await getRequiredDocuments();
        Get.find<AppUpdateController>().notifyChange();
        AppSnackbar.show(
          "upload_success".tr,
          "upload_document_uploaded".tr,
        );
      } else {
        final body = await response.stream.bytesToString();
        AppSnackbar.show(
            "upload_error".tr, body
        );
      }
    } catch (e) {
      AppSnackbar.show(
          "upload_error".tr,  e.toString()
      );
    } finally {
      loading.value = false;
    }
  }
  Future<void> submitDocuments() async {
    if (!canSubmit) {
      AppSnackbar.show(
        "upload_warning".tr,
        "upload_upload_all_documents".tr,
      );
      return;
    }
    try {
      loading.value = true;
      final response = await HttpHelper.postData(
        url: "applications/$applicationId/submit-documents",
      );
      final data = jsonDecode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        submitted.value = true;
        if (Get.isRegistered<HomeController>()) {
          await Get.find<HomeController>().getCurrentApplication();
        }
        Get.find<AppUpdateController>().notifyChange();
        AppSnackbar.show( "upload_success".tr,
          "upload_documents_submitted".tr,);
      } else {
        AppSnackbar.show( "upload_error".tr, data["message"]);
        print(data["message"]);
        print(response.statusCode);
      }
    } finally {
      loading.value = false;
    }
  }
}
