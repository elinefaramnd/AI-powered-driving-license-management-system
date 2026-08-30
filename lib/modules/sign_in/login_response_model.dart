class LoginResponseModel {
  final bool success;
  final String message;
  final String token;
  final int roleId;
  final int userId;

  LoginResponseModel({
    required this.success,
    required this.message,
    required this.token,
    required this.roleId,
    required this.userId,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      success: json['success'],
      message: json['message'],
      token: json['data']['token'],
      userId: json['data']['user']['id'],
      roleId: json['data']['user']['role']['id'],
    );
  }
}