class VerificationModel {
  final String resetToken;

  VerificationModel({
    required this.resetToken,
  });

  factory VerificationModel.fromJson(Map<String, dynamic> json) {
    return VerificationModel(
      resetToken: json['reset_token'] ?? '',
    );
  }
}