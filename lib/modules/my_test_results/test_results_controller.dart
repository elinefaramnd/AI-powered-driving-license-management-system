import 'dart:convert';
import 'package:get/get.dart';
import '../../configuration/http_helpers.dart';
import 'test_result_model.dart';

class TestResultsController extends GetxController {
  RxBool isLoading = false.obs;

  RxList<TestResultModel> results = <TestResultModel>[].obs;

  late final int applicationId;

  @override
  void onInit() {
    super.onInit();
    applicationId = Get.arguments;
    print("ARGUMENTS = ${Get.arguments}");
    fetchResults();
  }

  Future<void> fetchResults() async {
    try {
      isLoading.value = true;

      final response = await HttpHelper.gettData(
        url: 'applications/$applicationId/test-results',
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        results.value = (data["data"] as List)
            .map((e) => TestResultModel.fromJson(e))
            .toList();
      }
    } catch (e) {
      print("TEST RESULTS ERROR: $e");
    } finally {
      isLoading.value = false;
    }
  }

  TestResultModel? get item => results.isNotEmpty ? results.first : null;

  String getNotes(String notes) {
    if (notes == "Citizen met requirements.") {
      return "المواطن استوفى المتطلبات";
    }

    return notes;
  }

  String getResultText(String result) {
    switch (result) {
      case "passed":
        return "ناجح";

      case "failed":
        return "راسب";

      case "pending":
        return "قيد الانتظار";

      default:
        return result;
    }
  }

  String getTestDescription(String code) {
    switch (code) {
      case "vision":
        return "فحص النظر للرخصة";

      case "theory":
        return "اختبار القيادة النظري";

      case "practical":
        return "اختبار القيادة العملي";

      default:
        return "اختبار";
    }
  }

  String getDate(DateTime date) {
    return "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
  }

  bool isPassed(String result) {
    return result == "passed";
  }

  bool isFailed(String result) {
    return result == "failed";
  }

  bool isPending(String result) {
    return result == "pending";
  }
}
