import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_pilot/features/sign_up/controller/signup_pod.dart';
import 'package:job_pilot/features/sign_up/state/signup_state.dart';
import 'package:job_pilot/shared/riverpod_ext/asynvalue_easy_when.dart';
import 'package:job_pilot/shared/widget/buttons/app_primary_btn.dart';

class SignUpButton extends ConsumerWidget {
  final VoidCallback onSubmit;
  const SignUpButton({super.key, required this.onSubmit});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final signUpAsync = ref.watch(signUpUserProvider);

    return signUpAsync.easyWhen(
      data: (signUpState) {
        return switch (signUpState) {
          InitialSignUpState() => PrimaryButton(
              labelText: 'Sign Up',
              onPressed: () {
                onSubmit();
              }),
          LoadingSignUpState() => const PrimaryButton(
              labelText: 'Signing Up...',
              onPressed: null,
              isLoading: true,
            ),
          SignUpSuccessState() => PrimaryButton(
              labelText: 'Continue',
              onPressed: () {},
            ),
          SignUpErrorState() => PrimaryButton(
              labelText: 'Retry',
              onPressed: onSubmit,
            ),
        };
      },
    );
  }
}
