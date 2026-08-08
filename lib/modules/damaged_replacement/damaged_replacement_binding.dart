import 'package:get/get.dart';
import 'damaged_replacement_controller.dart';

class DamagedReplacementBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<DamagedReplacementController>(DamagedReplacementController());
  }
}
