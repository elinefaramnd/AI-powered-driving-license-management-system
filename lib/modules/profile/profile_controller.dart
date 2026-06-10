import 'dart:convert';
import 'package:get/get.dart';
import 'package:project_2/widgets/app_snackbar.dart';
import '../../configuration/http_helpers.dart';

class ProfileController extends GetxController {
  var isLoading = false.obs;
  RxMap<String, dynamic> userData = <String, dynamic>{}.obs;
  @override
  void onInit() {
    getProfile();
    super.onInit();
  }
  Future<void> getProfile() async {
    try {
      isLoading.value = true;
      final response = await HttpHelper.gettData(url: "auth/me");
      final data = jsonDecode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        userData.value = data["data"];
      } else {
        AppSnackbar.show("خطأ", data["message"] ?? "فشل");
      }
    } catch (e) {
      AppSnackbar.show("خطأ", e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
