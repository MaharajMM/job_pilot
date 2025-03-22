import 'dart:convert';

class EmailTemplateModel {
  final String subject;
  final String body;
  final String? attachmentPath;

  EmailTemplateModel({
    required this.subject,
    required this.body,
    this.attachmentPath,
  });

  EmailTemplateModel copyWith({
    String? subject,
    String? body,
    String? attachmentPath,
  }) {
    return EmailTemplateModel(
      subject: subject ?? this.subject,
      body: body ?? this.body,
      attachmentPath: attachmentPath ?? this.attachmentPath,
    );
  }

  factory EmailTemplateModel.fromJson(String str) => EmailTemplateModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory EmailTemplateModel.fromMap(Map<String, dynamic> json) => EmailTemplateModel(
        subject: json['subject'] ?? '',
        body: json['body'] ?? '',
        attachmentPath: json['attachmentPath'],
      );

  Map<String, dynamic> toMap() => {
        'subject': subject,
        'body': body,
        'attachmentPath': attachmentPath,
      };
}
