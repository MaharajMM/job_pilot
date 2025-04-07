import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_pilot/features/login/controller/login_pod.dart';
import 'package:job_pilot/features/login/state/login_state.dart';
import 'package:job_pilot/shared/riverpod_ext/asynvalue_easy_when.dart';
import 'package:job_pilot/shared/widget/buttons/app_primary_btn.dart';

class Loginutton extends ConsumerWidget {
  final VoidCallback onSubmit;
  const Loginutton({super.key, required this.onSubmit});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginAsync = ref.watch(loginUserProvider);

    return loginAsync.easyWhen(
      data: (loginState) {
        return switch (loginState) {
          InitialLoginState() => PrimaryButton(
              labelText: 'Login',
              onPressed: () {
                onSubmit();
              }),
          LoadingLoginState() => const PrimaryButton(
              labelText: 'Logging in...',
              onPressed: null,
              isLoading: true,
            ),
          LoginSuccessState() => PrimaryButton(
              labelText: 'Verified',
              onPressed: () {},
            ),
          LoginErrorState() => PrimaryButton(
              labelText: 'Retry',
              onPressed: onSubmit,
            ),
        };
      },
    );
  }
}
