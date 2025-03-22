import 'package:job_pilot/data/models/email_template_model.dart';
import 'package:job_pilot/data/models/sent_email_model.dart';

abstract class IEmailTemplateDbService {
  Future<void> saveEmailTemplate({required EmailTemplateModel emailTemplate});
  Future<void> deleteEmailTemplate();
  EmailTemplateModel? getEmailTemplate();

  Future<void> saveSentEmails({required SentEmail email});
  Future<void> deleteSentEmails();
  List<SentEmail>? getSentEmails();
}
