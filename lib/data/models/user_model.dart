import 'dart:convert';

class UserProfile {
  final String primaryEmail;
  final String name;

  UserProfile({
    required this.primaryEmail,
    this.name = '',
  });

  UserProfile copyWith({
    String? primaryEmail,
    String? name,
  }) {
    return UserProfile(
      primaryEmail: primaryEmail ?? this.primaryEmail,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'primaryEmail': primaryEmail,
      'name': name,
    };
  }

  factory UserProfile.fromMap(Map<String, dynamic> json) {
    return UserProfile(
      primaryEmail: json['primaryEmail'] ?? '',
      name: json['name'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserProfile.fromJson(String source) =>
      UserProfile.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'UserProfile(primaryEmail: $primaryEmail, name: $name)';
}
