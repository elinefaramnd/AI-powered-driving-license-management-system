import 'package:get/get.dart';

class ChatBotController extends GetxController {
  RxBool showMessage = true.obs;

  void close() {
    print("CLOSE CLICKED");
    showMessage.value = false;
  }
}