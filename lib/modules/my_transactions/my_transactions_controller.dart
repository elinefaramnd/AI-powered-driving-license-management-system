import 'dart:convert';

import 'package:get/get.dart';

import '../../configuration/http_helpers.dart';
import 'my_transaction_model.dart';

class MyTransactionsController extends GetxController {
  final RxInt selectedTab = 0.obs;

  final RxBool loadingApplications = false.obs;
  final RxBool loadingFines = false.obs;

  final RxList<MyTransactionModel> applicationTransactions =
      <MyTransactionModel>[].obs;

  final RxList<MyTransactionModel> fineTransactions =
      <MyTransactionModel>[].obs;

  final RxString applicationError = ''.obs;
  final RxString fineError = ''.obs;

  @override
  void onInit() {
    super.onInit();

    loadApplicationTransactions();
    loadFineTransactions();
  }

  void changeTab(int index) {
    selectedTab.value = index;
  }

  Future<void> loadApplicationTransactions() async {
    loadingApplications.value = true;
    applicationError.value = '';

    try {
      final response = await HttpHelper.gettData(
        url: 'payments?type=application&page=1&per_page=15',
      );

      final body = jsonDecode(response.body);

      if (response.statusCode == 200 && body['success'] == true) {
        final items = body['data']?['items'] ?? [];

        applicationTransactions.value = items
            .map<MyTransactionModel>(
              (item) => MyTransactionModel.fromJson(item),
        )
            .toList();
      } else {
        applicationError.value =
            body['message'] ?? 'something_went_wrong'.tr;
      }
    } catch (e) {
      applicationError.value = 'something_went_wrong'.tr;
      print('APPLICATION TRANSACTIONS ERROR: $e');
    } finally {
      loadingApplications.value = false;
    }
  }

  Future<void> loadFineTransactions() async {
    loadingFines.value = true;
    fineError.value = '';

    try {
      final response = await HttpHelper.gettData(
        url: 'payments?type=fine&page=1&per_page=15',
      );

      final body = jsonDecode(response.body);

      if (response.statusCode == 200 && body['success'] == true) {
        final items = body['data']?['items'] ?? [];

        fineTransactions.value = items
            .map<MyTransactionModel>(
              (item) => MyTransactionModel.fromJson(item),
        )
            .toList();
      } else {
        fineError.value =
            body['message'] ?? 'something_went_wrong'.tr;
      }
    } catch (e) {
      fineError.value = 'something_went_wrong'.tr;
      print('FINE TRANSACTIONS ERROR: $e');
    } finally {
      loadingFines.value = false;
    }
  }

  Future<void> refreshCurrentTab() async {
    if (selectedTab.value == 0) {
      await loadApplicationTransactions();
    } else {
      await loadFineTransactions();
    }
  }

  List<MyTransactionModel> get currentTransactions {
    if (selectedTab.value == 0) {
      return applicationTransactions;
    }

    return fineTransactions;
  }

  bool get currentLoading {
    if (selectedTab.value == 0) {
      return loadingApplications.value;
    }

    return loadingFines.value;
  }

  String get currentError {
    if (selectedTab.value == 0) {
      return applicationError.value;
    }

    return fineError.value;
  }
}