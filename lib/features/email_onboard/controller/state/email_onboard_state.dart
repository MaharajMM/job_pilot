sealed class EmailOnboardFormState {
  const EmailOnboardFormState();
}

class InitialEmailOnboardForm implements EmailOnboardFormState {
  const InitialEmailOnboardForm();
}

class OnboardingEmailState implements EmailOnboardFormState {
  const OnboardingEmailState();
}

class EmailOnboardFormSuccess implements EmailOnboardFormState {
  const EmailOnboardFormSuccess();
}

class EmailOnboardFormError implements EmailOnboardFormState {
  final String message;

  const EmailOnboardFormError(this.message);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is EmailOnboardFormError && other.message == message;
  }

  @override
  int get hashCode => message.hashCode;

  @override
  String toString() => 'EmailOnboardFormError(message: $message)';
}
