class TestResultModel {
  final int id;
  final int applicationId;
  final int testAppointmentId;
  final int testTypeId;

  final String testName;
  final String testCode;

  final String result;
  final int attemptNumber;
  final String notes;
  final DateTime recordedAt;
  final String recordedBy;

  TestResultModel({
    required this.id,
    required this.applicationId,
    required this.testAppointmentId,
    required this.testTypeId,
    required this.testName,
    required this.testCode,
    required this.result,
    required this.attemptNumber,
    required this.notes,
    required this.recordedAt,
    required this.recordedBy,
  });

  factory TestResultModel.fromJson(Map<String, dynamic> json) {
    return TestResultModel(
      id: json["id"],
      applicationId: json["application_id"],
      testAppointmentId: json["test_appointment_id"],
      testTypeId: json["test_type_id"],

      testName: json["test_type"]["name"],
      testCode: json["test_type"]["code"],

      result: json["result"],
      attemptNumber: json["attempt_number"],
      notes: json["notes"] ?? "",
      recordedAt: DateTime.parse(json["recorded_at"]),
      recordedBy: json["recorded_by"]["name"],
    );
  }
}