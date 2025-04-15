import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_pilot/features/email_onboard/controller/email_onboard_pod.dart';
import 'package:job_pilot/features/email_onboard/controller/state/email_onboard_state.dart';
import 'package:job_pilot/shared/riverpod_ext/asynvalue_easy_when.dart';
import 'package:job_pilot/shared/widget/buttons/app_primary_btn.dart';

class EmailOnboardSaveButton extends ConsumerWidget {
  final VoidCallback onSubmit;
  const EmailOnboardSaveButton({super.key, required this.onSubmit});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailOnboardFormAsync = ref.watch(emailControllerProvider);

    return emailOnboardFormAsync.easyWhen(
      data: (addFoodFormState) {
        return switch (addFoodFormState) {
          InitialEmailOnboardForm() => PrimaryButton(
              labelText: 'Save & Continue',
              onPressed: onSubmit,
            ),
          OnboardingEmailState() => const PrimaryButton(
              labelText: 'Saving',
              onPressed: null,
              isLoading: true,
            ),
          EmailOnboardFormSuccess() => PrimaryButton(
              labelText: 'Saved',
              onPressed: () {},
            ),
          EmailOnboardFormError() => PrimaryButton(
              labelText: 'Retry',
              onPressed: onSubmit,
            ),
        };
      },
    );
  }
}
