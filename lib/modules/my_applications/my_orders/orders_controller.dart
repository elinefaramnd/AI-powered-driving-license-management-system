import 'dart:convert';
import 'package:get/get.dart';

import '../../../configuration/http_helpers.dart';
import 'order_model.dart';

class OrdersController extends GetxController {
  RxBool loading = false.obs;
  RxList<OrderModel> orders = <OrderModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    getOrders();
  }

  Future<void> getOrders() async {
    try {
      loading.value = true;

      final response = await HttpHelper.gettData(
        url: "applications?per_page=15",
      );

      final data = jsonDecode(response.body);

      final List items = data["data"]["items"];

      orders.value = items.map((e) => OrderModel.fromJson(e)).toList();
    } catch (e) {
      print(e);
    } finally {
      loading.value = false;
    }
  }

  void openDetails(OrderModel order) {
    Get.toNamed("/order_details", arguments: order);
  }
}
