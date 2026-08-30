class MyTransactionModel {
  final int id;
  final String transactionNumber;
  final double amount;
  final String currency;
  final String status;
  final String statusLabel;
  final String provider;
  final String purposeCode;
  final String purposeLabel;
  final String relatedType;
  final int relatedId;
  final String? applicationNumber;
  final String? serviceTypeCode;
  final String? feeCode;
  final String? fineStatus;
  final String? paidAt;
  final String? createdAt;

  MyTransactionModel({
    required this.id,
    required this.transactionNumber,
    required this.amount,
    required this.currency,
    required this.status,
    required this.statusLabel,
    required this.provider,
    required this.purposeCode,
    required this.purposeLabel,
    required this.relatedType,
    required this.relatedId,
    this.applicationNumber,
    this.serviceTypeCode,
    this.feeCode,
    this.fineStatus,
    this.paidAt,
    this.createdAt,
  });

  factory MyTransactionModel.fromJson(Map<String, dynamic> json) {
    final purpose = json['purpose'] ?? {};
    final related = json['related'] ?? {};

    return MyTransactionModel(
      id: json['id'] ?? 0,
      transactionNumber: json['payment_number'] ?? '',
      amount: double.tryParse(
        json['amount']?.toString() ?? '0',
      ) ??
          0,
      currency: json['currency'] ?? '',
      status: json['status'] ?? '',
      statusLabel: json['status_label'] ?? '',
      provider: json['provider'] ?? '',
      purposeCode: purpose['code'] ?? '',
      purposeLabel: purpose['label'] ?? '',
      relatedType: related['type'] ?? '',
      relatedId: related['id'] ?? 0,
      applicationNumber: related['application_number'],
      serviceTypeCode: related['service_type_code'],
      feeCode: related['fee_code'],
      fineStatus: related['fine_status'],
      paidAt: json['paid_at'],
      createdAt: json['created_at'],
    );
  }
}