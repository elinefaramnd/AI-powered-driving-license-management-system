class ForgetPasswordModel {
  final bool success;
  final String message;

  ForgetPasswordModel({
    required this.success,
    required this.message,
  });

  factory ForgetPasswordModel.fromJson(Map<String, dynamic> json) {
    return ForgetPasswordModel(
      success: json["success"] ?? false,
      message: json["message"] ?? "",
    );
  }
}