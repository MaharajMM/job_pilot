// ignore_for_file: public_member_api_docs, sort_constructors_first

sealed class LoginState {
  const LoginState();
}

class InitialLoginState implements LoginState {
  const InitialLoginState();
}

class LoadingLoginState implements LoginState {
  const LoadingLoginState();
}

class LoginSuccessState implements LoginState {
  const LoginSuccessState();
}

class LoginErrorState implements LoginState {
  final String message;

  const LoginErrorState(this.message);

  @override
  bool operator ==(covariant LoginErrorState other) {
    if (identical(this, other)) return true;

    return other.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}
