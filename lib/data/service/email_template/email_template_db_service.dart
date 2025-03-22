import 'package:job_pilot/core/local_storage/app_storage.dart';
import 'package:job_pilot/data/models/email_template_model.dart';
import 'package:job_pilot/data/models/sent_email_model.dart';

import 'i_email_template_db_service.dart';

class EmailTemplateDbService implements IEmailTemplateDbService {
  final AppStorage appStorage;
  EmailTemplateDbService({
    required this.appStorage,
  });

  final emailTemplateKey = 'emailTemplate';
  final sentEmailsKey = 'sentEmails';
  @override
  Future<void> deleteEmailTemplate() async {
    final box = appStorage.appBox;
    await box?.delete(emailTemplateKey);
  }

  @override
  EmailTemplateModel? getEmailTemplate() {
    final box = appStorage.appBox;
    final emailTemplateModel = box?.get(emailTemplateKey) as String?;
    if (emailTemplateModel != null) {
      return EmailTemplateModel.fromJson(emailTemplateModel);
    } else {
      return null;
    }
  }

  @override
  Future<void> saveEmailTemplate({required EmailTemplateModel emailTemplate}) async {
    final box = appStorage.appBox;
    await box?.put(emailTemplateKey, emailTemplate.toJson());
  }

  @override
  Future<void> deleteSentEmails() async {
    final box = appStorage.appBox;
    await box?.delete(sentEmailsKey);
  }

  @override
  List<SentEmail> getSentEmails() {
    final box = appStorage.appBox;
    final storedEmails = box?.get(sentEmailsKey) as List<dynamic>?;
    if (storedEmails == null) return [];

    return storedEmails.map((item) => SentEmail.fromMap(Map<String, dynamic>.from(item))).toList();
  }

  @override
  Future<void> saveSentEmails({required SentEmail email}) async {
    final box = appStorage.appBox;
    // Fetch existing emails
    List<SentEmail> existingEmails = getSentEmails();
    existingEmails.add(email);

    // Store updated list
    await box?.put(sentEmailsKey, existingEmails.map((e) => e.toJson()).toList());
  }
}
