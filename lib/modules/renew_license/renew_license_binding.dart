import 'package:get/get.dart';
import 'renew_license_controller.dart';

class RenewLicenseBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RenewLicenseController>(
      () => RenewLicenseController(),
      fenix: true,
    );
  }
}
