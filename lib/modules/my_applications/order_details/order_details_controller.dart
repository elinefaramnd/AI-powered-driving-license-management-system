import 'dart:convert';
import 'package:get/get.dart';
import '../../../configuration/http_helpers.dart';
import '../my_orders/order_model.dart';

class OrderDetailsController extends GetxController {
  RxBool loading = false.obs;
  Rx<OrderModel?> order = Rx<OrderModel?>(null);
  @override
  void onInit() {
    super.onInit();
    final arg = Get.arguments;
    if (arg is int) {
      getDetails(arg);
    } else if (arg is OrderModel) {
      getDetails(arg.id);
    } else {
      Get.snackbar("خطأ", "بيانات الطلب غير صحيحة");
    }
  }

  Future<void> getDetails(int id) async {
    try {
      loading.value = true;
      final response = await HttpHelper.gettData(url: "applications/$id");
      final data = jsonDecode(response.body);
      order.value = OrderModel.fromJson(data["data"]);
    } catch (e) {
      print(e);
    } finally {
      loading.value = false;
    }
  }
}
