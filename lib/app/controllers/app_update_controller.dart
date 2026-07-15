import 'package:get/get.dart';

class AppUpdateController extends GetxController {

  RxInt homeRefresh = 0.obs;

  void notifyChange() {
    homeRefresh.value++;
  }

}