import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../configuration/http_helpers.dart';
import 'test_result_model.dart';

class TestResultsController extends GetxController {
  RxBool loading = false.obs;
  RxList<TestResultModel> testResults = <TestResultModel>[].obs;
  RxString applicationId = ''.obs;

  final box = GetStorage();

  @override
  void onInit() {
    super.onInit();
    // Try to get application_id from storage, or use a default for testing
    final storedAppId = box.read<int>('application_id');
    if (storedAppId != null) {
      applicationId.value = storedAppId.toString();
    } else {
      applicationId.value = '3'; // Default for testing
    }
    getTestResults();
  }

  Future<void> getTestResults() async {
    try {
      loading.value = true;

      final response = await HttpHelper.gettData(
        url: "applications/${applicationId.value}/test-results",
      );

      final data = jsonDecode(response.body);

      if (data["success"] == true) {
        final List items = data["data"];
        testResults.value = items.map((e) => TestResultModel.fromJson(e)).toList();
      }
    } catch (e) {
      print('Error fetching test results: $e');
    } finally {
      loading.value = false;
    }
  }

  String getResultText(String result) {
    switch (result) {
      case 'passed':
        return 'ناجح';
      case 'failed':
        return 'راسب';
      case 'pending':
        return 'معلق';
      default:
        return result;
    }
  }

  Color getResultColor(String result) {
    switch (result) {
      case 'passed':
        return Colors.green;
      case 'failed':
        return Colors.red;
      case 'pending':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  IconData getTestTypeIcon(String code) {
    switch (code) {
      case 'vision':
        return Icons.visibility_outlined;
      case 'theory':
        return Icons.menu_book_outlined;
      case 'practical':
        return Icons.drive_eta_outlined;
      default:
        return Icons.assignment_outlined;
    }
  }

  String getTestTypeName(String code) {
    switch (code) {
      case 'vision':
        return 'اختبار النظر';
      case 'theory':
        return 'الاختبار النظري';
      case 'practical':
        return 'الاختبار العملي';
      default:
        return code;
    }
  }

  int get passedCount => testResults.where((t) => t.result == 'passed').length;
  int get failedCount => testResults.where((t) => t.result == 'failed').length;
  int get pendingCount => testResults.where((t) => t.result == 'pending').length;
}
