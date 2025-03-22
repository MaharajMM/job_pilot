import 'package:flutter/material.dart';
import 'package:job_pilot/data/models/sent_email_model.dart';
import 'package:job_pilot/data/service/email_template/email_template_db_service.dart';

class EmailService {
  final EmailTemplateDbService emailTemplateDbService;

  EmailService({required this.emailTemplateDbService});
  // In a real application, this would send emails through an API service
  Future<bool> sendBulkEmail({
    required List<String> recipients,
    String? subject,
    String? body,
    String? attachmentPath,
  }) async {
    try {
      // Get default template if subject or body is not provided
      final defaultTemplate = emailTemplateDbService.getEmailTemplate();

      final emailSubject = subject ?? defaultTemplate?.subject ?? '';
      final emailBody = body ?? defaultTemplate?.body ?? '';
      final attachment = attachmentPath ?? defaultTemplate?.attachmentPath;

      // In a real app, this would connect to an email API
      // For demo purposes, we'll just simulate a delay
      await Future.delayed(const Duration(seconds: 1));

      // Store the sent email in history
      final sentEmail = SentEmail(
        recipients: recipients,
        subject: emailSubject,
        body: emailBody,
        dateSent: DateTime.now(),
        hasAttachment: attachment != null,
        attachmentPath: attachment,
      );

      await emailTemplateDbService.saveSentEmails(email: sentEmail);

      return true;
    } catch (e) {
      debugPrint('Error sending email: $e');
      return false;
    }
  }

  // Get all sent emails
  Future<List<SentEmail>> getSentEmailHistory() async {
    return emailTemplateDbService.getSentEmails();
  }

  // Get sent emails for a specific date range
  Future<List<SentEmail>> getSentEmailsInRange(DateTime start, DateTime end) async {
    final allEmails = emailTemplateDbService.getSentEmails();
    return allEmails.where((email) {
      return email.dateSent.isAfter(start) &&
          email.dateSent.isBefore(end.add(const Duration(days: 1)));
    }).toList();
  }
}
