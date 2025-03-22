import 'package:job_pilot/core/local_storage/app_storage.dart';
import 'package:job_pilot/data/models/email_template_model.dart';

import 'i_email_template_db_service.dart';

class EmailTemplateDbService implements IEmailTemplateDbService {
  final AppStorage appStorage;
  EmailTemplateDbService({
    required this.appStorage,
  });

  final emailTemplateKey = 'emailTemplate';
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
}
