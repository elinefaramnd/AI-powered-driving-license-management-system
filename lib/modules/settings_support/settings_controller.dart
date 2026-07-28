import 'dart:convert';
import 'package:get/get.dart';
import '../../configuration/http_helpers.dart';
import 'models/settings_model.dart';

class SettingsController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isUpdating = false.obs;
  
  Rxn<SettingsModel> settings = Rxn<SettingsModel>();
  
  @override
  void onInit() {
    super.onInit();
    fetchSettings();
  }

  Future<void> fetchSettings() async {
    try {
      isLoading.value = true;
      final response = await HttpHelper.gettData(url: "settings");
      
      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        if (data['success'] == true) {
          settings.value = SettingsModel.fromJson(data['data']);
        }
      }
    } catch (e) {
      print('Error fetching settings: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updatePreferences({
    required String language,
    required String theme,
  }) async {
    try {
      isUpdating.value = true;
      final response = await HttpHelper.putData(
        url: "settings/preferences",
        body: {
          'language': language,
          'theme': theme,
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        if (data['success'] == true) {
          settings.value?.preferences.language = language;
          settings.value?.preferences.theme = theme;
          settings.refresh();
          Get.snackbar(
            "success".tr,
            "preferences_updated".tr,
            snackPosition: SnackPosition.BOTTOM,
          );
        }
      }
    } catch (e) {
      print('Error updating preferences: $e');
      Get.snackbar(
        "error".tr,
        "preferences_update_failed".tr,
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isUpdating.value = false;
    }
  }

  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    try {
      isUpdating.value = true;
      final response = await HttpHelper.putData(
        url: "settings/change-password",
        body: {
          'current_password': currentPassword,
          'new_password': newPassword,
          'new_password_confirmation': confirmPassword,
        },
      );

     
      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        if (data['success'] == true) {
          Get.back();
          Get.snackbar(
            "success".tr,
            "password_changed".tr,
            snackPosition: SnackPosition.BOTTOM,
          );
        } else {
          Get.snackbar(
            "error".tr,
            data['message'] ?? "password_change_failed".tr,
            snackPosition: SnackPosition.BOTTOM,
          );
        }
      } else {
        final data = jsonDecode(response.body);
        Get.snackbar(
          "error".tr,
          data['message'] ?? "password_change_failed".tr,
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      print('Error changing password: $e');
      Get.snackbar(
        "error".tr,
        "password_change_server_error".tr,
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isUpdating.value = false;
    }
  }

  String get profileStatusText {
    final status = settings.value?.account.profileStatus;
    switch (status) {
      case 'approved':
        return "profile_approved".tr;
      case 'pending':
        return "profile_pending".tr;
      case 'rejected':
        return "rejected".tr;
      default:
        return status ?? '';
    }
  }

  String get profileStatusDescription {
    return settings.value?.account.profileCompleted == true
        ? "profile_completed".tr
        : "profile_not_completed".tr;
  }

  double get profileCompletionPercentage {
    return settings.value?.account.profileCompleted == true ? 100.0 : 50.0;
  }
}
