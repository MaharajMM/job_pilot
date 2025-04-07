import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_pilot/features/login/state/login_state.dart';

class LoginNotifier extends AutoDisposeAsyncNotifier<LoginState> {
  @override
  FutureOr<LoginState> build() {
    return const InitialLoginState();
  }

  Future<void> loginUser({
    required String email,
    required String password,
    required void Function() onLoginUser,
    required void Function(Object error) onLoginError,
  }) async {
    state = const AsyncData(LoadingLoginState());
    state = await AsyncValue.guard(() async {
      try {
        final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
        // Firebase authentication
        await firebaseAuth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );

        // User logged in successfully
        onLoginUser();

        return const LoginSuccessState();
      } catch (error) {
        onLoginError(error);

        return LoginErrorState(error.toString());
      }
    });
  }
}
