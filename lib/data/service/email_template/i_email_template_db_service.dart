import 'package:job_pilot/data/models/email_template_model.dart';

abstract class IEmailTemplateDbService {
  Future<void> saveEmailTemplate({required EmailTemplateModel emailTemplate});
  Future<void> deleteEmailTemplate();
  EmailTemplateModel? getEmailTemplate();
}
