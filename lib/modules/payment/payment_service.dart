import 'dart:convert';
import '../../configuration/http_helpers.dart';

class PaymentService {
  static Future<Map<String, dynamic>> getApplicationFee(int applicationId) async {
    final response = await HttpHelper.gettData(
      url: 'applications/$applicationId/fee',
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to get fee: ${response.statusCode}');
    }
  }

  static Future<Map<String, dynamic>> createPayment(int applicationId) async {
    final response = await HttpHelper.postData(
      url: 'applications/$applicationId/payments',
      body: {},
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to create payment: ${response.statusCode}');
    }
  }

  static Future<Map<String, dynamic>> checkPaymentStatus(
    int applicationId,
    int paymentId,
  ) async {
    final response = await HttpHelper.gettData(
      url: 'applications/$applicationId/payments/$paymentId/status',
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to check payment status: ${response.statusCode}');
    }
  }

  static Future<Map<String, dynamic>> listApplicationPayments(int applicationId) async {
    final response = await HttpHelper.gettData(
      url: 'applications/$applicationId/payments',
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to list payments: ${response.statusCode}');
    }
  }
}
