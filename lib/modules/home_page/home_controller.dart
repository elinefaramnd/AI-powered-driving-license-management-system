import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  var selectedIndex = 0.obs;
  var notificationsCount = 3.obs;

  void openDrawer() {
    scaffoldKey.currentState?.openDrawer();
  }

  void selectMenu(int index) {
    selectedIndex.value = index;
  }

  void logout() {
    Get.offAllNamed('/signIn');
  }
}