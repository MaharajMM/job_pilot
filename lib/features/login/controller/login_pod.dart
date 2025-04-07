import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_pilot/features/login/controller/notifier/login_notifier.dart';
import 'package:job_pilot/features/login/state/login_state.dart';

final loginUserProvider = AsyncNotifierProvider.autoDispose<LoginNotifier, LoginState>(
  LoginNotifier.new,
);
