import 'dart:convert';
import 'package:get/get.dart';
import '../../configuration/http_helpers.dart';
import 'fine_model.dart';

class FinesController extends GetxController {
  RxBool loading = false.obs;
  RxList<FineModel> fines = <FineModel>[].obs;
  RxDouble totalAmount = 0.0.obs;
  RxInt totalCount = 0.obs;
  @override
  void onInit() {
    super.onInit();
    getFines();
  }

  Future<void> getFines() async {
    try {
      loading.value = true;
      final response = await HttpHelper.gettData(url: "fines");
      print(response.body);

      final data = jsonDecode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        final list = data["data"] as List;
        fines.value = list.map((e) => FineModel.fromJson(e)).toList();
        totalAmount.value = fines.fold(0, (sum, fine) => sum + fine.amount);
        totalCount.value = fines.length;
      }
    } catch (e) {
      print(e);
    } finally {
      loading.value = false;
    }
  }
}
