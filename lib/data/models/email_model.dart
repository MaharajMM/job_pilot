import 'dart:convert';

class EmailModel {
  final String name;
  final String emailId;
  final String subject;
  final String body;
  final String? attachmentUrl;
  final DateTime? timestamp;

  EmailModel({
    required this.name,
    required this.emailId,
    required this.subject,
    required this.body,
    this.attachmentUrl,
    this.timestamp,
  });

  EmailModel copyWith({
    String? name,
    String? emailId,
    String? subject,
    String? body,
    String? attachmentUrl,
    DateTime? timestamp,
  }) =>
      EmailModel(
        name: name ?? this.name,
        emailId: emailId ?? this.emailId,
        subject: subject ?? this.subject,
        body: body ?? this.body,
        attachmentUrl: attachmentUrl ?? this.attachmentUrl,
        timestamp: timestamp ?? this.timestamp,
      );
  factory EmailModel.fromJson(String str) => EmailModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());
  // Convert to Map for Firebase
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'emailId': emailId,
      'subject': subject,
      'body': body,
      'attachmentUrl': attachmentUrl,
      'timestamp': timestamp?.toIso8601String(),
    };
  }

  // Create from Map (from Firebase)
  factory EmailModel.fromMap(Map<String, dynamic> map) {
    return EmailModel(
      name: map['name'] ?? '',
      emailId: map['emailId'] ?? '',
      subject: map['subject'] ?? '',
      body: map['body'] ?? '',
      attachmentUrl: map['attachmentUrl'],
      timestamp: DateTime.parse(map['timestamp']),
    );
  }
}
