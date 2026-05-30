class FineModel {
  final int id;
  final int citizenId;
  final double amount;
  final String reason;
  final String status;

  FineModel({
    required this.id,
    required this.citizenId,
    required this.amount,
    required this.reason,
    required this.status,
  });
  factory FineModel.fromJson(Map<String, dynamic> json) {
    return FineModel(
      id: json["id"],
      citizenId: json["citizen_id"],
      amount: double.parse(json["amount"].toString()),
      reason: json["reason"] ?? "",

      status: json["status"] ?? "",
    );
  }
}
