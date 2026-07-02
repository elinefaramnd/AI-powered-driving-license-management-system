class CompleteProfileModel {
  final bool success;
  final String message;

  CompleteProfileModel({
    required this.success,
    required this.message,
  });

  factory CompleteProfileModel.fromJson(Map<String, dynamic> json) {
    return CompleteProfileModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
    );
  }
}