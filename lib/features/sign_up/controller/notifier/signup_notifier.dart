import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_pilot/features/sign_up/state/signup_state.dart';

class SignUpFormNotifier extends AutoDisposeAsyncNotifier<SignUpState> {
  @override
  FutureOr<SignUpState> build() {
    return const InitialSignUpState();
  }

  Future<void> registerUser({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
    required void Function() onRegisterUser,
    required void Function(Object error) onRegisterError,
  }) async {
    state = const AsyncData(LoadingSignUpState());
    state = await AsyncValue.guard(() async {
      try {
        final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
        // Firebase authentication
        await firebaseAuth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        // User logged in successfully
        onRegisterUser();

        return const SignUpSuccessState();
      } catch (error) {
        onRegisterError(error);

        return SignUpErrorState(error.toString());
      }
    });
  }
}
