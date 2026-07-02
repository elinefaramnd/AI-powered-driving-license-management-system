// class AppointmentSlotsModel {
//   final bool success;
//   final String message;
//   final List<dynamic> data;
//
//   AppointmentSlotsModel({
//     required this.success,
//     required this.message,
//     required this.data,
//   });
//
//   factory AppointmentSlotsModel.fromJson(Map<String, dynamic> json) {
//     return AppointmentSlotsModel(
//       success: json["success"] ?? false,
//       message: json["message"] ?? "",
//       data: json["data"] ?? [],
//     );
//   }
// }