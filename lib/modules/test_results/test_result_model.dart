class TestResultModel {
  final int id;
  final int applicationId;
  final int testAppointmentId;
  final int testTypeId;
  final TestType testType;
  final String result;
  final int attemptNumber;
  final String notes;
  final DateTime recordedAt;
  final RecordedBy recordedBy;

  TestResultModel({
    required this.id,
    required this.applicationId,
    required this.testAppointmentId,
    required this.testTypeId,
    required this.testType,
    required this.result,
    required this.attemptNumber,
    required this.notes,
    required this.recordedAt,
    required this.recordedBy,
  });

  factory TestResultModel.fromJson(Map<String, dynamic> json) {
    return TestResultModel(
      id: json['id'],
      applicationId: json['application_id'],
      testAppointmentId: json['test_appointment_id'],
      testTypeId: json['test_type_id'],
      testType: TestType.fromJson(json['test_type']),
      result: json['result'],
      attemptNumber: json['attempt_number'],
      notes: json['notes'],
      recordedAt: DateTime.parse(json['recorded_at']),
      recordedBy: RecordedBy.fromJson(json['recorded_by']),
    );
  }
}

class TestType {
  final int id;
  final String name;
  final String code;

  TestType({
    required this.id,
    required this.name,
    required this.code,
  });

  factory TestType.fromJson(Map<String, dynamic> json) {
    return TestType(
      id: json['id'],
      name: json['name'],
      code: json['code'],
    );
  }
}

class RecordedBy {
  final int id;
  final String name;

  RecordedBy({
    required this.id,
    required this.name,
  });

  factory RecordedBy.fromJson(Map<String, dynamic> json) {
    return RecordedBy(
      id: json['id'],
      name: json['name'],
    );
  }
}
