class ChatSessionService {
  int? updateSession(
      Map<String, dynamic> data,
      ) {
    final returnedSessionId =
    data['session_id'];
    if (returnedSessionId == null) {
      return null;
    }
    return int.tryParse(
      returnedSessionId.toString(),
    );
  }
  int? extractActionId(
      Map<String, dynamic> data,
      ) {
    final pendingAction =
    data['pending_action'];
    if (pendingAction is! Map) {
      return null;
    }
    return int.tryParse(
      pendingAction['id'].toString(),
    );
  }
}