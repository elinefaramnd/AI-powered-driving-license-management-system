import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
        Get.snackbar(
          'Error',
          response['message'] ?? 'Failed to get fee',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to get fee: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
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
          Get.snackbar(
            'Error',
            'No checkout URL received',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
          return false;
        }
      } else {
        Get.snackbar(
          'Error',
          response['message'] ?? 'Failed to create payment',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return false;
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to create payment: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
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
        Get.snackbar(
          'Error',
          'Could not launch checkout page',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      debugPrint('Launch URL error: $e');
      Get.snackbar(
        'Error',
        'Failed to open checkout: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
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
          Get.snackbar(
            'Success',
            'Payment completed successfully!',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green,
            colorText: Colors.white,
          );
        } else if (status == 'failed' || status == 'cancelled') {
          _stopStatusCheck();
          Get.snackbar(
            'Payment Failed',
            'Payment was not successful. Please try again.',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
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
