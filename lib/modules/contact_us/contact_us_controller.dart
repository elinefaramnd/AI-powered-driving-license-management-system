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
          errorMessage.value = data['message'] ??  "something_went_wrong".tr;
        }
      } else {
        errorMessage.value = "failed_fetch_contact_info".tr;
      }
    } catch (e) {
      errorMessage.value =  "server_connection_error".tr;
      print('Error fetching contact info: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
