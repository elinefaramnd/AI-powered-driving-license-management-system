import 'dart:io';

class ChatMessage {
  final String text;
  final bool isUser;
  final DateTime timestamp;
  final bool hasAttachment;
  final String? attachmentName;
  final File? attachmentFile;
  final bool showActionButtons;
  final List<Map<String, dynamic>> applications;
  final List<Map<String, dynamic>> appointmentSlots;
  final List<Map<String, dynamic>> documents;
  final List<Map<String, dynamic>> documentButtons;
  final List<Map<String, dynamic>> remainingDocuments;
  final String? uploadToken;
  final List<String> allowedExtensions;

  ChatMessage({
    required this.text,
    required this.isUser,
    required this.timestamp,
    this.hasAttachment = false,
    this.attachmentName,
    this.attachmentFile,
    this.showActionButtons = false,
    this.applications = const [],
    this.appointmentSlots = const [],
    this.documents = const [],
    this.documentButtons = const [],
    this.uploadToken,
    this.allowedExtensions = const [],
    this.remainingDocuments = const [],
  });

  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'isUser': isUser,
      'timestamp': timestamp.toIso8601String(),
      'hasAttachment': hasAttachment,
      'attachmentName': attachmentName,
      'showActionButtons': showActionButtons,
      'applications': applications,
      'appointmentSlots': appointmentSlots,
      'documents': documents,
      'documentButtons': documentButtons,
      'remainingDocuments': remainingDocuments,
      'uploadToken': uploadToken,
      'allowedExtensions': allowedExtensions,
    };
  }

  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
      text: json['text']?.toString() ?? '',
      isUser: json['isUser'] == true,
      timestamp:
          DateTime.tryParse(json['timestamp']?.toString() ?? '') ??
          DateTime.now(),
      hasAttachment: json['hasAttachment'] == true,
      attachmentName: json['attachmentName']?.toString(),
      showActionButtons: json['showActionButtons'] == true,
      applications: _convertList(json['applications']),
      appointmentSlots: _convertList(json['appointmentSlots']),
      documents: _convertList(json['documents']),
      documentButtons: _convertList(json['documentButtons']),
      remainingDocuments: _convertList(json['remainingDocuments']),
      uploadToken: json['uploadToken']?.toString(),
      allowedExtensions: json['allowedExtensions'] is List
          ? List<String>.from(
              (json['allowedExtensions'] as List).map((e) => e.toString()),
            )
          : [],
    );
  }

  static List<Map<String, dynamic>> _convertList(dynamic value) {
    if (value is! List) return [];

    return value
        .whereType<Map>()
        .map((item) => Map<String, dynamic>.from(item))
        .toList();
  }
}
