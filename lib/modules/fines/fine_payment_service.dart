import 'dart:convert';
import '../../configuration/http_helpers.dart';

class FinePaymentService {
  static Future<Map<String, dynamic>> getFine(int fineId) async {
    final response = await HttpHelper.gettData(url: 'fines/$fineId');

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }

    throw Exception('Failed to get fine: ${response.statusCode}');
  }

  static Future<Map<String, dynamic>> createPayment(int fineId) async {
    final response = await HttpHelper.postData(
      url: 'fines/$fineId/payments',
      body: {},
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return jsonDecode(response.body);
    }

    throw Exception('Failed to create fine payment: ${response.statusCode}');
  }

  static Future<Map<String, dynamic>> checkPaymentStatus(
    int fineId,
    int paymentId,
  ) async {
    final response = await HttpHelper.gettData(
      url: 'fines/$fineId/payments/$paymentId/status',
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }

    throw Exception(
      'Failed to check fine payment status: ${response.statusCode}',
    );
  }
}
