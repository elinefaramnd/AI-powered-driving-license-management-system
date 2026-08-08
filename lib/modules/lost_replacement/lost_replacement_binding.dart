import 'package:get/get.dart';
import 'lost_replacement_controller.dart';

class LostReplacementBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LostReplacementController>(
      () => LostReplacementController(),
      fenix: true,
    );
  }
}

