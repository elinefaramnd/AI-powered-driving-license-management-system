part of 'chat_bot_controller.dart';

extension ChatControllerSelection on ChatController {
  Future<void> selectApplication(
    String selectionToken,
    String applicationName,
  ) async {
    markAsInteracted();
    if (!helperService.checkSession(
      sessionId: sessionId.value,
      selectionToken: selectionToken,
    )) {
      return;
    }
    messages.add(
      ChatMessage(
        text: applicationName,
        isUser: true,
        timestamp: DateTime.now(),
      ),
    );
    isTyping.value = true;
    try {
      final data = await selectionService.selectApplication(
        sessionId: sessionId.value!,
        selectionToken: selectionToken,
      );
      if (data == null) return;
      final newSessionId = sessionService.updateSession(data);
      if (newSessionId != null) {
        sessionId.value = newSessionId;
      }
      final pendingAction = data['pending_action'];
      if (pendingAction != null) {
        actionId.value = int.tryParse(pendingAction['id'].toString());
      }
      final uiPayload = data['ui_payload'];
      List<Map<String, dynamic>> appointmentSlots = [];
      List<Map<String, dynamic>> documents = [];
      List<Map<String, dynamic>> documentButtons = [];
      if (uiPayload is Map<String, dynamic>) {
        appointmentSlots = selectionService.extractList(uiPayload['slots']);
        documents = selectionService.extractList(uiPayload['documents']);
        documentButtons = selectionService.extractList(uiPayload['buttons']);
      }
      final reply = data['reply']?.toString() ?? '';
      if (reply.isNotEmpty || appointmentSlots.isNotEmpty) {
        messages.add(
          selectionService.buildReplyMessage(
            data: data,
            appointmentSlots: appointmentSlots,
            documents: documents,
            documentButtons: documentButtons,
          ),
        );
      }
      await saveChat();
    } catch (e) {
      helperService.showError(e);
    } finally {
      isTyping.value = false;
    }
  }

  Future<void> selectAppointmentSlot(
    String selectionToken,
    String appointmentLabel,
  ) async {
    markAsInteracted();
    if (!helperService.checkSession(
      sessionId: sessionId.value,
      selectionToken: selectionToken,
    )) {
      return;
    }
    messages.add(
      ChatMessage(
        text: appointmentLabel,
        isUser: true,
        timestamp: DateTime.now(),
      ),
    );
    isTyping.value = true;
    try {
      final data = await selectionService.selectAppointmentSlot(
        sessionId: sessionId.value!,
        selectionToken: selectionToken,
      );
      if (data == null) return;
      final newSessionId = sessionService.updateSession(data);
      if (newSessionId != null) {
        sessionId.value = newSessionId;
      }
      final pendingAction = data['pending_action'];
      if (pendingAction != null) {
        actionId.value = int.tryParse(pendingAction['id'].toString());
      }
      final reply = data['reply']?.toString() ?? '';
      if (reply.isNotEmpty) {
        messages.add(selectionService.buildReplyMessage(data: data));
      }
      await saveChat();
    } catch (e) {
      helperService.showError(e);
    } finally {
      isTyping.value = false;
    }
  }

  Future<void> selectRequiredDocument(
    String selectionToken,
    String documentName,
  ) async {
    markAsInteracted();
    if (!helperService.checkSession(
      sessionId: sessionId.value,
      selectionToken: selectionToken,
    )) {
      return;
    }
    messages.add(
      ChatMessage(text: documentName, isUser: true, timestamp: DateTime.now()),
    );
    isTyping.value = true;
    try {
      final data = await selectionService.selectRequiredDocument(
        sessionId: sessionId.value!,
        selectionToken: selectionToken,
      );
      if (data == null) return;
      final newSessionId = sessionService.updateSession(data);
      if (newSessionId != null) {
        sessionId.value = newSessionId;
      }
      final uiPayload = data['ui_payload'];
      if (uiPayload is Map<String, dynamic>) {
        final token = uiPayload['upload_token'];
        if (token != null) {
          uploadToken.value = token.toString();
        }
        final extensions = uiPayload['allowed_extensions'];
        if (extensions is List) {
          allowedExtensions.assignAll(
            extensions.map((e) => e.toString().toLowerCase()).toList(),
          );
        }
      }
      final reply = data['reply']?.toString() ?? '';
      if (reply.isNotEmpty) {
        messages.add(
          selectionService.buildReplyMessage(
            data: data,
            uploadToken: uploadToken.value,
            allowedExtensions: allowedExtensions.toList(),
          ),
        );
      }
      await saveChat();
    } catch (e) {
      helperService.showError(e);
    } finally {
      isTyping.value = false;
    }
  }
}
