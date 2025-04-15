import 'dart:async';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_pilot/data/repository/email/email_repository_pod.dart';
import 'package:job_pilot/features/email_onboard/controller/state/email_onboard_state.dart';

class EmailOnboardFormNotifier extends AutoDisposeAsyncNotifier<EmailOnboardFormState> {
  @override
  FutureOr<EmailOnboardFormState> build() {
    return const InitialEmailOnboardForm();
  }

  Future<void> saveEmailDetails({
    required String name,
    required String emailId,
    required String subject,
    required String body,
    File? attachment,
    required void Function() onSavedEmail,
  }) async {
    state = const AsyncData(OnboardingEmailState());
    state = await AsyncValue.guard(() async {
      final result = await ref.watch(emailRepoProvider).saveEmailDetails(
            name: name,
            email: emailId,
            body: body,
            subject: subject,
            attachment: attachment,
          );

      return result.when((isSaveddata) {
        onSavedEmail();
        return const EmailOnboardFormSuccess();
      }, (error) => EmailOnboardFormError(error.message));
    });
  }
}
