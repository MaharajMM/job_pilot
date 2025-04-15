import 'dart:io';

import 'package:job_pilot/shared/exception/app_exception.dart';
import 'package:multiple_result/multiple_result.dart';

abstract class IEmailRepository {
  Future<Result<bool, AppException>> saveEmailDetails({
    required String subject,
    required String name,
    required String email,
    required String body,
    File? attachment,
  });
}
