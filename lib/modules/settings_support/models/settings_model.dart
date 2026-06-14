class SettingsModel {
  final AccountInfo account;
  final Preferences preferences;
  final List<LanguageOption> availableLanguages;
  final List<ThemeOption> availableThemes;

  SettingsModel({
    required this.account,
    required this.preferences,
    required this.availableLanguages,
    required this.availableThemes,
  });

  factory SettingsModel.fromJson(Map<String, dynamic> json) {
    return SettingsModel(
      account: AccountInfo.fromJson(json['account']),
      preferences: Preferences.fromJson(json['preferences']),
      availableLanguages: (json['available_languages'] as List)
          .map((e) => LanguageOption.fromJson(e))
          .toList(),
      availableThemes: (json['available_themes'] as List)
          .map((e) => ThemeOption.fromJson(e))
          .toList(),
    );
  }
}

class AccountInfo {
  final int id;
  final String name;
  final String email;
  final String phone;
  final String nationalId;
  final String profileStatus;
  final bool profileCompleted;

  AccountInfo({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.nationalId,
    required this.profileStatus,
    required this.profileCompleted,
  });

  factory AccountInfo.fromJson(Map<String, dynamic> json) {
    return AccountInfo(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      nationalId: json['national_id']??"",
      profileStatus: json['profile_status'],
      profileCompleted: json['profile_completed'],
    );
  }
}

class Preferences {
  String language;
  String theme;

  Preferences({
    required this.language,
    required this.theme,
  });

  factory Preferences.fromJson(Map<String, dynamic> json) {
    return Preferences(
      language: json['language'],
      theme: json['theme'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'language': language,
      'theme': theme,
    };
  }
}

class LanguageOption {
  final String code;
  final String name;

  LanguageOption({
    required this.code,
    required this.name,
  });

  factory LanguageOption.fromJson(Map<String, dynamic> json) {
    return LanguageOption(
      code: json['code'],
      name: json['name'],
    );
  }
}

class ThemeOption {
  final String code;
  final String name;

  ThemeOption({
    required this.code,
    required this.name,
  });

  factory ThemeOption.fromJson(Map<String, dynamic> json) {
    return ThemeOption(
      code: json['code'],
      name: json['name'],
    );
  }
}
