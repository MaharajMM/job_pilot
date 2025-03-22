import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_pilot/core/local_storage/app_storage_pod.dart';
import 'package:job_pilot/data/service/email_template/email_template_db_service.dart';

final emailTemplateDbProvider = Provider.autoDispose<EmailTemplateDbService>(
  (ref) {
    return EmailTemplateDbService(appStorage: ref.watch(appStorageProvider));
  },
);
