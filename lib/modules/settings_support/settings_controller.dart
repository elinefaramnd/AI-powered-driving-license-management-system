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
            'نجاح',
            'تم تحديث التفضيلات بنجاح',
            snackPosition: SnackPosition.BOTTOM,
          );
        }
      }
    } catch (e) {
      print('Error updating preferences: $e');
      Get.snackbar(
        'خطأ',
        'فشل تحديث التفضيلات',
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
            'نجاح',
            'تم تغيير كلمة المرور بنجاح',
            snackPosition: SnackPosition.BOTTOM,
          );
        } else {
          Get.snackbar(
            'خطأ',
            data['message'] ?? 'فشل تغيير كلمة المرور',
            snackPosition: SnackPosition.BOTTOM,
          );
        }
      } else {
        final data = jsonDecode(response.body);
        Get.snackbar(
          'خطأ',
          data['message'] ?? 'فشل تغيير كلمة المرور',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      print('Error changing password: $e');
      Get.snackbar(
        'خطأ',
        'حدث خطأ أثناء تغيير كلمة المرور',
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
        return 'معتمد';
      case 'pending':
        return 'معلق';
      case 'rejected':
        return 'مرفوض';
      default:
        return status ?? '';
    }
  }

  String get profileStatusDescription {
    return settings.value?.account.profileCompleted == true
        ? 'اكتمال الملف الشخصي'
        : 'الملف الشخصي غير مكتمل';
  }

  double get profileCompletionPercentage {
    return settings.value?.account.profileCompleted == true ? 100.0 : 50.0;
  }
}
