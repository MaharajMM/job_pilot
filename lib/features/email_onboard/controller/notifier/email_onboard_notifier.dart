import 'dart:async';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_pilot/data/models/email_template_model.dart';
import 'package:job_pilot/data/models/user_model.dart';
import 'package:job_pilot/data/service/email_template/email_template_db_service_pod.dart';
import 'package:job_pilot/data/service/user_profile/user_profile_db_service_pod.dart';
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
      try {
        // Upload attachment if exists
        // String? attachmentUrl;
        // if (attachment != null) {
        //   attachmentUrl = attachment.path;
        // }

        final userProfile = UserProfile(primaryEmail: emailId, name: name);

        final updatedTemplate = EmailTemplateModel(
          subject: subject.trim(),
          body: body.trim(),
          attachmentPath: attachment?.path,
        );

        await Future.wait(
          [
            ref.read(userProfileDbProvider).saveUserProfile(userProfile: userProfile),
            ref.read(emailTemplateDbProvider).saveEmailTemplate(emailTemplate: updatedTemplate),
          ],
          eagerError: true,
        );
        onSavedEmail();
        return const EmailOnboardFormSuccess();
      } catch (error) {
        return EmailOnboardFormError(error.toString());
      }
    });
  }
}
