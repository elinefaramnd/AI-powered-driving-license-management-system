import 'package:get/get.dart';
import 'home_controller.dart';
import 'order_card_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {

    Get.lazyPut<HomeController>(
          () => HomeController(),
      fenix: true,
    );
    Get.lazyPut<OrderCardController>(
          () => OrderCardController(),
      fenix: true,
    );
  }
}