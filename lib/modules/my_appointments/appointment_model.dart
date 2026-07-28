class AppointmentModel {
  final int id;
  final String testName;
  final String testCode;
  final String status;
  final String date;
  final String time;
  final String location;
  final String? result;
  final int testTypeId;
  final int applicationId;
  final String address;

  AppointmentModel({
    required this.id,
    required this.testName,
    required this.testCode,
    required this.status,
    required this.date,
    required this.time,
    required this.location,
    this.result,
    required this.testTypeId,
    required this.applicationId,
    required this.address,

  });

  factory AppointmentModel.fromJson(Map<String, dynamic> json) {
    return AppointmentModel(
      id: json['id'],
      testName: json['test_type']['name'] ?? '',
      testCode: json['test_type']['code'] ?? '',
      status: json['status'] ?? '',
      testTypeId: json['appointment_slot']?['test_type_id'] ?? 0,
      applicationId: json['application_id'],
      date: json['appointment_slot']['date'] ?? '',
      time: json['appointment_slot']['start_time'] ?? '',
      location: json['appointment_slot']['location'] ?? '',
      result: json['test_result']?['result'],
      address: json['appointment_slot']['center']['address'] ?? '',
    );
  }
}