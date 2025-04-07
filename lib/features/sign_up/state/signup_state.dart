// ignore_for_file: public_member_api_docs, sort_constructors_first

sealed class SignUpState {
  const SignUpState();
}

class InitialSignUpState implements SignUpState {
  const InitialSignUpState();
}

class LoadingSignUpState implements SignUpState {
  const LoadingSignUpState();
}

class SignUpSuccessState implements SignUpState {
  const SignUpSuccessState();
}

class SignUpErrorState implements SignUpState {
  final String message;

  const SignUpErrorState(this.message);

  @override
  bool operator ==(covariant SignUpErrorState other) {
    if (identical(this, other)) return true;

    return other.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}
