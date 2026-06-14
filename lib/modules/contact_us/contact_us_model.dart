class ContactChannel {
  final String type;
  final String label;
  final String value;

  ContactChannel({
    required this.type,
    required this.label,
    required this.value,
  });

  factory ContactChannel.fromJson(Map<String, dynamic> json) {
    return ContactChannel(
      type: json['type'] ?? '',
      label: json['label'] ?? '',
      value: json['value'] ?? '',
    );
  }
}

class ContactUsModel {
  final String title;
  final String description;
  final String phone;
  final String email;
  final String workingHours;
  final String address;
  final List<ContactChannel> channels;

  ContactUsModel({
    required this.title,
    required this.description,
    required this.phone,
    required this.email,
    required this.workingHours,
    required this.address,
    required this.channels,
  });

  factory ContactUsModel.fromJson(Map<String, dynamic> json) {
    final channelsList = (json['channels'] as List<dynamic>? ?? [])
        .map((e) => ContactChannel.fromJson(e as Map<String, dynamic>))
        .toList();

    return ContactUsModel(
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      phone: json['phone'] ?? '',
      email: json['email'] ?? '',
      workingHours: json['working_hours'] ?? '',
      address: json['address'] ?? '',
      channels: channelsList,
    );
  }
}
