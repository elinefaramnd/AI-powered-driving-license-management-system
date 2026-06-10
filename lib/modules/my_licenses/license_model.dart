class LicenseModel {
  final int id;
  final String licenseNumber;
  final String status;
  final String issueDate;
  final String expiryDate;
  final LicenseType licenseType;
  final Application application;
  final String createdAt;

  LicenseModel({
    required this.id,
    required this.licenseNumber,
    required this.status,
    required this.issueDate,
    required this.expiryDate,
    required this.licenseType,
    required this.application,
    required this.createdAt,
  });

  factory LicenseModel.fromJson(Map<String, dynamic> json) {
    return LicenseModel(
      id: json["id"],
      licenseNumber: json["license_number"],
      status: json["status"],
      issueDate: json["issue_date"],
      expiryDate: json["expiry_date"],
      licenseType: LicenseType.fromJson(json["license_type"]),
      application: Application.fromJson(json["application"]),
      createdAt: json["created_at"],
    );
  }
}

class LicenseType {
  final int id;
  final String name;
  final String code;

  LicenseType({
    required this.id,
    required this.name,
    required this.code,
  });

  factory LicenseType.fromJson(Map<String, dynamic> json) {
    return LicenseType(
      id: json["id"],
      name: json["name"],
      code: json["code"],
    );
  }
}

class Application {
  final int id;
  final String applicationNumber;
  final String status;

  Application({
    required this.id,
    required this.applicationNumber,
    required this.status,
  });

  factory Application.fromJson(Map<String, dynamic> json) {
    return Application(
      id: json["id"],
      applicationNumber: json["application_number"],
      status: json["status"],
    );
  }
}
