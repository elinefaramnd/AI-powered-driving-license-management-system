import 'dart:convert';
import 'package:get/get.dart';
import '../../configuration/http_helpers.dart';
import 'contact_us_model.dart';

class ContactUsController extends GetxController {
  RxBool isLoading = false.obs;
  Rxn<ContactUsModel> contactInfo = Rxn<ContactUsModel>();
  RxString errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchContactInfo();
  }

  Future<void> fetchContactInfo() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final response = await HttpHelper.gettData(url: 'content/contact-info');

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        if (data['success'] == true) {
          contactInfo.value = ContactUsModel.fromJson(data['data']);
        } else {
          errorMessage.value = data['message'] ?? 'حدث خطأ ما';
        }
      } else {
        errorMessage.value = 'فشل جلب معلومات التواصل';
      }
    } catch (e) {
      errorMessage.value = 'حدث خطأ أثناء الاتصال بالخادم';
      print('Error fetching contact info: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
