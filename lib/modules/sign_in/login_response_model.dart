class LoginResponseModel {
  final bool success;
  final String message;
  final String token;
  final int roleId;

  LoginResponseModel({
    required this.success,
    required this.message,
    required this.token,
    required this.roleId,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      success: json['success'],
      message: json['message'],
      token: json['data']['token'],
      roleId: json['data']['user']['role']['id'],
    );
  }
}