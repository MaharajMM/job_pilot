import 'dart:convert';

import 'package:intl/intl.dart';

class SentEmail {
  final List<String> recipients;
  final String subject;
  final String body;
  final DateTime dateSent;
  final bool hasAttachment;
  final String? attachmentPath;

  SentEmail({
    required this.recipients,
    required this.subject,
    required this.body,
    required this.dateSent,
    this.hasAttachment = false,
    this.attachmentPath,
  });

  SentEmail copyWith({
    List<String>? recipients,
    String? subject,
    String? body,
    DateTime? dateSent,
    bool? hasAttachment,
    String? attachmentPath,
  }) {
    return SentEmail(
      recipients: recipients ?? this.recipients,
      subject: subject ?? this.subject,
      body: body ?? this.body,
      dateSent: dateSent ?? this.dateSent,
      hasAttachment: hasAttachment ?? this.hasAttachment,
      attachmentPath: attachmentPath ?? this.attachmentPath,
    );
  }

  factory SentEmail.fromJson(String str) => SentEmail.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() {
    return {
      'recipients': recipients,
      'subject': subject,
      'body': body,
      'dateSent': dateSent.toIso8601String(),
      'hasAttachment': hasAttachment,
      'attachmentPath': attachmentPath,
    };
  }

  factory SentEmail.fromMap(Map<String, dynamic> json) {
    return SentEmail(
      recipients: List<String>.from(json['recipients'] ?? []),
      subject: json['subject'] ?? '',
      body: json['body'] ?? '',
      dateSent: DateTime.parse(json['dateSent']),
      hasAttachment: json['hasAttachment'] ?? false,
      attachmentPath: json['attachmentPath'],
    );
  }

  String getFormattedDate() {
    return DateFormat('MMM dd, yyyy hh:mm a').format(dateSent);
  }

  // Extract domain from email (e.g., 'example.com' from 'user@example.com')
  List<String> getCompanyDomains() {
    Set<String> domains = {};
    for (var email in recipients) {
      try {
        var parts = email.split('@');
        if (parts.length == 2) {
          domains.add(parts[1]);
        }
      } catch (e) {
        // Ignore invalid emails
      }
    }
    return domains.toList();
  }

  @override
  String toString() =>
      'SentEmail(recipients: $recipients, subject: $subject, dateSent: $dateSent, hasAttachment: $hasAttachment)';
}
