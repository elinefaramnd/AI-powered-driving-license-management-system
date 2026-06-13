class PrivacyPolicySection {
  final String heading;
  final String content;

  PrivacyPolicySection({required this.heading, required this.content});

  factory PrivacyPolicySection.fromJson(Map<String, dynamic> json) {
    return PrivacyPolicySection(
      heading: json['heading'] ?? '',
      content: json['content'] ?? '',
    );
  }
}

class PrivacyPolicyModel {
  final String title;
  final String lastUpdated;
  final List<PrivacyPolicySection> sections;

  PrivacyPolicyModel({
    required this.title,
    required this.lastUpdated,
    required this.sections,
  });

  factory PrivacyPolicyModel.fromJson(Map<String, dynamic> json) {
    final sectionsList = (json['sections'] as List<dynamic>? ?? [])
        .map((e) => PrivacyPolicySection.fromJson(e as Map<String, dynamic>))
        .toList();

    return PrivacyPolicyModel(
      title: json['title'] ?? '',
      lastUpdated: json['last_updated'] ?? '',
      sections: sectionsList,
    );
  }
}
