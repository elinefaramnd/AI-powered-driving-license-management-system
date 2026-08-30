class NotificationModel {
  final int id;
  final String title;
  final String body;
  final String type;
  final String? readAt;
  final bool isRead;
  final Map<String, dynamic> data;
  final DateTime? createdAt;

  NotificationModel({
    required this.id,
    required this.title,
    required this.body,
    required this.type,
    required this.readAt,
    required this.isRead,
    required this.data,
    required this.createdAt,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json["id"] ?? 0,
      title: json["title"] ?? "",
      body: json["body"] ?? "",
      type: json["type"] ?? "",
      readAt: json["read_at"],
      isRead: json["is_read"] ?? false,
      data: Map<String, dynamic>.from(json["data"] ?? {}),
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
    );
  }
}