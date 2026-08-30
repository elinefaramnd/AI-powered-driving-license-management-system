import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../widgets/app_snackbar.dart';
import 'fine_model.dart';
import 'fine_payment_service.dart';

class FineDetailsController extends GetxController with WidgetsBindingObserver {
  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      if (paymentId.value != 0) {
        startStatusCheck();
      }
    } else if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive) {
      stopStatusCheck();
    }
  }

  final loading = false.obs;
  final isCreatingPayment = false.obs;
  final fine = Rxn<FineModel>();
  final paymentId = 0.obs;
  final paymentStatus = ''.obs;
  Timer? _statusTimer;
  Future<void> getFine(int fineId) async {
    try {
      loading.value = true;
      final response = await FinePaymentService.getFine(fineId);
      if (response['success'] == true && response['data'] != null) {
        fine.value = FineModel.fromJson(response['data']);
      }
    } catch (e) {
      print('Get Fine Error: $e');
      AppSnackbar.show('error'.tr, 'حدث خطأ أثناء جلب تفاصيل الغرامة');
    } finally {
      loading.value = false;
    }
  }

  Future<bool> createPayment() async {
    final currentFine = fine.value;
    if (currentFine == null) {
      return false;
    }
    try {
      isCreatingPayment.value = true;
      final response = await FinePaymentService.createPayment(currentFine.id);
      if (response['success'] == true && response['data'] != null) {
        final data = response['data'];
        if (data['payment'] != null) {
          paymentId.value = data['payment']['id'] ?? 0;
        }
        final checkoutUrl = data['checkout_url'];
        if (checkoutUrl != null && checkoutUrl.toString().isNotEmpty) {
          await launchPaymentUrl(checkoutUrl.toString());
        }
        return true;
      }
      AppSnackbar.show(
        'error'.tr,
        response['message'] ?? 'payment_create_failed'.tr,
      );
      return false;
    } catch (e) {
      print('Create Fine Payment Error: $e');
      AppSnackbar.show('error'.tr, 'payment_create_failed'.tr);
      return false;
    } finally {
      isCreatingPayment.value = false;
    }
  }

  Future<void> checkPaymentStatus() async {
    if (fine.value == null || paymentId.value == 0) {
      return;
    }
    try {
      final response = await FinePaymentService.checkPaymentStatus(
        fine.value!.id,
        paymentId.value,
      );
      if (response['success'] == true && response['data'] != null) {
        final data = response['data'];
        final payment = data['payment'] as Map<String, dynamic>?;
        final fineData = data['fine'] as Map<String, dynamic>?;
        final stripe = data['stripe'] as Map<String, dynamic>?;
        final paymentStatusFromApi = payment?['status'];
        final fineStatusFromApi = fineData?['status'];
        final stripeStatus = stripe?['payment_status'];
        print('Payment status: $paymentStatusFromApi');
        print('Fine status: $fineStatusFromApi');
        print('Stripe status: $stripeStatus');
        if (fineStatusFromApi == 'paid') {
          paymentStatus.value = 'paid';
          stopStatusCheck();
          await getFine(fine.value!.id);
          AppSnackbar.show('success'.tr, 'payment_completed_successfully'.tr);
          return;
        }
        if (paymentStatusFromApi == 'pending') {
          paymentStatus.value = 'pending';
          return;
        }
        if (paymentStatusFromApi == 'failed' ||
            paymentStatusFromApi == 'cancelled') {
          paymentStatus.value = paymentStatusFromApi;
          stopStatusCheck();
          AppSnackbar.show('payment_failed'.tr, 'payment_try_again_later'.tr);
          return;
        }
        if (stripeStatus == 'paid') {
          paymentStatus.value = 'paid';
          stopStatusCheck();
          await getFine(fine.value!.id);
          AppSnackbar.show('success'.tr, 'payment_completed_successfully'.tr);
        }
      }
    } catch (e) {
      print('Fine Payment Status Error: $e');
    }
  }

  void startStatusCheck() {
    stopStatusCheck();
    checkPaymentStatus();
    _statusTimer = Timer.periodic(const Duration(seconds: 5), (timer) async {
      await checkPaymentStatus();

      if (paymentStatus.value == 'paid' ||
          paymentStatus.value == 'failed' ||
          paymentStatus.value == 'cancelled') {
        timer.cancel();
      }
    });
  }

  void stopStatusCheck() {
    _statusTimer?.cancel();
    _statusTimer = null;
  }

  @override
  void onClose() {
    WidgetsBinding.instance.removeObserver(this);
    stopStatusCheck();
    super.onClose();
  }

  Future<void> launchPaymentUrl(String url) async {
    final uri = Uri.parse(url);

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      AppSnackbar.show('error'.tr, 'payment_link_error'.tr);
    }
  }
}
