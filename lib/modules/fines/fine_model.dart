class FineModel {
  final int id;
  final int citizenId;
  final int? licenseId;
  final double amount;
  final String currency;
  final String reason;
  final String status;
  final bool isPayable;
  final String? paidAt;
  final String createdAt;

  FineModel({
    required this.id,
    required this.citizenId,
    required this.licenseId,
    required this.amount,
    required this.currency,
    required this.reason,
    required this.status,
    required this.isPayable,
    required this.paidAt,
    required this.createdAt,
  });

  factory FineModel.fromJson(Map<String, dynamic> json) {
    return FineModel(
      id: json["id"],
      citizenId: json["citizen_id"],
      licenseId: json["license_id"],
      amount: double.tryParse(
        json["amount"]?.toString() ?? "0",
      ) ??
          0.0,
      currency: json["currency"] ?? "",
      reason: json["reason"] ?? "",
      status: json["status"] ?? "",
      isPayable: json["is_payable"] ?? false,
      paidAt: json["paid_at"],
      createdAt: json["created_at"] ?? "",
    );
  }
}