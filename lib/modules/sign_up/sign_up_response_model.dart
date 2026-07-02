class SignUpResponseModel {
  final bool success;
  final String message;
  final int expiresInMinutes;

  SignUpResponseModel({
    required this.success,
    required this.message,
    required this.expiresInMinutes,
  });

  factory SignUpResponseModel.fromJson(Map<String, dynamic> json) {
    return SignUpResponseModel(
      success: json['success'],
      message: json['message'],
      expiresInMinutes: json['data']['expires_in_minutes'],
    );
  }
}