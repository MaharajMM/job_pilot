import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:job_pilot/features/authentication/view/widgets/auth_form.dart';

class AuthFormView extends StatelessWidget {
  final FocusNode? nameFocusNode;
  final FocusNode? emailFocusNode;
  final FocusNode? passwordFocusNode;
  final bool isSignUp;
  final Widget authBtn;
  final GlobalKey<FormBuilderState> formKey;
  const AuthFormView({
    super.key,
    this.nameFocusNode,
    this.emailFocusNode,
    this.passwordFocusNode,
    required this.isSignUp,
    required this.authBtn,
    required this.formKey,
  });

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: formKey,
      child: AuthForm(
        authBtn: authBtn,
        emailFocusNode: emailFocusNode,
        nameFocusNode: nameFocusNode,
        passwordFocusNode: passwordFocusNode,
        isSignUp: isSignUp,
      ),
    );
  }
}
