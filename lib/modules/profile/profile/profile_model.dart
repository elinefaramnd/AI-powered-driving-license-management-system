class ProfileModel {
  final bool success;
  final String message;
  final Map<String, dynamic> data;

  ProfileModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: Map<String, dynamic>.from(json['data'] ?? {}),
    );
  }
}