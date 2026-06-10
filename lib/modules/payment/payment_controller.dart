import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_2/widgets/app_snackbar.dart';
import 'package:url_launcher/url_launcher.dart';
import 'payment_service.dart';

class PaymentController extends GetxController {
  final isLoading = false.obs;
  final isCreatingPayment = false.obs;
  final paymentStatus = ''.obs;
  final feeAmount = 0.0.obs;
  final checkoutUrl = ''.obs;
  final paymentId = 0.obs;

  Timer? _statusTimer;

  Future<void> getApplicationFee(int applicationId) async {
    try {
      isLoading.value = true;
      final response = await PaymentService.getApplicationFee(applicationId);

      if (response['success'] == true && response['data'] != null) {
        final data = response['data'];
        final fee = data['fee'];
        if (fee != null && fee['amount'] != null) {
          feeAmount.value = double.tryParse(fee['amount'].toString()) ?? 0.0;
        }
      } else {
        AppSnackbar.show('خطأ',
          response['message'] ?? 'فشل الدفع',);
      }
    } catch (e) {
      AppSnackbar.show('خطأ',
        'فشل: $e',);
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> createPayment(int applicationId) async {
    try {
      isCreatingPayment.value = true;
      final response = await PaymentService.createPayment(applicationId);

      if (response['success'] == true && response['data'] != null) {
        final data = response['data'];

        if (data['payment'] != null) {
          paymentId.value = data['payment']['id'] ?? 0;
        }

        if (data['checkout_url'] != null) {
          checkoutUrl.value = data['checkout_url'];
          return true;
        } else {
          AppSnackbar.show('خطأ',
            'No checkout URL received',);
          return false;
        }
      } else {
        AppSnackbar.show('خطأ',
          response['message'] ?? 'Failed to create payment',);
        return false;
      }
    } catch (e) {
      AppSnackbar.show('Error',
        'Failed to create payment: $e',);
      return false;
    } finally {
      isCreatingPayment.value = false;
    }
  }

  Future<void> launchCheckout() async {
    if (checkoutUrl.value.isEmpty) return;

    try { 
      final Uri url = Uri.parse(checkoutUrl.value);
      debugPrint('Opening URL: $url');
      
      final bool launched = await launchUrl(url);
      
      if (!launched) {
        AppSnackbar.show('Error',
          'Could not launch checkout page',);
      }
    } catch (e) {
      debugPrint('Launch URL error: $e');
      AppSnackbar.show('Error',
        'Failed to open checkout: $e',);
    }
  }

  Future<void> checkPaymentStatus(int applicationId, int paymentId) async {
    try {
      final response = await PaymentService.checkPaymentStatus(
        applicationId,
        paymentId,
      );

      if (response['success'] == true && response['data'] != null) {
        final data = response['data'];
        final status = data['status'] ?? 'pending';
        paymentStatus.value = status;
        if (status == 'completed' || status == 'paid') {
          _stopStatusCheck();
          AppSnackbar.show('نجاح',
            'تم إكمال عملية الدفع بنجاح',);
        } else if (status == 'failed' || status == 'cancelled') {
          _stopStatusCheck();
          AppSnackbar.show('فشل الدفع',
            'الرجاء المحاولة لاحقا',);
        }
      }
    } catch (e) {
      debugPrint('Error checking payment status: $e');
    }
  }

  void startStatusCheck(int applicationId, int paymentId) {
    _stopStatusCheck();
    _statusTimer = Timer.periodic(const Duration(seconds: 5), (timer) async {
      await checkPaymentStatus(applicationId, paymentId);
      if (paymentStatus.value == 'completed' ||
          paymentStatus.value == 'paid' ||
          paymentStatus.value == 'failed' ||
          paymentStatus.value == 'cancelled') {
        timer.cancel();
      }
    });
  }

  void _stopStatusCheck() {
    _statusTimer?.cancel();
    _statusTimer = null;
  }

  void resetPayment() {
    paymentStatus.value = '';
    checkoutUrl.value = '';
    paymentId.value = 0;
    _stopStatusCheck();
  }

  @override
  void onClose() {
    _stopStatusCheck();
    super.onClose();
  }
}
