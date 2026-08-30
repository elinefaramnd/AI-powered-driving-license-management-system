import 'dart:convert';

import 'package:get/get.dart';

import '../../../configuration/http_helpers.dart';

class TransactionDetailsController extends GetxController {
  final int transactionId;

  TransactionDetailsController({
    required this.transactionId,
  });

  final RxBool loading = true.obs;
  final Rxn<Map<String, dynamic>> transaction =
  Rxn<Map<String, dynamic>>();

  final RxString error = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadDetails();
  }

  Future<void> loadDetails() async {
    loading.value = true;
    error.value = '';

    try {
      final response = await HttpHelper.gettData(
        url: 'payments/$transactionId',
      );

      final body = jsonDecode(response.body);

      if (response.statusCode == 200 &&
          body['success'] == true) {
        transaction.value =
        Map<String, dynamic>.from(body['data']);
      } else {
        error.value =
            body['message'] ?? 'something_went_wrong'.tr;
      }
    } catch (e) {
      error.value = 'something_went_wrong'.tr;
      print('TRANSACTION DETAILS ERROR: $e');
    } finally {
      loading.value = false;
    }
  }
}