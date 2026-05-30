class OrderModel {
  final int id;
  final String serviceType;
  final String licenseType;
  final String status;
  final List<dynamic> documents;
  final String application_number;

  OrderModel({
    required this.id,
    required this.serviceType,
    required this.licenseType,
    required this.status,
    required this.documents,
    required this.application_number
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json["id"],
      serviceType: json["service_type"]["name"],
      licenseType: json["license_type"]["name"],
      status: json["status"],
      documents:
      List<dynamic>.from(
        json["documents"] ?? [],),
      application_number: json["application_number"],
    );
  }
}