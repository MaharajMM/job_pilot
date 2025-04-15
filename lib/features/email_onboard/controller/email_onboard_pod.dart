import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_pilot/features/email_onboard/controller/notifier/email_onboard_notifier.dart';
import 'package:job_pilot/features/email_onboard/controller/state/email_onboard_state.dart';

final emailControllerProvider =
    AsyncNotifierProvider.autoDispose<EmailOnboardFormNotifier, EmailOnboardFormState>(
  EmailOnboardFormNotifier.new,
);
