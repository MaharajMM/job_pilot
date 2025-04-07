import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_pilot/features/sign_up/controller/notifier/signup_notifier.dart';
import 'package:job_pilot/features/sign_up/state/signup_state.dart';

final signUpUserProvider = AsyncNotifierProvider.autoDispose<SignUpFormNotifier, SignUpState>(
  SignUpFormNotifier.new,
);
