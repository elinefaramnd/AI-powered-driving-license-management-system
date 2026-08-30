import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../modules/settings_support/settings_controller.dart';

class LanguageController extends GetxController {
  final storage = GetStorage();

  Rx<Locale> locale = const Locale("ar").obs;

  @override
  void onInit() {
    super.onInit();

    String? savedLang = storage.read("lang");

    if (savedLang != null) {
      locale.value = Locale(savedLang);
    } else {
      locale.value = const Locale("ar");
    }
  }

  Future<void> changeLanguage(String code) async {
    final newLocale = Locale(code);
    locale.value = newLocale;
    Get.updateLocale(newLocale);
    await storage.write("lang", code);
    await Get.find<SettingsController>().updateLanguage(code);
  }
}