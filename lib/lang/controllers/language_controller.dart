import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

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

  void changeLanguage(String code) {
    final newLocale = Locale(code);

    storage.write("lang", code);

    locale.value = newLocale;

    Get.updateLocale(newLocale);
  }
}