import 'dart:convert';
import '../../../configuration/http_helpers.dart';
import '../chat_message.dart';

class ChatSelectionService {
  Future<Map<String, dynamic>?> selectApplication({
    required int sessionId,
    required String selectionToken,
  }) async {
    final response = await HttpHelper.postData(
      url: 'ai-agent/sessions/$sessionId/interactions',
      body: {'action': 'select_application', 'selection_token': selectionToken},
    );

    print('SELECT APPLICATION RESPONSE');
    print('statusCode: ${response.statusCode}');
    print('body: ${response.body}');

    if (response.statusCode < 200 || response.statusCode >= 300) {
      _showError(response.statusCode);
      return null;
    }

    final responseData = jsonDecode(response.body) as Map<String, dynamic>;

    return responseData['data'] as Map<String, dynamic>?;
  }

  Future<Map<String, dynamic>?> selectAppointmentSlot({
    required int sessionId,
    required String selectionToken,
  }) async {
    final response = await HttpHelper.postData(
      url: 'ai-agent/sessions/$sessionId/interactions',
      body: {
        'action': 'select_appointment_slot',
        'selection_token': selectionToken,
      },
    );

    print('========== SELECT APPOINTMENT RESPONSE ==========');
    print('statusCode: ${response.statusCode}');
    print('body: ${response.body}');

    if (response.statusCode < 200 || response.statusCode >= 300) {
      _showError(response.statusCode);
      return null;
    }

    final responseData = jsonDecode(response.body) as Map<String, dynamic>;

    return responseData['data'] as Map<String, dynamic>?;
  }

  Future<Map<String, dynamic>?> selectRequiredDocument({
    required int sessionId,
    required String selectionToken,
  }) async {
    final response = await HttpHelper.postData(
      url: 'ai-agent/sessions/$sessionId/interactions',
      body: {
        'action': 'select_required_document',
        'selection_token': selectionToken,
      },
    );

    print('========== SELECT DOCUMENT RESPONSE ==========');
    print('statusCode: ${response.statusCode}');
    print('body: ${response.body}');

    if (response.statusCode < 200 || response.statusCode >= 300) {
      _showError(response.statusCode);
      return null;
    }

    final responseData = jsonDecode(response.body) as Map<String, dynamic>;

    return responseData['data'] as Map<String, dynamic>?;
  }

  List<Map<String, dynamic>> extractList(dynamic value) {
    if (value is! List) return [];

    return value
        .whereType<Map>()
        .map((item) => Map<String, dynamic>.from(item))
        .toList();
  }

  ChatMessage buildReplyMessage({
    required Map<String, dynamic> data,
    List<Map<String, dynamic>> appointmentSlots = const [],
    List<Map<String, dynamic>> documents = const [],
    List<Map<String, dynamic>> documentButtons = const [],
    String? uploadToken,
    List<String> allowedExtensions = const [],
  }) {
    return ChatMessage(
      text: data['reply']?.toString() ?? '',
      isUser: false,
      timestamp: DateTime.now(),
      appointmentSlots: appointmentSlots,
      documents: documents,
      documentButtons: documentButtons,
      uploadToken: uploadToken,
      allowedExtensions: allowedExtensions,
      showActionButtons: data['requires_confirmation'] == true,
    );
  }

  void _showError(int statusCode) {
    print('Selection request failed: $statusCode');
  }
}
