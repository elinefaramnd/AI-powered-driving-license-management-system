import 'dart:convert';
import 'package:get/get.dart';
import '../../configuration/http_helpers.dart';
import 'privacy_policy_model.dart';

class PrivacyPolicyController extends GetxController {
  RxBool isLoading = false.obs;
  Rxn<PrivacyPolicyModel> policy = Rxn<PrivacyPolicyModel>();
  RxString errorMessage = ''.obs;
  RxList<bool> expandedSections = <bool>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchPrivacyPolicy();
  }

  Future<void> fetchPrivacyPolicy() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      final response = await HttpHelper.gettData(url: 'content/privacy-policy');

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        if (data['success'] == true) {
          policy.value = PrivacyPolicyModel.fromJson(data['data']);
          expandedSections.value =
              List<bool>.filled(policy.value!.sections.length, false);
        } else {
          errorMessage.value = data['message'] ?? 'حدث خطأ ما';
        }
      } else {
        errorMessage.value = 'فشل جلب سياسة الخصوصية';
      }
    } catch (e) {
      errorMessage.value = 'حدث خطأ أثناء الاتصال بالخادم';
      print('Error fetching privacy policy: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void toggleSection(int index) {
    if (index < expandedSections.length) {
      expandedSections[index] = !expandedSections[index];
      expandedSections.refresh();
    }
  }
}
